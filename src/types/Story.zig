const std = @import("std");
const Chat = @import("Chat.zig"); // Assuming Chat struct is defined in Chat.zig

/// Struct representing a story posted in a chat.
pub const Story = struct {
    /// Chat that posted the story.
    chat: Chat,

    /// Unique identifier for the story in the chat.
    id: i64,
};
