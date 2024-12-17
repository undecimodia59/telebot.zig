const std = @import("std");

const CallbackGame = @import("../CallbackGame.zig").CallbackGame;
const LoginUrl = @import("../LoginUrl.zig").LoginUrl;
const SwitchInlineQueryChosenChat = @import("../SwitchInlineQueryChosenChat.zig").SwitchInlineQueryChosenChat;
const WebAppInfo = @import("../WebAppInfo.zig").WebAppInfo;

/// Struct representing an inline keyboard button.
pub const InlineKeyboardButton = struct {
    /// Label text on the button
    text: []const u8,

    /// Optional. HTTP or tg://URL to be opened when the button is pressed.
    url: ?[]const u8 = null,

    /// Optional. Data to be sent in a callback query to the bot when the button is pressed.
    callback_data: ?[]const u8 = null,

    /// Optional. Description of the Web App that will be launched when the user presses the button.
    web_app: ?WebAppInfo = null,

    /// Optional. An HTTPS URL used to automatically authorize the user.
    login_url: ?LoginUrl = null,

    /// Optional. If set, pressing the button will prompt the user to select one of their chats,
    /// open that chat and insert the bot's username and the specified inline query in the input field.
    /// May be empty, in which case just the bot's username will be inserted.
    /// Not supported for messages sent on behalf of a Telegram Business account.
    switch_inline_query: ?[]const u8 = null,

    /// Optional.  If set, pressing the button will insert the bot's username and the specified inline query in the current chat's input field.
    /// May be empty, in which case only the bot's username will be inserted.
    ///
    /// This offers a quick way for the user to open your bot in inline mode in the same chat - good for
    /// selecting something from multiple options. Not supported in channels and for messages sent on behalf of a
    /// Telegram Business account.
    switch_inline_query_current_chat: ?[]const u8 = null,

    /// Optional. If set, prompts the user to select one of their chats of the specified type.
    switch_inline_query_chosen_chat: ?SwitchInlineQueryChosenChat = null,

    /// Optional. Description of the game that will be launched when the user presses the button.
    callback_game: ?CallbackGame = null,

    /// Optional. Specify true to send a Pay button.
    pay: ?bool = null,
};
