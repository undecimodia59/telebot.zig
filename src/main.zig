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

    // try printMe(&bot);
    // try sendTestMessage(&bot);
    // try forwardTestMessage(&bot);
    // try forwardTestMessages(&bot);
}

fn printMe(bot: *Bot) !void {
    var me_res = try bot.getMe();
    defer me_res.deinit();

    const me = me_res.data;
    std.debug.print("Hi! Im bot on zig! My name is {s} (@{s}). My id: {d}\n", .{ me.first_name, me.username.?, me.id });
}

fn sendTestMessage(bot: *Bot) !void {
    var msg = try bot.sendMessage(.{ .chat_id = TEST_RECEIVER, .text = "Hi from zig!" });
    defer msg.deinit();

    const m = msg.data;
    const username = m.chat.username orelse "NoUsername";
    const name = m.chat.first_name orelse "NoFirstName";
    // Read of msg brokes when emoji in there
    // TODO: Fix this issue
    // UPD: Problem with unicode. Same issue: https://ziggit.dev/t/unicode-utf-8-decoding-and-json-parsing-issues/6327
    std.debug.print("I have sent message with id: {d} for {s} (@{s})\n", .{ m.message_id, name, username });
    var data = std.ArrayList(u8).init(std.heap.page_allocator);
    try std.fmt.format(data.writer(), "Hello, {s} (@{s})", .{ name, username });
    var m2 = try bot.sendMessage(.{ .chat_id = TEST_RECEIVER, .text = data.allocatedSlice() });
    defer m2.deinit();
}

fn forwardTestMessage(bot: *Bot) !void {
    const real_text = "LA-LA-LA";
    var msg1 = try bot.sendMessage(.{ .chat_id = TEST_RECEIVER, .text = real_text });
    defer msg1.deinit();
    const mid = msg1.data.message_id;

    var msg2 = try bot.forwardMessage(.{ .chat_id = TEST_RECEIVER, .from_chat_id = TEST_RECEIVER, .message_id = mid });
    defer msg2.deinit();
    const text = msg2.data.text orelse "no text";
    std.debug.print("Forwarded message text: {s} (expected: {s})\n", .{ text, real_text });
}

fn forwardTestMessages(bot: *Bot) !void {
    var m_ids: [2]i64 = undefined;
    var msg1 = try bot.sendMessage(.{ .chat_id = TEST_RECEIVER, .text = "MSG1" });
    defer msg1.deinit();
    m_ids[0] = msg1.data.message_id;

    var msg2 = try bot.sendMessage(.{ .chat_id = TEST_RECEIVER, .text = "MSG2" });
    defer msg2.deinit();
    m_ids[1] = msg2.data.message_id;

    var forwarded = try bot.forwardMessages(.{ .chat_id = TEST_RECEIVER, .message_ids = &m_ids, .from_chat_id = TEST_RECEIVER });
    defer forwarded.deinit();

    for (forwarded.data, 0..) |mid, i| {
        std.debug.print("{d} + 2 == {d} \n", .{ m_ids[i], mid.message_id });
    }
}
