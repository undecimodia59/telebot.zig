const std = @import("std");
const Bot = @import("../bot.zig").Bot;
const Update = @import("../../types/Update.zig").Update;
const HandlingType = @import("../handler/handling_type.zig").HandlingType;
const HandlingTypeFromUpdate = @import("../handler/handling_type.zig").HandlingTypeFromUpdate;
const Channel = @import("channel.zig").Channel;
const Router = @import("../handler/handlers.zig").Router;
const ApiError = @import("../error.zig").ApiError;

pub const Worker = struct {
    id: u8,
    receiver: Channel(*const Update), // Channel to receive pointers to updates
    handle: ?std.Thread = null,
    router: Router,
    notify_processed: *const fn () void,

    pub fn init(
        id: u8,
        allocator: std.mem.Allocator,
        channel_capacity: usize,
        router: Router,
        notify_processed: *const fn () void,
    ) Worker {
        return Worker{
            .id = id,
            .receiver = Channel(*const Update).init(allocator, channel_capacity),
            .handle = null,
            .router = router,
            .notify_processed = notify_processed,
        };
    }

    pub fn getChannel(self: *Worker) *Channel(*const Update) {
        return &self.receiver;
    }

    pub fn start(self: *Worker) !void {
        self.handle = try std.Thread.spawn(.{}, Worker.poller, .{self});
    }

    fn poller(worker_ptr: *Worker) !void {
        while (true) {
            const update = worker_ptr.receiver.receive();
            if (worker_ptr.get_handling_by_update(update.*)) |handler| {
                handler(update.*) catch |e| {
                    std.log.err("Error on user-defined handler: {any}", .{e});
                };
            }
            // Notify Poller that processing is done
            worker_ptr.notify_processed();
        }
    }

    fn get_handling_by_update(self: *Worker, update: Update) ?*const fn (Update) ApiError!void {
        const hType = HandlingTypeFromUpdate(update);
        return self.router.get(hType);
    }
};
