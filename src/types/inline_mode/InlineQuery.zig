const types = @import("../types.zig");
const User = types.User;
const Location = types.Location;

/// This object represents an incoming inline query. When the user sends an empty query,
/// your bot could return some default or trending results.
pub const InlineQuery = struct {
    /// Unique identifier for this query.
    id: []const u8,

    /// Sender of the inline query.
    from: User,

    /// Text of the query (up to 256 characters).
    query: []const u8,

    /// Offset of the results to be returned, can be controlled by the bot.
    offset: []const u8,

    /// Type of the chat from which the inline query was sent.
    /// Can be either “sender” for a private chat with the inline query sender, “private”, “group”, “supergroup”, or “channel”.
    /// The chat type should always be known for requests sent from official clients and most third-party clients,
    /// unless the request was sent from a secret chat.
    chat_type: ?[]const u8 = null,

    /// Sender location, only for bots that request user location.
    location: ?Location = null,
};
