const std = @import("std");
const MessageEntity = @import("MessageEntity.zig").MessageEntity;
const PhotoSize = @import("PhotoSize.zig").PhotoSize;

/// Struct representing a game.
pub const Game = struct {
    /// Title of the game.
    title: []const u8,

    /// Description of the game.
    description: []const u8,

    /// Photo that will be displayed in the game message in chats.
    photo: []PhotoSize,

    /// Optional. Brief description of the game or high scores included in the game message.
    text: ?[]const u8,

    /// Optional. Special entities that appear in text, such as usernames, URLs, bot commands, etc.
    text_entities: ?[]MessageEntity,
};
