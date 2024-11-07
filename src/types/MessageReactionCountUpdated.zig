const Chat = @import("Chat.zig").Chat;
const ReactionCount = @import("ReactionCount.zig").ReactionCount;

pub const MessageReactionCountUpdated = struct {
    /// The chat containing the message
    chat: Chat,
    /// Unique message identifier inside the chat
    message_id: i32,
    /// Date of the change in Unix time
    date: i32,
    /// List of reactions that are present on the message
    reactions: []ReactionCount,
};
