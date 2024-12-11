const std = @import("std");
const api_error = @import("../core/error.zig");
const ArrayList = std.ArrayList;

pub fn Result(comptime T: type) type {
    return struct {
        ok: bool,
        /// Result will be not null if ok == true
        result: ?T = null,
        /// Error code from api.telegram.org
        error_code: ?i32 = null,
        /// If error occurs, description will store here
        description: ?[]u8 = null,
        /// Parameters, like retry_after and etc.
        parameters: ?struct {
            retry_after: ?i32,
            migrate_to_chat_id: ?i64,
        } = null,
    };
}

/// To access T, user ParsedResult.object
/// ```zig
/// var me_result = try bot.getMe();
/// defer me_result.deinit();
/// const me = me_result.data;
/// const id = me.id;
/// const first_name = me.first_name;
/// ```
pub fn ParsedResult(comptime T: type) type {
    return struct {
        /// Your object stored here
        data: T,
        /// Pointer to result of json parsing
        parsed: std.json.Parsed(Result(T)),
        /// Received json in string
        json_str: []u8,
        allocator: std.mem.Allocator,

        const Self = @This();

        pub fn deinit(self: *Self) void {
            self.allocator.free(self.json_str);
            self.parsed.deinit();
        }

        pub fn init(allocator: std.mem.Allocator, parsed: std.json.Parsed(Result(T)), json_str: []u8, data: T) Self {
            return Self{ .allocator = allocator, .parsed = parsed, .json_str = json_str, .data = data };
        }
    };
}

pub const Jsonifier = struct {
    allocator: std.mem.Allocator,

    const Self = @This();

    pub fn init(allocator: std.mem.Allocator) Self {
        return Self{ .allocator = allocator };
    }

    /// Cast json to T
    pub fn ObjectFromJson(self: Self, comptime T: type, json_str: []u8) !ParsedResult(T) {
        std.log.debug("Json received json: {s}", .{json_str});
        var parsed = std.json.parseFromSlice(Result(T), self.allocator, json_str, .{}) catch |e| {
            std.log.err("Error on json parsing: {any}", .{e});
            return e;
        };

        if (!parsed.value.ok) {
            std.log.err("Telegram Bot API error. Code: {d}. Description: {s}", .{ parsed.value.error_code.?, parsed.value.description.? });
            // Create error from parsed and then free parsed and return err to avoid leak
            const err = api_error.fromErrorCode(parsed.value.error_code.?, parsed.value.description.?);
            parsed.deinit();
            return err;
        } else {
            return ParsedResult(T).init(self.allocator, parsed, json_str, parsed.value.result.?);
        }
    }

    /// Cast T to json
    pub fn JsonFromObject(self: Self, comptime T: type, value: T) ![]u8 {
        var string = ArrayList(u8).init(self.allocator);
        try std.json.stringify(value, .{ .emit_null_optional_fields = false }, string.writer());
        std.log.debug("Json created: {s}", .{string.items});
        return try string.toOwnedSlice();
    }
};
