const std = @import("std");
const Bot = @import("core/bot.zig").Bot;
const cfg = @import("config.zig");
const TOKEN = cfg.TOKEN;
const TEST_RECEIVER = cfg.TEST_RECEIVER;

const Keyboard = @import("types/types.zig").Keyboard;
const InlineKeyboardMarkup = Keyboard.InlineKeyboardMarkup;
const InlineKeyboardButton = Keyboard.InlineKeyboardButton;

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
    var inlineKb = try buildKeyboard(gpa.allocator());
    const json = try inlineKb.toReplyMarkup();
    defer gpa.allocator().free(json);

    var m = try bot.sendMessage(.{ .chat_id = TEST_RECEIVER, .text = "Testing keyboard!", .reply_markup = json });
    defer m.deinit();
}

fn buildKeyboard(allocator: std.mem.Allocator) !InlineKeyboardMarkup {
    var inlineKb = InlineKeyboardMarkup.init(allocator);
    try inlineKb.addRow(&[_]InlineKeyboardButton{
        .{ .text = "Row 1 Button 1", .callback_data = "callback" },
        .{ .text = "Row 1 Button 2", .url = "https://duckduckgo.com/" },
    });
    try inlineKb.addRow(&[_]InlineKeyboardButton{
        .{ .text = "Row 2 Button 1", .web_app = .{ .url = "https://spreadprivacy.com/" } },
    });
    return inlineKb;
}
