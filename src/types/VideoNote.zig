const std = @import("std");
const PhotoSize = @import("PhotoSize.zig").PhotoSize;

/// Struct representing a video note.
pub const VideoNote = struct {
    /// Unique identifier for this file.
    file_id: []const u8,

    /// Unique identifier for this file, which is supposed to be the same over time
    /// and for different bots.
    file_unique_id: []const u8,

    /// Video width and height (diameter of the video message) as defined by sender.
    length: i32,

    /// Duration of the video in seconds as defined by sender.
    duration: i32,

    /// Optional. Video thumbnail.
    thumb: ?PhotoSize,

    /// Optional. File size.
    file_size: ?i64,
};
