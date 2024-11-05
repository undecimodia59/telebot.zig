// Struct representing a completed giveaway
pub const GiveawayCompleted = struct {
    winner_count: i32, // Number of winners in the giveaway
    unclaimed_prize_count: ?i32, // Optional number of undistributed prizes
    giveaway_message: ?i32, // Optional message ID of the completed giveaway
    is_star_giveaway: ?bool, // Optional flag indicating if it's a Telegram Star giveaway
};
