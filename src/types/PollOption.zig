const std = @import("std");
const MessageEntity = @import("MessageEntity.zig").MessageEntity;

/// Struct representing a poll option.
pub const PollOption = struct {
    /// Option text, 1-100 characters.
    text: []const u8,

    /// Optional. Special entities that appear in the option text. Currently, only custom emoji entities are allowed in poll option texts.
    text_entities: ?[]MessageEntity,

    /// Number of users that voted for this option.
    voter_count: i32,
};
