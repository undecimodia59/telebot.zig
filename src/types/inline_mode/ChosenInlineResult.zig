const types = @import("../types.zig");
const User = types.User;
const Location = types.Location;

/// Represents a result of an inline query that was chosen by the user and sent to their chat partner.
pub const ChosenInlineResult = struct {
    /// The unique identifier for the result that was chosen.
    result_id: []const u8,

    /// The user that chose the result.
    from: User,

    /// Sender location, only for bots that require user location.
    location: ?Location = null,

    /// Identifier of the sent inline message. Available only if there is an inline keyboard attached to the message.
    /// Will be also received in callback queries and can be used to edit the message.
    inline_message_id: ?[]const u8 = null,

    /// The query that was used to obtain the result.
    query: []const u8,
};
