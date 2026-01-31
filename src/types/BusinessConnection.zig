const std = @import("std");
const User = @import("User.zig").User;

pub const BusinessConnection = struct {
    // Unique identifier of the business connection
    id: []const u8,
    // Business account user that created the business connection
    user: User,
    // Identifier of a private chat with the user who created the business connection
    user_chat_id: i64,
    // Date the connection was established in Unix time
    date: i32,
    // Optional. Business bot rights (Bot API 9.0+)
    rights: ?std.json.Value = null,
    // Optional. Deprecated in Bot API 9.0+; kept for backward compatibility
    can_reply: ?bool = null,
    // True, if the connection is active
    is_enabled: bool,
};
