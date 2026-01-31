const std = @import("std");
const root = @import("root.zig");
const Bot = root.Bot;
const ApiError = root.ApiError;
const Update = root.Update;
const TOKEN = root.TOKEN;
const HandlingType = root.HandlingType;
const Router = root.Router;
const ParsedResult = root.ParsedResult;
const Message = root.types.Message;

pub fn main() !void {
    const router = comptime route: {
        var r = Router.init();
        r.add(HandlingType.MessageText, text_handler);
        r.add(HandlingType.MessageCommand, cmd_handler);
        r.add(HandlingType.MessagePhoto, pic_handler);
        break :route r;
    };

    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer {
        const isLeak = gpa.detectLeaks();
        std.debug.print("isLeak: {}\n", .{isLeak});
        const check = gpa.deinit();
        std.debug.print("Status: {any}\n", .{check});
    }

    const allocator = gpa.allocator();
    var bot = Bot.init(allocator, TOKEN, router);
    defer bot.deinit();
    try bot.longPolling(allocator, 2, 200, true, .{});
}

fn text_handler(allocator: std.mem.Allocator, u: Update) !void {
    const chat = u.message.?.chat.id;
    const mid = u.message.?.message_id;
    var m = try u._bot.?.copyMessage(allocator, .{ .chat_id = chat, .from_chat_id = chat, .message_id = mid });
    m.deinit(allocator);
}

fn pic_handler(allocator: std.mem.Allocator, u: Update) !void {
    var m = try u.reply(allocator, .{ .chat_id = 0, .text = "Oh! Cute pic you have there!" });
    m.deinit(allocator);
}

fn cmd_handler(allocator: std.mem.Allocator, u: Update) !void {
    var m: ParsedResult(Message) = undefined;
    if (std.mem.eql(u8, u.message.?.text.?, "/love")) {
        m = try u.reply(allocator, .{ .chat_id = 0, .text = "I love you too!" });
    } else {
        m = try u.reply(allocator, .{ .chat_id = 0, .text = "I don't know this command!" });
    }
    m.deinit(allocator);
}
