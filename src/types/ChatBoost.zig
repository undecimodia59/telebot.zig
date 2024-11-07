const ChatBoostSource = @import("ChatBoostSource.zig").ChatBoostSource;

pub const ChatBoost = struct {
    // Unique identifier of the boost
    boost_id: []const u8,
    // Point in time (Unix timestamp) when the chat was boosted
    add_date: i32,
    // Point in time (Unix timestamp) when the boost will automatically expire
    expiration_date: i32,
    // Source of the added boost
    source: ChatBoostSource,
};
