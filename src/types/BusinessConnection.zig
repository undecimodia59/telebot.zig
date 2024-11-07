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
    // True, if the bot can act on behalf of the business account in chats active in the last 24 hours
    can_reply: bool,
    // True, if the connection is active
    is_enabled: bool,
};
