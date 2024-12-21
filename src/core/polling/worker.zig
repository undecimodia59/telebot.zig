const std = @import("std");
const Bot = @import("../bot.zig").Bot;
const Update = @import("../../types/Update.zig").Update;
const HandlingType = @import("../handler/handling_type.zig").HandlingType;
const HandlingTypeFromUpdate = @import("../handler/handling_type.zig").HandlingTypeFromUpdate;

pub const Worker = struct {
    id: u8,
    receiver: std.Thread.Channel(*Update), // Channel to receive pointers to updates
    handle: ?std.Thread.Thread = null,
    stop_on_error: bool,
    owner: *Bot,

    pub fn init(id: u8, owner: *Bot, stop_on_error: bool) Worker {
        const channel = std.Thread.Channel(*Update).init();
        return Worker{
            .id = id,
            .receiver = channel,
            .handle = null,
            .stop_on_error = stop_on_error,
            .owner = owner,
        };
    }

    pub fn start(self: *Worker) !void {
        self.handle = try std.Thread.spawn(.{}, Worker.thread_main, self);
    }

    fn thread_main(worker_ptr: *Worker) void {
        while (true) {
            const update_ptr = worker_ptr.receiver.recv() orelse break;
            if (update_ptr == null) break; // Channel closed

            const update = update_ptr.*;

            // Assign the owner to the update
            update._bot = worker_ptr.owner;

            // Determine the type of the update
            const update_type = Worker.determine_type(&update);

            // Fetch the handler from the router
            const handler_opt = worker_ptr.owner.router.?.get(update_type);
            if (handler_opt) |handler| {
                const result = handler(update);
                if (result) |err| {
                    if (worker_ptr.stop_on_error) {
                        std.debug.print("Worker {} encountered error: {}\n", .{ worker_ptr.id, err });
                        // Here, you might want to signal the Poller to stop
                        // This can be done via another channel or shared variable
                        // For simplicity, we'll just break the loop
                        break;
                    } else {
                        std.debug.print("Worker {} encountered error: {}\n", .{ worker_ptr.id, err });
                        // Continue processing other updates
                    }
                }
            } else {
                std.debug.print("Worker {}: No handler for update type {}\n", .{ worker_ptr.id, update_type });
            }
        }
    }

    // Placeholder for determining the update type
    fn determine_type(update: *Update) HandlingType {
        return HandlingTypeFromUpdate(update.*);
    }

    pub fn send_update(self: *Worker, update: *Update) !void {
        try self.receiver.send(update);
    }

    pub fn join(self: *Worker) void {
        if (self.handle) |h| {
            h.join() catch {};
        }
    }
};
