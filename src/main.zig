const std = @import("std");
const root = @import("root.zig");
const Bot = root.Bot;
const ApiError = root.ApiError;
const Update = root.Update;
const TOKEN = root.TOKEN;
const HandlerType = root.HandlerType;
const Router = root.Router;

pub fn main() !void {
    const router = comptime route: {
        var r = Router.init();
        r.add(HandlerType.ANY, any_handler);
        break :route r;
    };

    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer {
        const isLeak = gpa.detectLeaks();
        std.debug.print("isLeak: {}\n", .{isLeak});
        const check = gpa.deinit();
        std.debug.print("Status: {any}\n", .{check});
    }

    var bot = Bot.init(gpa.allocator(), TOKEN, router);
    defer bot.deinit();
    try bot.router.?.get(HandlerType.ANY).?(Update{ .update_id = 777 });
}

fn any_handler(update: Update) ApiError!void {
    std.debug.print("Got update with id: {d}\n", .{update.update_id});
}
