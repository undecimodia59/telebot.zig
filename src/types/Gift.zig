const Sticker = @import("Sticker.zig").Sticker;

pub const Gifts = struct {
    gifts: []Gift,
};

pub const Gift = struct {
    /// Unique identifier of the gift
    id: []const u8,

    /// The sticker that represents the gift
    sticker: Sticker,

    /// The number of Telegram Stars that must be paid to send the sticker
    star_count: i32,

    /// The total number of the gifts of this type that can be sent; for limited gifts only
    total_count: ?i32,

    /// The number of remaining gifts of this type that can be sent; for limited gifts only
    remaining_count: ?i32,
};
