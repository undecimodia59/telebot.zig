const std = @import("std");
const InlineKeyboardButton = @import("InlineKeyboardButton.zig").InlineKeyboardButton;
const json = @import("../../json/parser.zig");

const InlineKeyboard = std.ArrayList([]const InlineKeyboardButton);

/// Struct representing an inline keyboard markup.
pub const InlineKeyboardMarkup = struct {
    inner: ?InnerInlineMarkup = null,
    kb: InlineKeyboard,
    allocator: std.mem.Allocator,

    const Self = @This();

    pub fn init(allocator: std.mem.Allocator) Self {
        return Self{ .kb = InlineKeyboard.init(allocator), .allocator = allocator };
    }

    /// Deinit inline_keyboard and return json that's need to be deallocated
    pub fn toReplyMarkup(self: *Self) ![]u8 {
        const kb = try self.kb.toOwnedSlice();
        defer {
            self.kb.deinit();
            self.allocator.free(kb);
        }

        const jsonifier = json.Jsonifier.init(self.allocator);
        return try jsonifier.JsonFromObject(InnerInlineMarkup, .{ .inline_keyboard = kb });
    }

    pub fn addRow(self: *Self, row: []const InlineKeyboardButton) !void {
        try self.kb.append(row);
    }
};

pub const InnerInlineMarkup = struct { inline_keyboard: [][]const InlineKeyboardButton };
