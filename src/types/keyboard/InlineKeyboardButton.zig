const std = @import("std");

const CallbackGame = @import("../CallbackGame.zig").CallbackGame;
const LoginUrl = @import("../LoginUrl.zig").LoginUrl;
const SwitchInlineQueryChosenChat = @import("../SwitchInlineQueryChosenChat.zig").SwitchInlineQueryChosenChat;
const WebAppData = @import("../WebAppData.zig").WebAppData;

/// Struct representing an inline keyboard button.
pub const InlineKeyboardButton = struct {
    // Label text on the button
    text: []const u8,

    // Optional. HTTP or tg:// URL to be opened when the button is pressed.
    url: ?*const u8 = null,

    // Optional. Data to be sent in a callback query to the bot when the button is pressed.
    callback_data: ?*const u8 = null,

    // Optional. Description of the Web App that will be launched when the user presses the button.
    web_app: ?WebAppData = null,

    // Optional. An HTTPS URL used to automatically authorize the user.
    login_url: ?LoginUrl = null,

    // Optional. If set, prompts the user to select one of their chats.
    switch_inline_query: ?*const u8 = null,

    // Optional. If set, inserts the bot's username and specified inline query in the current chat's input field.
    switch_inline_query_current_chat: ?*const u8 = null,

    // Optional. If set, prompts the user to select one of their chats of the specified type.
    switch_inline_query_chosen_chat: ?SwitchInlineQueryChosenChat = null,

    // Optional. Description of the game that will be launched when the user presses the button.
    callback_game: ?CallbackGame = null,

    // Optional. Specify true to send a Pay button.
    pay: ?bool = null,

    // Constructor with callback_data parameter
    pub fn init(text: []const u8, callback_data: []const u8) InlineKeyboardButton {
        return InlineKeyboardButton{
            .text = text,
            .callback_data = callback_data,
        };
    }

    // TODO: Add constructors for other optional parameters as needed
};
