const std = @import("std");
const types = @import("../types/types.zig");
const params = @import("parameters/parameters.zig");
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
    jsonifier: json.Jsonifier,

    const Self = @This();

    pub fn init(allocator: std.mem.Allocator, token: []const u8) Self {
        const http_client = HTTP.init(allocator);
        const jsonifier = json.Jsonifier.init(allocator);
        return Self{ .allocator = allocator, .token = token, .http_client = http_client, .jsonifier = jsonifier };
    }
    pub fn deinit(self: *Self) void {
        self.http_client.deinit();
    }

    /// A simple method for testing your bot's authentication token. Requires no parameters.
    /// Returns basic information about the bot in form of a User object.
    pub fn getMe(self: *Self) !json.ParsedResult(types.User) {
        return try self.inner(types.User, "getMe");
    }

    /// Use this method to send text messages. On success, the sent Message is returned.
    pub fn sendMessage(self: *Self, options: params.sendMessageParams) !json.ParsedResult(types.Message) {
        return try self.innerWithBody(types.Message, params.sendMessageParams, "sendMessage", options);
    }

    /// Use this method to forward messages of any kind.
    /// Service messages and messages with protected content can't be forwarded.
    /// On success, the sent Message is returned.
    pub fn forwardMessage(self: *Self, options: params.forwardMessageParams) !json.ParsedResult(types.Message) {
        return try self.innerWithBody(types.Message, params.forwardMessageParams, "forwardMessage", options);
    }

    // Private methods

    fn inner(self: *Self, comptime T: type, method: []const u8) !json.ParsedResult(T) {
        const url = try self.buildUrl(method);
        defer self.allocator.free(url);

        const response_json = try self.baseRequest(url, null);

        const result = try self.jsonifier.ObjectFromJson(T, response_json);
        return result;
    }

    /// T - type of expected result
    /// T2 - type of body
    fn innerWithBody(self: *Self, comptime T: type, comptime T2: type, method: []const u8, body: ?T2) !json.ParsedResult(T) {
        const url = try self.buildUrl(method);
        defer self.allocator.free(url);

        const body_json: []const u8 = if (body) |bytes| try self.jsonifier.JsonFromObject(T2, bytes) else "{}";
        defer self.allocator.free(body_json);

        const response_json = try self.baseRequest(url, body_json);

        const result = try self.jsonifier.ObjectFromJson(T, response_json);
        return result;
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

    fn baseRequest(self: *Self, url: []u8, body_json: ?[]const u8) ![]u8 {
        if (body_json) |body| {
            return try self.http_client.makePostRequest(url, body);
        } else {
            return try self.http_client.makeRequest(url);
        }
    }
};
