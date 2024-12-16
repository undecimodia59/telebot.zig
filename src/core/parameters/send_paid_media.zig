const types = @import("../../types/types.zig");
const InputPaidMedia = types.InputPaidMedia;
const MessageEntity = types.MessageEntity;
const ReplyParameters = types.ReplyParameters;

pub const SendPaidMediaParameters = struct {
    /// Unique identifier of the business connection on behalf of which the message will be sent.
    business_connection_id: ?[]const u8 = null,

    /// Unique identifier for the target chat
    /// If the chat is a channel, all Telegram Star proceeds from this media will be credited to the chat's balance.
    /// Otherwise, they will be credited to the bot's balance.
    chat_id: i64,

    /// The number of Telegram Stars that must be paid to buy access to the media; 1-2500.
    star_count: i64,

    /// A JSON-serialized array describing the media to be sent; up to 10 items.
    media: []InputPaidMedia,

    /// Bot-defined paid media payload, 0-128 bytes. This will not be displayed to the user, use it for your internal processes.
    payload: ?[]const u8 = null,

    /// Media caption, 0-1024 characters after entities parsing.
    caption: ?[]const u8 = null,

    /// Mode for parsing entities in the media caption. See formatting options for more details.
    parse_mode: ?[]const u8 = null,

    /// A JSON-serialized list of special entities that appear in the caption, which can be specified instead of parse_mode.
    caption_entities: ?[]MessageEntity = null,

    /// Pass True, if the caption must be shown above the message media.
    show_caption_above_media: ?bool = null,

    /// Sends the message silently. Users will receive a notification with no sound.
    disable_notification: ?bool = null,

    /// Protects the contents of the sent message from forwarding and saving.
    protect_content: ?bool = null,

    /// Pass True to allow up to 1000 messages per second, ignoring broadcasting limits for a fee of
    /// 0.1 Telegram Stars per message. The relevant Stars will be withdrawn from the bot's balance.
    allow_paid_broadcast: ?bool = null,

    /// Description of the message to reply to.
    reply_parameters: ?ReplyParameters = null,

    /// Additional interface options. A JSON-serialized object for an inline keyboard, custom reply keyboard,
    /// instructions to remove a reply keyboard or to force a reply from the user.
    reply_markup: ?[]u8 = null,
};
