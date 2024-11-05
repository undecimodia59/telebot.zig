const std = @import("std");
const MessageEntity = @import("MessageEntity.zig").MessageEntity;

pub const ReplyParameters = struct {
    /// Identifier of the message that will be replied to in the current chat, or
    /// in the chat specified by chat_id if provided.
    message_id: i32,

    /// Optional. If the message to be replied to is from a different chat, this
    /// field specifies the unique identifier for the chat or the username of the
    /// channel (formatted as @channelusername). Not supported for messages sent
    /// on behalf of a business account.
    chat_id: ?[]const u8,

    /// Optional. Pass true if the message should be sent even if the specified
    /// message to be replied to is not found. Always false for replies in another
    /// chat or forum topic. Always true for messages sent on behalf of a business
    /// account.
    allow_sending_without_reply: ?bool,

    /// Optional. Quoted part of the message to be replied to; 0-1024 characters
    /// after entities parsing. The quote must be an exact substring of the
    /// message to be replied to, including bold, italic, underline,
    /// strikethrough, spoiler, and custom emoji entities. The message will fail
    /// to send if the quote isn’t found in the original message.
    quote: ?[]const u8,

    /// Optional. Mode for parsing entities in the quote. Refer to formatting
    /// options for more details.
    quote_parse_mode: ?[]const u8,

    /// Optional. A list of special entities that appear in the quote. It can be
    /// specified instead of quote_parse_mode.
    quote_entities: ?[]MessageEntity,

    /// Optional. Position of the quote in the original message, measured in UTF-16
    /// code units.
    quote_position: ?i32,
};
