const std = @import("std");

/// Struct representing a contact.
pub const Contact = struct {
    /// Contact's phone number.
    phone_number: []const u8,

    /// Contact's first name.
    first_name: []const u8,

    /// Contact's last name.
    last_name: ?[]const u8,

    /// Contact's user identifier in Telegram.
    user_id: ?i64,

    /// Contact's vCard.
    vcard: ?[]const u8,
};
