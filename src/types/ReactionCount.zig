const ReactionType = @import("ReactionType.zig").ReactionType;

pub const ReactionCount = struct {
    /// Type of the reaction
    type: ReactionType,
    /// Number of times the reaction was added
    total_count: i32,
};
