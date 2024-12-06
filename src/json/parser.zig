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
/// const me = me_result.object;
/// const id = me.id;
/// const first_name = me.first_name;
/// ```
pub fn ParsedResult(comptime T: type) type {
    return struct {
        data: []u8,
        object: T,
        result: Result(T),
        allocator: std.mem.Allocator,

        const Self = @This();

        pub fn deinit(self: *Self) void {
            self.allocator.free(self.data);
        }

        pub fn init(_allocator: std.mem.Allocator, _result: Result(T), _data: []u8) Self {
            return Self{ .data = _data, .result = _result, .allocator = _allocator, .object = _result.result.? };
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
        const parsed = std.json.parseFromSlice(Result(T), self.allocator, json_str, .{}) catch |e| {
            std.log.err("Error on json parsing: {any}", .{e});
            return e;
        };
        defer parsed.deinit();

        if (!parsed.value.ok) {
            std.log.err("Telegram Bot API error. Code: {d}. Description: {s}", .{ parsed.value.error_code.?, parsed.value.description.? });
            return api_error.fromErrorCode(parsed.value.error_code.?, parsed.value.description.?);
        } else {
            return ParsedResult(T).init(self.allocator, parsed.value, json_str);
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
