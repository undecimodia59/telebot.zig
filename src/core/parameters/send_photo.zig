const types = @import("../../types/types.zig");
const MessageEntity = types.MessageEntity;
const ReplyParameters = types.ReplyParameters;

pub const SendPhotoParameters = struct {
    /// Unique identifier of the business connection on behalf of which the message will be sent
    business_connection_id: ?[]const u8 = null,

    /// Unique identifier for the target chat
    chat_id: i64,

    /// Unique identifier for the target message thread (topic) of the forum; for forum supergroups only
    message_thread_id: ?i64 = null,

    /// Photo to send. Pass a file_id as String to send a photo that exists on the Telegram servers (recommended), pass an HTTP URL as a String for Telegram to get a photo from the Internet, or upload a new photo using multipart/form-data.
    /// The photo must be at most 10 MB in size. The photo's width and height must not exceed 10000 in total.
    /// Width and height ratio must be at most 20.
    /// TODO: Currently avaliable only string. Need solution to fix
    photo: []const u8,

    /// Photo caption (may also be used when resending photos by file_id), 0-1024 characters after entities parsing
    caption: ?[]const u8 = null,

    /// Mode for parsing entities in the photo caption. See formatting options for more details
    parse_mode: ?[]const u8 = null,

    /// A JSON-serialized list of special entities that appear in the caption, which can be specified instead of parse_mode
    caption_entities: ?[]MessageEntity = null,

    /// Pass True, if the caption must be shown above the message media
    show_caption_above_media: ?bool = null,

    /// Pass True if the photo needs to be covered with a spoiler animation
    has_spoiler: ?bool = null,

    /// Sends the message silently. Users will receive a notification with no sound.
    disable_notification: ?bool = null,

    /// Protects the contents of the sent message from forwarding and saving
    protect_content: ?bool = null,

    /// Pass True to allow up to 1000 messages per second, ignoring broadcasting limits for a fee of 0.1 Telegram Stars per message.
    /// The relevant Stars will be withdrawn from the bot's balance
    allow_paid_broadcast: ?bool = null,

    /// Unique identifier of the message effect to be added to the message; for private chats only
    message_effect_id: ?[]const u8 = null,

    /// Description of the message to reply to
    reply_parameters: ?ReplyParameters = null,

    /// Additional interface options. A JSON-serialized object for an inline keyboard,
    /// custom reply keyboard, instructions to remove a reply keyboard or to force a reply from the user
    reply_markup: ?[]u8 = null,
};
