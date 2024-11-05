const PhotoSize = @import("PhotoSize.zig").PhotoSize;

// Struct representing shared chat information
pub const ChatShared = struct {
    // Identifier of the request
    request_id: i32,

    // Identifier of the shared chat
    chat_id: i64,

    // Optional. Title of the chat
    title: ?*const u8,

    // Optional. Username of the chat
    username: ?*const u8,

    // Optional. Available sizes of the chat photo
    photo: ?[]PhotoSize,
};
