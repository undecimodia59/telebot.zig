/// Struct representing a file in Telegram Passport
pub const PassportFile = struct {
    /// Identifier for this file, which can be used to download or reuse the file
    file_id: []const u8,

    /// Unique identifier for this file, which is supposed to be the same over time
    /// and for different bots. Can't be used to download or reuse the file.
    file_unique_id: []const u8,

    /// File size in bytes
    file_size: i64,

    /// Unix time when the file was uploaded
    file_date: i32,
};
