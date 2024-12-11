const MessageEntity = @import("../../types/types.zig").MessageEntity;
const ReplyParameters = @import("../../types/types.zig").ReplyParameters;

pub const CopyMessageParameters = struct {
    /// Unique identifier for the target chat
    chat_id: i64,

    /// Unique identifier for the target message thread (topic) of the forum; for forum supergroups only
    message_thread_id: ?i64 = null,

    /// Unique identifier for the chat where the original message was sent
    from_chat_id: i64,

    /// Message identifier in the chat specified in from_chat_id
    message_id: i64,

    /// New caption for media, 0-1024 characters after entities parsing. If not specified, the original caption is kept
    caption: ?[]const u8 = null,

    /// Mode for parsing entities in the message text.
    /// See [formatting options](https://core.telegram.org/bots/api#formatting-options) for more details
    parse_mode: ?[]const u8 = null,

    /// A JSON-serialized list of special entities that appear in the new caption, which can be specified instead of parse_mode
    caption_entities: ?[]MessageEntity = null,

    /// Pass True, if the caption must be shown above the message media. Ignored if a new caption isn't specified.
    show_caption_above_media: ?bool = null,

    /// Sends the message silently. Users will receive a notification with no sound
    disable_notification: ?bool = null,

    /// Protects the contents of the sent message from forwarding and saving
    protect_content: ?bool = null,

    /// Pass True to allow up to 1000 messages per second, ignoring broadcasting limits for a fee of 0.1 Telegram Stars per message.
    /// The relevant Stars will be withdrawn from the bot's balance
    allow_paid_broadcast: ?bool = null,

    /// Description of the message to reply to
    reply_parameters: ?ReplyParameters = null,

    /// Additional interface options. A JSON-serialized object for an inline keyboard,
    /// custom reply keyboard, instructions to remove a reply keyboard or to force a reply from the user
    reply_markup: ?[]u8 = null,
};
