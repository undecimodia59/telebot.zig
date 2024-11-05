const Chat = @import("Chat.zig").Chat;
const Message = @import("Message.zig").Message;

pub const MaybeInaccessibleMessage = union(enum) {
    InaccessibleMessage: struct {
        chat: Chat, // Chat associated with the inaccessible message
        inaccessible_message: []const u8, // Inaccessible message text
    },
    Message: Message,
};
