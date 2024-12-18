const std = @import("std");
const InlineKeyboardButton = @import("InlineKeyboardButton.zig").InlineKeyboardButton;
const json = @import("../../json/parser.zig");

pub const InlineKeyboardMarkup = struct {
    inline_keyboard: [][]const InlineKeyboardButton,

    /// This method also calls deinit
    pub fn toReplyMarkup(self: *InlineKeyboardMarkup, allocator: std.mem.Allocator) ![]u8 {
        std.debug.print("In toReplyMarkup:\n", .{});
        for (self.inline_keyboard) |row| {
            for (row) |btn| {
                std.debug.print("\t{s} | {?s} | {?s}\n", .{ btn.text, btn.callback_data, btn.url });
            }
        }

        // Clean duped rows
        defer self.deinit(allocator);

        const jsonifier = json.Jsonifier.init(allocator);
        return jsonifier.JsonFromObject(InlineKeyboardMarkup, self.*);
    }

    pub fn deinit(self: *InlineKeyboardMarkup, allocator: std.mem.Allocator) void {
        for (self.inline_keyboard) |row| {
            allocator.free(row);
        }
        allocator.free(self.inline_keyboard);
    }
};

/// Struct representing an inline keyboard markup.
pub const InlineKeyboardMarkupBuilder = struct {
    const Self = @This();
    kb: std.ArrayList([]const InlineKeyboardButton),
    allocator: std.mem.Allocator,

    pub fn init(allocator: std.mem.Allocator) Self {
        return Self{ .kb = std.ArrayList([]const InlineKeyboardButton).init(allocator), .allocator = allocator };
    }

    /// Deinit inline_keyboard and return markup that should call either deinit or toReplyMarkup
    pub fn build(self: *Self) !InlineKeyboardMarkup {
        const keyboard = try self.kb.toOwnedSlice();
        return InlineKeyboardMarkup{ .inline_keyboard = keyboard };
    }

    pub fn addRow(self: *Self, row: []const InlineKeyboardButton) !void {
        try self.kb.append(try self.allocator.dupe(InlineKeyboardButton, row));
    }
};
