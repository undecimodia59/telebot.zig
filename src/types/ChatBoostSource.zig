const User = @import("User.zig").User;

pub const ChatBoostSource = union(enum) {
    ChatBoostSourcePremium: struct {
        // Source of the boost, always "premium"
        source: []const u8,
        // User that boosted the chat
        user: User,
    },
    ChatBoostSourceGiftCode: struct {
        // Source of the boost, always "gift_code"
        source: []const u8,
        // User for which the gift code was created
        user: User,
    },
    ChatBoostSourceGiveaway: struct {
        // Source of the boost, always "giveaway"
        source: []const u8,
        // Identifier of a message in the chat with the giveaway
        giveaway_message_id: i32,
        // Optional user that won the prize in the giveaway
        user: ?User,
        // Optional number of Telegram Stars to be split between giveaway winners
        prize_star_count: ?i32,
        // Optional flag indicating if the giveaway was completed but no user claimed the prize
        is_unclaimed: ?bool,
    },
};
