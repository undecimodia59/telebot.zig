const Chat = @import("Chat.zig").Chat;
const ChatBoost = @import("ChatBoost.zig").ChatBoost;

pub const ChatBoostUpdated = struct {
    // Chat which was boosted
    chat: Chat,
    // Information about the chat boost
    boost: ChatBoost,
};
