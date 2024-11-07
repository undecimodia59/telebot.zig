const Chat = @import("Chat.zig").Chat;
const ChatBoostSource = @import("ChatBoostSource.zig").ChatBoostSource;

pub const ChatBoostRemoved = struct {
    // Chat which was boosted
    chat: Chat,
    // Unique identifier of the boost
    boost_id: []const u8,
    // Point in time (Unix timestamp) when the boost was removed
    remove_date: i32,
    // Source of the removed boost
    source: ChatBoostSource,
};
