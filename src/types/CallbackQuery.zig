const User = @import("./User.zig").User;
const MaybeInaccessibleMessage = @import("MaybeInaccessibleMessage.zig").MaybeInaccessibleMessage;

pub const CallbackQuery = struct {
    /// Unique identifier for this query
    id: []const u8,
    /// Sender of the callback query
    from: User,
    /// Message sent by the bot with the callback button that originated the query
    message: ?MaybeInaccessibleMessage = null,
    /// Identifier of the message sent via the bot in inline mode that originated the query
    inline_message_id: ?[]const u8 = null,
    /// Global identifier, uniquely corresponding to the chat to which the message with the callback button was sent
    chat_instance: []const u8,
    /// Data associated with the callback button
    data: ?[]const u8 = null,
    /// Short name of a Game to be returned, serves as the unique identifier for the game
    game_short_name: ?[]const u8 = null,
};
