const std = @import("std");
const Chat = @import("Chat.zig").Chat;
const User = @import("User.zig").User;

pub const MessageOrigin = struct {
    /// user, hidden_user, chat or channel
    type: []const u8,
    date: i64,
    /// sender_user != null only if type == "user"
    sender_user: ?User = null,

    /// sender_user_name != null only if type == "hidden_user"
    sender_user_name: ?[]const u8 = null,

    /// sender_chat != null only if type == "chat"
    sender_chat: ?Chat = null,

    /// author_signature != null only if type == "chat" or type == "channel"
    /// FIELD IS OPTIONAL. type == "chat" or type == "channel" doesn't gurantee non-null
    author_signature: ?[]const u8 = null,

    /// chat != null only if type == "channel"
    chat: ?Chat = null,

    /// message_id != null only if type == "channel"
    message_id: ?i32 = null,
};
