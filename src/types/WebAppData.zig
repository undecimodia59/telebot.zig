const std = @import("std");

const WebAppData = struct {
    /// The data. Be aware that a bad client can send arbitrary data in this field.
    data: *const u8,

    /// Text of the web_app keyboard button from which the Web App was opened. Be aware that a bad client can send arbitrary data in this field.
    button_text: *const u8,
};
