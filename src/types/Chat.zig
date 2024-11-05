const std = @import("std");

pub const Chat = struct {
    // Unique identifier for this chat
    id: i64,

    // Type of the chat: "private", "group", "supergroup", or "channel"
    type: []const u8,

    // Optional. Title for supergroups, channels, and group chats
    title: ?[]const u8 = null,

    // Optional. Username for private chats, supergroups, and channels if available
    username: ?[]const u8 = null,

    // Optional. First name of the other party in a private chat
    first_name: ?[]const u8 = null,

    // Optional. Last name of the other party in a private chat
    last_name: ?[]const u8 = null,

    // Optional. True, if the supergroup chat is a forum (has topics enabled)
    is_forum: ?bool = null,
};
