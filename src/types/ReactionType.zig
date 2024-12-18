pub const ReactionType = struct {
    /// Type of the reaction: "emoji", "custom_emoji", "paid"
    type: []const u8,

    /// If type "emoji"
    emoji: ?[]const u8 = null,

    /// If type "custom_emoji"
    custom_emoji_id: []const u8,
};
