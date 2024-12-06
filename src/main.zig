const std = @import("std");
const Bot = @import("core/bot.zig").Bot;
const TOKEN = @import("config.zig").TOKEN;

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
    const me = try bot.getMe();
    std.debug.print("Hi! Im bot on zig! My name if {s} (@{s}). My id: {d}\n", .{ me.first_name, me.username.?, me.id });
}
