const std = @import("std");

pub const User = struct {
    // Unique identifier for this user or bot
    id: i64,

    // True, if this user is a bot
    is_bot: bool,

    // User's or bot's first name
    first_name: []const u8,

    // Optional. User's or bot's last name
    last_name: ?[]const u8 = null,

    // Optional. User's or bot's username
    username: ?[]const u8 = null,

    // Optional. IETF language tag of the user's language
    language_code: ?[]const u8 = null,

    // Optional. True, if this user is a Telegram Premium user
    is_premium: ?bool = null,

    // Optional. True, if this user added the bot to the attachment menu
    added_to_attachment_menu: ?bool = null,

    // Optional. True, if the bot can be invited to groups
    can_join_groups: ?bool = null,

    // Optional. True, if privacy mode is disabled for the bot
    can_read_all_group_messages: ?bool = null,

    // Optional. True, if the bot supports inline queries
    supports_inline_queries: ?bool = null,

    // Optional. True, if the bot can connect to a Telegram Business account
    can_connect_to_business: ?bool = null,

    // Optional. True, if the bot has a main Web App
    has_main_web_app: ?bool = null,
};
