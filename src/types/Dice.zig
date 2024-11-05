const std = @import("std");

/// Struct representing a dice throw.
pub const Dice = struct {
    /// Emoji on which the dice throw is based.
    emoji: []const u8,

    /// Value of the dice throw, 1-6 for "🎲" and "🎯" emojis, 1-5 for "🏀" emoji.
    value: i32,
};
