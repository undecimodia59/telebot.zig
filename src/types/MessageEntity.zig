const std = @import("std");

pub const MessageEntity = struct {
    // Type of the entity as a string (e.g., "mention", "hashtag", etc.)
    type: []const u8,

    // Offset in UTF-16 code units to the start of the entity
    offset: i32,

    // Length of the entity in UTF-16 code units
    length: i32,

    // Optional. For “text_link” only, URL that will be opened after user taps on the text
    url: ?[]const u8 = null,
};
