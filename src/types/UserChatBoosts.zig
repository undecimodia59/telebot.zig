const ChatBoost = @import("ChatBoost.zig").ChatBoost;

pub const UserChatBoosts = struct {
    // The list of boosts added to the chat by the user
    boosts: []ChatBoost,
};
