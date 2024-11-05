const Chat = @import("Chat.zig").Chat;
const Message = @import("Message.zig").Message;

pub const MaybeInaccessibleMessage = union(enum) {
    InaccessibleMessage: InaccessibleMessage,
    Message: Message,
};

// Struct representing an inaccessible message
pub const InaccessibleMessage = struct {
    chat: Chat, // Chat associated with the inaccessible message
    inaccessible_message: []const u8, // Inaccessible message text
};
