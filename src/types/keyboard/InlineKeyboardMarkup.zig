const std = @import("std");
const InlineKeyboardButton = @import("InlineKeyboardButton.zig").InlineKeyboardButton;

/// Struct representing an inline keyboard markup.
pub const InlineKeyboardMarkup = struct {
    // Array of button rows, each represented by an array of InlineKeyboardButton objects
    inline_keyboard: []const []InlineKeyboardButton,
};
