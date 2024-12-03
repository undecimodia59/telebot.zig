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

    const Self = @This();

    pub fn init(allocator: std.mem.Allocator, token: []const u8) Bot{
        return Bot{.allocator = allocator, .token = token};
    }
    pub fn deinit(self: *Self) void {
        // Placeholder for now
        _ = self;
    }

    /// A simple method for testing your bot's authentication token. Requires no parameters.
    /// Returns basic information about the bot in form of a User object.
    pub fn getMe(self: Self) !types.User {
        const resp = try self.baseRequest("getMe");
        const result = try json.Json(types.User, resp, self.allocator);
        return result.result.?;
    }

    fn buildUrl(self: Self, method: []const u8) ![]u8 {
        var final_url = ArrayList(u8).init(self.allocator);
        try final_url.appendSlice(BASE_API_URL);
        try final_url.appendSlice(self.token);
        try final_url.append('/');
        try final_url.appendSlice(method);

        const result = try final_url.toOwnedSlice();
        return result;
    }

    fn baseRequest(self: Self, method: []const u8) ![]u8 {
        const url = try self.buildUrl(method);
        return HTTP.make_request(self.allocator, url);
    }
};
