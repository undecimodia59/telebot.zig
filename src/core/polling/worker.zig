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
    receiver: Channel(*Update), // Channel to receive pointers to updates
    handle: ?std.Thread.Thread = null,
    err_handler: *bool,
    router: Router,

    const Self = @This();

    pub fn init(id: u8, allocator: std.mem.Allocator, channel_capacity: usize, router: Router) Worker {
        const channel = Channel(*Update).init(allocator, channel_capacity);
        return Worker{
            .id = id,
            .receiver = channel,
            .handle = null,
            .router = router,
        };
    }

    pub fn start(self: Self) !void {
        self.handle = std.Thread.spawn(.{}, self.poller, .{self});
    }

    fn poller(self: Self) !void {
        while (true) {
            const update = self.receiver.receive();
            if (self.get_handling_by_update(update)) |f| {
                f(update) catch |e| {
                    std.log.err("Error on polling: {any}", .{e});
                };
            }
        }
    }

    fn get_handling_by_update(self: Self, update: Update) ?fn (Update) ApiError!void {
        const hType = HandlingTypeFromUpdate(update);
        return self.router.get(hType);
    }
};
