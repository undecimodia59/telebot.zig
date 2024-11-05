const std = @import("std");
const PhotoSize = @import("PhotoSize.zig").PhotoSize;

/// Represents a document file with optional metadata, including identifiers and thumbnail.
pub const Document = struct {
    /// Identifier for this file, which can be used to download or reuse the file
    file_id: i32,

    /// Unique identifier for this file, intended to remain consistent over time
    /// and across different bots.
    file_unique_id: i32,

    /// Optional. Document thumbnail as defined by the sender
    thumbnail: ?PhotoSize = null,

    /// Optional. Original filename as defined by the sender
    file_name: ?[]const u8 = null,

    /// Optional. MIME type of the file as defined by the sender
    mime_type: ?[]const u8 = null,

    /// Optional. File size in bytes. It can be larger than 2^31.
    /// A signed 64-bit integer is safe for storing this value.
    file_size: ?i64 = null,
};
