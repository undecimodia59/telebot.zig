const std = @import("std");

const PhotoSize = @import("PhotoSize.zig").PhotoSize;

/// Represents an animation with optional metadata, including file identifiers and display details.
pub const Animation = struct {
    /// Identifier for this file, which can be used to download or reuse the file
    file_id: []const u8,

    /// Unique identifier for this file, intended to remain the same across time and bots.
    /// Can't be used to download or reuse the file.
    file_unique_id: []const u8,

    /// Video width as defined by the sender
    width: i32,

    /// Video height as defined by the sender
    height: i32,

    /// Duration of the video in seconds as defined by the sender
    duration: i32,

    /// Optional. Animation thumbnail as defined by the sender
    thumbnail: ?PhotoSize = null,

    /// Optional. Original animation filename as defined by the sender
    file_name: ?[]const u8 = null,

    /// Optional. MIME type of the file as defined by the sender
    mime_type: ?[]const u8 = null,

    /// Optional. File size in bytes, which may exceed 2^31. A signed 64-bit integer
    /// or double-precision float type are safe for storing this value.
    file_size: ?i64 = null,
};
