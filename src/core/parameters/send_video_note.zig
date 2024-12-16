const types = @import("../../types/types.zig");
const MessageEntity = types.MessageEntity;
const ReplyParameters = types.ReplyParameters;

pub const SendVideoNoteParameters = struct {
    /// Unique identifier of the business connection on behalf of which the message will be sent.
    business_connection_id: ?[]const u8 = null, // Optional

    /// Unique identifier for the target chat or username of the target channel (in the format @channelusername).
    chat_id: i64, // Required, Integer or String

    /// Unique identifier for the target message thread (topic) of the forum; for forum supergroups only.
    message_thread_id: ?i64 = null, // Optional

    /// Video note to send. Pass a file_id as String to send a video note that exists on the Telegram servers
    /// (recommended) or upload a new video using multipart/form-data. Sending video notes by a URL is currently unsupported.
    video_note: []const u8, // Required, InputFile or String

    /// Duration of sent video in seconds.
    duration: ?i64 = null, // Optional

    /// Video width and height, i.e., diameter of the video message.
    length: ?i64 = null, // Optional

    /// Thumbnail of the file sent; can be ignored if thumbnail generation for the file is supported server-side.
    /// The thumbnail should be in JPEG format and less than 200 kB in size. A thumbnail's width and height should
    /// not exceed 320. Ignored if the file is not uploaded using multipart/form-data. Thumbnails can't be reused
    /// and can only be uploaded as a new file, so you can pass “attach://<file_attach_name>” if the thumbnail
    /// was uploaded using multipart/form-data under <file_attach_name>. More information on Sending Files.
    // thumbnail: ?anytype = null, // Optional, InputFile or String

    /// Sends the message silently. Users will receive a notification with no sound.
    disable_notification: ?bool = null, // Optional

    /// Protects the contents of the sent message from forwarding and saving.
    protect_content: ?bool = null, // Optional

    /// Pass True to allow up to 1000 messages per second, ignoring broadcasting limits for a fee of
    /// 0.1 Telegram Stars per message. The relevant Stars will be withdrawn from the bot's balance.
    allow_paid_broadcast: ?bool = null, // Optional

    /// Unique identifier of the message effect to be added to the message; for private chats only.
    message_effect_id: ?[]const u8 = null, // Optional

    /// Description of the message to reply to.
    reply_parameters: ?ReplyParameters = null, // Optional

    /// Additional interface options. A JSON-serialized object for an inline keyboard, custom reply keyboard,
    /// instructions to remove a reply keyboard or to force a reply from the user.
    reply_markup: ?[]u8 = null, // Optional, JSON-serialized object
};
