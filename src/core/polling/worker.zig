const std = @import("std");
const Update = @import("../../types/Update.zig").Update;
const HandlingType = @import("../handler/handling_type.zig").HandlingType;
const HandlingTypeFromUpdate = @import("../handler/handling_type.zig").HandlingTypeFromUpdate;
const Channel = @import("channel.zig").Channel;
const Router = @import("../handler/handlers.zig").Router;
const RouterFnType = @import("../handler/handling_values.zig").RouterFnType;

const WorkItem = struct {
    allocator: std.mem.Allocator,
    update: *const Update,
};

pub const Worker = struct {
    id: u8,
    receiver: Channel(WorkItem), // Channel to receive update + allocator
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
            .receiver = Channel(WorkItem).init(allocator, channel_capacity),
            .handle = null,
            .router = router,
            .notify_processed = notify_processed,
        };
    }

    pub fn getChannel(self: *Worker) *Channel(WorkItem) {
        return &self.receiver;
    }

    pub fn start(self: *Worker) !void {
        self.handle = try std.Thread.spawn(.{}, Worker.poller, .{self});
    }

    pub fn deinit(self: *Worker, allocator: std.mem.Allocator) void {
        self.receiver.deinit(allocator);
    }

    fn poller(worker_ptr: *Worker) !void {
        while (true) {
            const item = worker_ptr.receiver.receive();
            if (worker_ptr.get_handling_by_update(item.update.*)) |handler| {
                handler(item.allocator, item.update.*) catch |e| {
                    std.log.err("Error on user-defined handler: {any}", .{e});
                };
            }
            // Notify Poller that processing is done
            worker_ptr.notify_processed();
        }
    }

    fn get_handling_by_update(self: *Worker, update: Update) ?RouterFnType {
        const hType = HandlingTypeFromUpdate(update);
        return self.router.get(hType);
    }
};
