const std = @import("std");
const Chat = @import("Chat.zig").Chat;
const User = @import("User.zig").User;

/// Usage:
/// switch (message_origin) {
///    MessageOrigin.User => |user| {
///    // Do something with user
///    },
///    MessageOrigin.HiddenUser => |hidden_user| {
///    // Do something with hidden_user
///    },
///    MessageOrigin.Chat => |chat| {
///    // Do something with chat
///    },
///    MessageOrigin.Channel => |channel| {
///    // Do something with channel
///    },
/// }
pub const MessageOrigin = union(enum) {
    User: MessageOriginUser,
    HiddenUser: MessageOriginHiddenUser,
    Chat: MessageOriginChat,
    Channel: MessageOriginChannel,
};

pub const MessageOriginUser = struct {
    type: []const u8, // "user"
    date: i64, // Unix timestamp
    sender_user: User,
};

pub const MessageOriginHiddenUser = struct {
    type: []const u8, // "hidden_user"
    date: i64, // Unix timestamp
    sender_user_name: []const u8,
};

pub const MessageOriginChat = struct {
    type: []const u8, // "chat"
    date: i64, // Unix timestamp
    sender_chat: Chat,
    author_signature: ?[]const u8, // Optional field
};

pub const MessageOriginChannel = struct {
    type: []const u8, // "channel"
    date: i64, // Unix timestamp
    chat: Chat,
    message_id: i32,
    author_signature: ?[]const u8, // Optional field
};
