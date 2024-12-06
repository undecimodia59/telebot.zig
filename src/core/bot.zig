const std = @import("std");
const types = @import("../types/types.zig");
const json = @import("../json/parser.zig");
const HTTP = @import("../http/client.zig").HTTP;
const ArrayList = std.ArrayList;

const BASE_API_URL = "https://api.telegram.org/bot";

/// Main class for whole lib
/// Used for sending, filtering and accepting messages
pub const Bot = struct {
    token: []const u8,
    allocator: std.mem.Allocator,
    http_client: HTTP,

    const Self = @This();

    pub fn init(allocator: std.mem.Allocator, token: []const u8) Bot {
        const http_client = HTTP.init(allocator);
        return Bot{ .allocator = allocator, .token = token, .http_client = http_client };
    }
    pub fn deinit(self: *Self) void {
        self.http_client.deinit();
    }

    /// A simple method for testing your bot's authentication token. Requires no parameters.
    /// Returns basic information about the bot in form of a User object.
    pub fn getMe(self: *Self) !types.User {
        return try self.inner(types.User, "getMe");
    }

    // Private methods

    fn inner(self: *Self, comptime T: type, method: []const u8) !T {
        const url = try self.buildUrl(method);
        defer self.allocator.free(url);

        // Here's fucking leak, but json somehow uses this in runtime
        // and free of this memory cause Use-After-Free...
        const response_json = try self.baseRequest(url);

        const result = try json.Json(T, response_json, self.allocator);
        return result.result.?;
    }

    fn buildUrl(self: Self, method: []const u8) ![]u8 {
        var final_url = ArrayList(u8).init(self.allocator);
        defer final_url.deinit();

        try final_url.appendSlice(BASE_API_URL);
        try final_url.appendSlice(self.token);
        try final_url.append('/');
        try final_url.appendSlice(method);

        return try final_url.toOwnedSlice();
    }

    fn baseRequest(self: *Self, url: []u8) ![]u8 {
        return self.http_client.make_request(url);
    }
};
