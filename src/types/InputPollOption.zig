const std = @import("std");
const MessageEntity = @import("MessageEntity.zig").MessageEntity;

pub const InputPollOption = struct {
    /// Option text, 1-100 characters.
    text: []const u8,

    /// Optional. Mode for parsing entities in the text. Refer to formatting
    /// options for more details. Currently, only custom emoji entities are allowed.
    text_parse_mode: ?[]const u8 = null,

    /// Optional. A list of special entities that appear in the poll option text.
    /// It can be specified instead of text_parse_mode.
    text_entities: ?[]MessageEntity = null,
};
