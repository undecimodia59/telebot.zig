const ChatAdministratorRights = @import("../ChatAdministratorRights.zig").ChatAdministratorRights;

pub const KeyboardButtonRequestChat = struct {
    /// Signed 32-bit identifier of the request, which will be received back in the ChatShared object. Must be unique within the message.
    request_id: i32,

    /// Pass true to request a channel chat, pass false to request a group or a supergroup chat.
    chat_is_channel: bool,

    /// Optional. Pass true to request a forum supergroup, pass false to request a non-forum chat. If not specified, no additional restrictions are applied.
    chat_is_forum: ?bool,

    /// Optional. Pass true to request a supergroup or a channel with a username, pass false to request a chat without a username. If not specified, no additional restrictions are applied.
    chat_has_username: ?bool,

    /// Optional. Pass true to request a chat owned by the user. Otherwise, no additional restrictions are applied.
    chat_is_created: ?bool,

    /// Optional. A JSON-serialized object listing the required administrator rights of the user in the chat. The rights must be a superset of bot_administrator_rights. If not specified, no additional restrictions are applied.
    user_administrator_rights: ?ChatAdministratorRights,

    /// Optional. A JSON-serialized object listing the required administrator rights of the bot in the chat. The rights must be a subset of user_administrator_rights. If not specified, no additional restrictions are applied.
    bot_administrator_rights: ?ChatAdministratorRights,

    /// Optional. Pass true to request a chat with the bot as a member. Otherwise, no additional restrictions are applied.
    bot_is_member: ?bool,

    /// Optional. Pass true to request the chat's title.
    request_title: ?bool,

    /// Optional. Pass true to request the chat's username.
    request_username: ?bool,

    /// Optional. Pass true to request the chat's photo.
    request_photo: ?bool,
};
