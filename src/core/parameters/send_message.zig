const types = @import("../../types/types.zig");

/// Only optional params. Not optional will be provided in function
pub const SendMessageParameters = struct {
    /// Unique identifier for the target chat.
    /// Not supporting username of the target channel (in the format @channelusername)
    chat_id: i64,

    /// Text of the message to be sent, 1-4096 characters after entities parsing
    text: []const u8,

    /// Unique identifier of the business connection on behalf of which the message will be sent
    business_connection_id: ?[]const u8 = null,

    /// Unique identifier for the target message thread (topic) of the forum; for forum supergroups only
    message_thread_id: ?i64 = null,

    /// Mode for parsing entities in the message text.
    /// See [formatting options](https://core.telegram.org/bots/api#formatting-options) for more details
    parse_mode: ?[]const u8 = null,

    /// A JSON-serialized list of special entities that appear in message text, which can be specified instead of parse_mode
    entities: ?[]types.MessageEntity = null,

    /// Link preview generation options for the message
    link_preview_options: ?types.LinkPreviewOptions = null,

    /// Sends the message silently. Users will receive a notification with no sound.
    disable_notification: ?bool = null,

    /// Protects the contents of the sent message from forwarding and saving
    protect_content: ?bool = null,

    /// Pass True to allow up to 1000 messages per second,
    /// ignoring broadcasting limits for a fee of 0.1 Telegram Stars per message.
    /// The relevant Stars will be withdrawn from the bot's balance
    allow_paid_broadcast: ?bool = null,

    /// Unique identifier of the message effect to be added to the message; for private chats only
    message_effect_id: ?[]const u8 = null,

    /// Description of the message to reply to
    reply_parameters: ?types.ReplyParameters = null,

    /// Additional interface options. A JSON-serialized object for an inline keyboard,
    /// custom reply keyboard, instructions to remove a reply keyboard or to force a reply from the user
    /// TODO: Make ReplyMarkup union to be passed into this
    reply_markup: ?[]u8 = null,
};
