const ReactionType = union(enum) {
    /// The reaction is based on an emoji
    ReactionTypeEmoji: struct {
        /// Type of the reaction, always “emoji”
        type: []const u8 = "emoji",

        /// Reaction emoji
        emoji: []const u8, // Currently, it can be one of a predefined set of emojis
    },

    /// The reaction is based on a custom emoji
    ReactionTypeCustomEmoji: struct {
        /// Type of the reaction, always “custom_emoji”
        type: []const u8 = "custom_emoji",

        /// Custom emoji identifier
        custom_emoji_id: []const u8,
    },

    /// The reaction is paid
    ReactionTypePaid: struct {
        /// Type of the reaction, always “paid”
        type: []const u8 = "paid",
    },
};
