const std = @import("std");

/// Struct representing a voice message.
pub const Voice = struct {
    /// Unique identifier for this file.
    file_id: []const u8,

    /// Unique identifier for this file, which is supposed to be the same over time
    /// and for different bots. Can't be used to download or reuse the file.
    file_unique_id: []const u8,

    /// Duration of the audio in seconds as defined by sender.
    duration: i32,

    /// MIME type of the file as defined by sender.
    mime_type: ?[]const u8,

    /// File size.
    file_size: ?i64,
};
