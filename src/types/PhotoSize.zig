const std = @import("std");

/// Struct representing the size and identifiers of a photo.
pub const PhotoSize = struct {
    /// Identifier for this file, which can be used to download or reuse the file.
    file_id: []const u8,

    /// Unique identifier for this file, which is supposed to be the same over time
    /// and for different bots. Can't be used to download or reuse the file.
    file_unique_id: []const u8,

    /// Photo width.
    width: i32,

    /// Photo height.
    height: i32,

    /// Optional. File size in bytes. It can be bigger than 2^31 and some
    /// programming languages may have difficulty/silent defects in interpreting
    /// it. But it has at most 52 significant bits, so a signed 64-bit integer or
    /// double-precision float type are safe for storing this value.
    file_size: ?i64,
};
