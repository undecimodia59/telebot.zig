const std = @import("std");

pub const LoginUrl = struct {
    /// An HTTPS URL to be opened with user authorization data added to the query string when the button is pressed.
    url: ?*const u8,

    /// Optional. New text of the button in forwarded messages.
    forward_text: ?*const u8,

    /// Optional. Username of a bot, which will be used for user authorization.
    bot_username: ?*const u8,

    /// Optional. Pass true to request the permission for your bot to send messages to the user.
    request_write_access: ?bool,
};
