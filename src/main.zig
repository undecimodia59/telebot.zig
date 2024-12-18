const std = @import("std");
const Bot = @import("core/bot.zig").Bot;
const cfg = @import("config.zig");
const TOKEN = cfg.TOKEN;
const TEST_RECEIVER = cfg.TEST_RECEIVER;

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer {
        const isLeak = gpa.detectLeaks();
        std.debug.print("isLeak: {}\n", .{isLeak});
        const check = gpa.deinit();
        std.debug.print("Status: {any}\n", .{check});
    }

    var bot = Bot.init(gpa.allocator(), TOKEN);
    defer bot.deinit();

    var updates = try bot.getUpdates(.{});
    defer updates.deinit();
    for (updates.data) |update| {
        if (update.message) |msg| {
            std.debug.print(
                "Received message №{d} ({d}) from {s} with text: {?s}\n",
                .{ msg.message_id, update.update_id, msg.from.?.first_name, msg.text },
            );
        }
    }
}
