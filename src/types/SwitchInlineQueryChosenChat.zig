const std = @import("std");

pub const SwitchInlineQueryChosenChat = struct {
    /// Optional. The default inline query to be inserted in the input field. If left empty, only the bot's username will be inserted.
    query: ?*const u8,

    /// Optional. True, if private chats with users can be chosen.
    allow_user_chats: ?bool,

    /// Optional. True, if private chats with bots can be chosen.
    allow_bot_chats: ?bool,

    /// Optional. True, if group and supergroup chats can be chosen.
    allow_group_chats: ?bool,

    /// Optional. True, if channel chats can be chosen.
    allow_channel_chats: ?bool,
};
