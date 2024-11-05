const std = @import("std");

const PhotoSize = @import("PhotoSize.zig").PhotoSize;

/// Represents an audio file with optional metadata, including identifiers, performer, title, and thumbnail.
pub const Audio = struct {
    /// Identifier for this file, which can be used to download or reuse the file
    file_id: []const u8,

    /// Unique identifier for this file, intended to remain consistent over time
    file_unique_id: []const u8,

    /// Duration of the audio in seconds, as defined by the sender
    duration: i32,

    /// Optional. Performer of the audio as defined by the sender or from audio tags
    performer: ?[]const u8 = null,

    /// Optional. Title of the audio as defined by the sender or from audio tags
    title: ?[]const u8 = null,

    /// Optional. Original filename as defined by the sender
    file_name: ?[]const u8 = null,

    /// Optional. MIME type of the file as defined by the sender
    mime_type: ?[]const u8 = null,

    /// Optional. File size in bytes, which may exceed 2^31. A signed 64-bit integer
    /// is used to accommodate large values safely.
    file_size: ?i64 = null,

    /// Optional. Thumbnail of the album cover associated with the audio file
    thumbnail: ?PhotoSize = null,
};
