const std = @import("std");

const PhotoSize = @import("PhotoSize.zig").PhotoSize;

/// Struct representing a video file with its attributes.
pub const Video = struct {
    /// Unique identifier for this file.
    file_id: []const u8,

    /// Unique identifier for this file, which is supposed to be the same over time
    /// and for different bots.
    file_unique_id: []const u8,

    /// Video width as defined by the sender.
    width: i32,

    /// Video height as defined by the sender.
    height: i32,

    /// Duration of the video in seconds as defined by the sender.
    duration: i32,

    /// Optional. Video thumbnail.
    thumb: ?PhotoSize,

    /// Optional. Original filename as defined by the sender.
    file_name: ?[]const u8,

    /// Optional. MIME type of the file as defined by the sender.
    mime_type: ?[]const u8,

    /// Optional. File size in bytes.
    file_size: ?i64,
};
