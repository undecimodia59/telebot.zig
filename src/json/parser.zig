const std = @import("std");
const api_error = @import("error.zig");

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

/// T should be deallocated!
pub fn Json(comptime T: type, json_str: []u8, allocator: std.mem.Allocator) api_error.ApiError!Result(T) {
    std.log.debug("Json received json: {s}", .{json_str});
    const parsed = std.json.parseFromSlice(
        Result(T), allocator, json_str, .{}
    ) catch |e| {
        std.log.err("Error on json parsing: {any}", .{e});
        std.process.exit(1);
    };
    defer parsed.deinit();

    const object: Result(T) = Result(T){
        .ok = parsed.value.ok,
        .description = parsed.value.description,
        .error_code = parsed.value.error_code,
        .parameters = parsed.value.parameters,
        .result = parsed.value.result
    };
    if (!object.ok) {
        std.log.err("Telegram Bot API error. Code: {d}. Description: {s}",
            .{object.error_code.?, object.description.?});
        return api_error.fromErrorCode(object.error_code.?, object.description.?);
    } else {
        return object;
    }
}
