const Sticker = @import("Sticker.zig").Sticker;

/// Struct containing information about the start page settings of a Telegram Business account
pub const BusinessIntro = struct {
    /// Optional. Title text of the business intro
    title: ?[]const u8,

    /// Optional. Message text of the business intro
    message: ?[]const u8,

    /// Optional. Sticker of the business intro
    sticker: ?Sticker, // Assuming Sticker is defined elsewhere
};
