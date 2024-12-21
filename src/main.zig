const std = @import("std");
const root = @import("root.zig");
const Bot = root.Bot;
const ApiError = root.ApiError;
const Update = root.Update;
const TOKEN = root.TOKEN;
const HandlingType = root.HandlingType;
const Router = root.Router;

pub fn main() !void {
    const router = comptime route: {
        var r = Router.init();
        r.add(HandlingType.ANY, any_handler);
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
    try getUpdates(&bot, true);
}

fn getUpdates(bot: *Bot, skip_updates: bool) !void {
    var last_update_id: i64 = 0;

    if (skip_updates) {
        var resp = try bot.getUpdates(.{});
        defer resp.deinit();
        if (resp.data.len != 0) last_update_id = resp.data[resp.data.len - 1].update_id + 1;
    }

    std.log.debug("Update skipped: {}. Last update id: {d}", .{ skip_updates, last_update_id });

    var iter: i32 = 0;
    while (iter < 30) : (iter += 1) {
        std.debug.print("Iter: {}\n", .{iter});
        var resp = bot.getUpdates(.{ .offset = last_update_id }) catch |e| {
            std.debug.print("Error on getUpdates: {any}", .{e});
            continue;
        };
        defer resp.deinit();

        for (resp.data) |update| {
            if (update.message) |msg| {
                std.debug.print("Got update message\n", .{});
                var m = try bot.copyMessage(.{
                    .chat_id = msg.chat.id,
                    .from_chat_id = msg.chat.id,
                    .message_id = msg.message_id,
                });
                m.deinit();
            }
            last_update_id = update.update_id + 1;
        }
        std.time.sleep(std.time.ns_per_s);
    }
}

fn any_handler(update: Update) ApiError!void {
    if (update.message) |msg| {
        _ = msg;
        std.debug.print("Got update message\n", .{});
        // var m = try bot.copyMessage(.{
        //     .chat_id = msg.chat.id,
        //     .from_chat_id = msg.chat.id,
        //     .message_id = msg.message_id,
        // });
        // m.deinit();
    }
}
