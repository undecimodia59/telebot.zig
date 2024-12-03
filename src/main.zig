const std = @import("std");
const Bot = @import("core/bot.zig").Bot;
const TOKEN = @import("config.zig").TOKEN;

pub fn main() !void {
    const bot = Bot.init(std.heap.page_allocator, TOKEN);
    const me = try bot.getMe();
    std.debug.print("Bot '{s}' started @{s} ({d})", .{me.first_name, me.username.?, me.id});
}
