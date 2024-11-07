const Chat = @import("Chat.zig").Chat;

pub const BusinessMessagesDeleted = struct {
    // Unique identifier of the business connection
    business_connection_id: []const u8,
    // Information about a chat in the business account. The bot may not have access to the chat.
    chat: Chat,
    // The list of identifiers of deleted messages in the chat of the business account
    message_ids: []i32,
};
