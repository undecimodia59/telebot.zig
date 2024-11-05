const PhotoSize = @import("PhotoSize.zig").PhotoSize;

/// Struct representing a shared user
pub const SharedUser = struct {
    /// Identifier of the shared user
    user_id: i64,

    /// Optional. First name of the user
    first_name: ?[]const u8,

    /// Optional. Last name of the user
    last_name: ?[]const u8,

    /// Optional. Username of the user
    username: ?[]const u8,

    /// Optional. Available sizes of the chat photo
    photo: ?[]PhotoSize,
};
