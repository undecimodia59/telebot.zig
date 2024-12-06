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

    try printMe(&bot);
    try sendTestMessage(&bot);
}

fn printMe(bot: *Bot) !void {
    var me_res = try bot.getMe();
    defer me_res.deinit();

    const me = me_res.object;
    std.debug.print("Hi! Im bot on zig! My name is {s} (@{s}). My id: {d}\n", .{ me.first_name, me.username.?, me.id });
}

fn sendTestMessage(bot: *Bot) !void {
    var msg = try bot.sendMessage(.{ .chat_id = TEST_RECEIVER, .text = "Hi from zig!" });
    defer msg.deinit();

    const m = msg.object;
    const username = m.chat.username orelse "NoUsername";
    const name = m.chat.first_name orelse "NoFirstName";
    // Read of msg brokes when emoji in there
    // TODO: Fix this issue
    std.debug.print("I have sent message with id: {d} for {s} (@{s})\n", .{ m.message_id, name, username });
}
