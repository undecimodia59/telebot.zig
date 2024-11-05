const std = @import("std");

/// Struct representing a file with its attributes.
pub const File = struct {
    /// Identifier for this file, which can be used to download or reuse the file.
    file_id: []const u8,

    /// Unique identifier for this file, which is supposed to be the same over time
    /// and for different bots. Can't be used to download or reuse the file.
    file_unique_id: []const u8,

    /// Optional. File size in bytes. It can be bigger than 2^31 and some
    /// programming languages may have difficulty/silent defects in interpreting
    /// it. But it has at most 52 significant bits, so a signed 64-bit integer or
    /// double-precision float type are safe for storing this value.
    file_size: ?i64,

    /// Optional. File path. Use
    /// https://api.telegram.org/file/bot<token>/<file_path> to get the file.
    file_path: ?[]const u8,
};
