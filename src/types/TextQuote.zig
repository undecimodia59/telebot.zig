const std = @import("std");
const MessageEntity = @import("MessageEntity.zig").MessageEntity;

/// Struct representing a text quote.
pub const TextQuote = struct {
    // Text of the quoted part of a message that is replied to by the given message
    text: []const u8,

    // Optional. Special entities that appear in the quote. Currently, only bold,
    // italic, underline, strikethrough, spoiler, and custom_emoji entities are kept in quotes.
    entities: ?[]MessageEntity,

    // Approximate quote position in the original message in UTF-16 code units as specified by the sender
    position: i32,

    // Optional. True, if the quote was chosen manually by the message sender.
    // Otherwise, the quote was added automatically by the server.
    is_manual: ?bool,
};
