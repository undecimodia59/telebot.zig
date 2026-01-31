const std = @import("std");
const types = @import("../types/types.zig");
const params = @import("parameters/parameters.zig");
const json = @import("../json/parser.zig");
const Router = @import("handler/handlers.zig").Router;
const HTTP = @import("../http/client.zig").HTTP;
const Poller = @import("polling/poller.zig").Poller;
const ArrayList = std.ArrayList;

const BASE_API_URL = "https://api.telegram.org/bot";

/// Main class for whole lib
/// Used for sending, filtering and accepting messages
pub const Bot = struct {
    token: []const u8,
    http_client: HTTP,
    router: ?Router,

    const Self = @This();

    pub fn init(allocator: std.mem.Allocator, token: []const u8, router: ?Router) Self {
        const http_client = HTTP.init(allocator);
        return Self{
            .token = token,
            .http_client = http_client,
            .router = router,
        };
    }
    pub fn deinit(self: *Self) void {
        self.http_client.deinit();
    }

    /// A simple method for testing your bot's authentication token. Requires no parameters.
    /// Returns basic information about the bot in form of a User object.
    pub fn getMe(self: *Self, allocator: std.mem.Allocator) !json.ParsedResult(types.User) {
        return try self.inner(allocator, types.User, "getMe");
    }

    /// Use this method to send text messages. On success, the sent Message is returned.
    pub fn sendMessage(self: *Self, allocator: std.mem.Allocator, options: params.sendMessageParams) !json.ParsedResult(types.Message) {
        return try self.innerWithBody(allocator, types.Message, params.sendMessageParams, "sendMessage", options);
    }

    /// Use this method to forward messages of any kind.
    /// Service messages and messages with protected content can't be forwarded.
    /// On success, the sent Message is returned.
    pub fn forwardMessage(self: *Self, allocator: std.mem.Allocator, options: params.forwardMessageParams) !json.ParsedResult(types.Message) {
        return try self.innerWithBody(allocator, types.Message, params.forwardMessageParams, "forwardMessage", options);
    }

    /// Use this method to forward multiple messages of any kind. If some of the specified messages can't be found or forwarded, they are skipped. Service messages and messages with protected content can't be forwarded.
    /// Album grouping is kept for forwarded messages. On success, an array of MessageId of the sent messages is returned.
    pub fn forwardMessages(self: *Self, allocator: std.mem.Allocator, options: params.forwardMessagesParams) !json.ParsedResult([]types.MessageId) {
        return try self.innerWithBody(allocator, []types.MessageId, params.forwardMessagesParams, "forwardMessages", options);
    }

    /// Use this method to copy messages of any kind. Service messages, paid media messages, giveaway messages, giveaway winners messages, and invoice messages can't be copied.
    /// A quiz poll can be copied only if the value of the field correct_option_id is known to the bot.
    /// The method is analogous to the method forwardMessage, but the copied message doesn't have a link to the original message.
    /// Returns the MessageId of the sent message on success.
    pub fn copyMessage(self: *Self, allocator: std.mem.Allocator, options: params.copyMessageParams) !json.ParsedResult(types.MessageId) {
        return try self.innerWithBody(allocator, types.MessageId, params.copyMessageParams, "copyMessage", options);
    }

    /// Use this method to send photos. On success, the sent Message is returned.
    pub fn sendPhoto(self: *Self, allocator: std.mem.Allocator, options: params.sendPhotoParams) !json.ParsedResult(types.Message) {
        return try self.innerWithBody(allocator, types.Message, params.sendPhotoParams, "sendPhoto", options);
    }

    /// Use this method to send audio files, if you want Telegram clients to display them in the music player.
    /// Your audio must be in the .MP3 or .M4A format. On success, the sent Message is returned.
    /// Bots can currently send audio files of up to 50 MB in size, this limit may be changed in the future.
    pub fn sendAudio(self: *Self, allocator: std.mem.Allocator, options: params.sendAudioParams) !json.ParsedResult(types.Message) {
        return try self.innerWithBody(allocator, types.Message, params.sendAudioParams, "sendAudio", options);
    }

    /// Use this method to send general files. On success, the sent Message is returned.
    pub fn sendDocument(self: *Self, allocator: std.mem.Allocator, options: params.sendDocumentParams) !json.ParsedResult(types.Message) {
        return try self.innerWithBody(allocator, types.Message, params.sendDocumentParams, "sendDocumetn", options);
    }

    /// Use this method to send video files, Telegram clients support MPEG4 videos (other formats may be sent as Document).
    /// On success, the sent Message is returned
    pub fn sendVideo(self: *Self, allocator: std.mem.Allocator, options: params.sendVideoParams) !json.ParsedResult(types.Message) {
        return try self.innerWithBody(allocator, types.Message, params.sendVideoParams, "sendVideo", options);
    }

    /// Use this method to send animation files (GIF or H.264/MPEG-4 AVC video without sound).
    /// On success, the sent Message is returned
    pub fn sendAnimation(self: *Self, allocator: std.mem.Allocator, options: params.sendAnimationParams) !json.ParsedResult(types.Message) {
        return try self.innerWithBody(allocator, types.Message, params.sendAnimationParams, "sendAnimation", options);
    }

    /// Use this method to send audio files, if you want Telegram clients to display the file as a playable voice message.
    /// For this to work, your audio must be in an .OGG file encoded with OPUS, or in .MP3 format, or in .M4A format (other formats may be sent as Audio or Document).
    /// On success, the sent Message is returned
    pub fn sendVoice(self: *Self, allocator: std.mem.Allocator, options: params.sendVoiceParams) !json.ParsedResult(types.Message) {
        return try self.innerWithBody(allocator, types.Message, params.sendVoiceParams, "sendVoice", options);
    }

    /// As of v.4.0, Telegram clients support rounded square MPEG4 videos of up to 1 minute long. Use this method to send video messages.
    /// On success, the sent Message is returned.
    pub fn sendVideoNote(self: *Self, allocator: std.mem.Allocator, options: params.sendVideoNoteParams) !json.ParsedResult(types.Message) {
        return try self.innerWithBody(allocator, types.Message, params.sendVideoNoteParams, "sendVideoNote", options);
    }

    /// Use this method to send paid media. On success, the sent Message is returned.
    pub fn sendPaidMedia(self: *Self, allocator: std.mem.Allocator, options: params.sendPaidMediaParams) !json.ParsedResult(types.Message) {
        return try self.innerWithBody(allocator, types.Message, params.sendPaidMediaParams, "sendPaidMedia", options);
    }

    // Inner polling logic

    /// Start long poling
    /// Big `workers_amount` can cause undefined behaivor, so MAX = 32
    /// `timeout` in ms
    pub fn longPolling(self: *Self, allocator: std.mem.Allocator, workers_amount: u8, timeout: u64, skip_updates: bool, options: params.getUpdatesParams) !void {
        if (self.router == null) {
            @panic("Router can't be null when using longPolling");
        }
        var poller = try Poller.init(self, workers_amount, timeout, allocator, self.router.?);
        defer poller.deinit(allocator);
        try poller.poll_loop(allocator, skip_updates, options);
    }

    /// Use this method to receive incoming updates using long polling. Returns an Array of Update objects
    pub fn getUpdates(self: *Self, allocator: std.mem.Allocator, options: params.getUpdatesParams) !types.Updates {
        const updates_raw = try self.innerWithBody(allocator, []types.UpdateRaw, params.getUpdatesParams, "getUpdates", options);
        var updates: []types.Update = try allocator.alloc(types.Update, updates_raw.data.len);
        for (updates_raw.data, 0..) |ur, i| {
            updates[i] = types.Update.fromRaw(ur, self);
        }
        return types.Updates{ .data = updates, .ptr = updates_raw };
    }

    // Private methods
    fn inner(self: *Self, allocator: std.mem.Allocator, comptime T: type, method: []const u8) !json.ParsedResult(T) {
        const url = try self.buildUrl(allocator, method);
        defer allocator.free(url);

        const response_json = try self.baseRequest(allocator, url, null);

        errdefer allocator.free(response_json);

        const result = try json.Jsonifier.ObjectFromJson(allocator, T, response_json);
        return result;
    }

    /// T - type of expected result
    /// T2 - type of body
    fn innerWithBody(self: *Self, allocator: std.mem.Allocator, comptime T: type, comptime T2: type, method: []const u8, body: ?T2) !json.ParsedResult(T) {
        const url = try self.buildUrl(allocator, method);
        defer allocator.free(url);

        const body_json: []const u8 = if (body) |bytes| try json.Jsonifier.JsonFromObject(allocator, T2, bytes) else "{}";
        defer allocator.free(body_json);

        const response_json = try self.baseRequest(allocator, url, body_json);

        errdefer allocator.free(response_json);

        const result = try json.Jsonifier.ObjectFromJson(allocator, T, response_json);
        return result;
    }

    fn buildUrl(self: Self, allocator: std.mem.Allocator, method: []const u8) ![]u8 {
        var final_url = ArrayList(u8).empty;
        defer final_url.deinit(allocator);

        try final_url.appendSlice(allocator, BASE_API_URL);
        try final_url.appendSlice(allocator, self.token);
        try final_url.append(allocator, '/');
        try final_url.appendSlice(allocator, method);

        return try final_url.toOwnedSlice(allocator);
    }

    fn baseRequest(self: *Self, allocator: std.mem.Allocator, url: []u8, body_json: ?[]const u8) ![]u8 {
        if (body_json) |body| {
            return try self.http_client.makePostRequest(allocator, url, body);
        } else {
            return try self.http_client.makeRequest(allocator, url);
        }
    }
};
