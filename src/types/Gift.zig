const Sticker = @import("Sticker.zig").Sticker;
const Chat = @import("Chat.zig").Chat;

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

    /// Optional. The number of Telegram Stars that must be paid to upgrade the gift
    upgrade_star_count: ?i32 = null,

    /// The total number of the gifts of this type that can be sent; for limited gifts only
    total_count: ?i32,

    /// The number of remaining gifts of this type that can be sent; for limited gifts only
    remaining_count: ?i32,

    /// Optional. The total number of the gifts of this type that can be sent by the user
    personal_total_count: ?i32 = null,

    /// Optional. The number of remaining gifts of this type that can be sent by the user
    personal_remaining_count: ?i32 = null,

    /// Optional. True, if this gift is Telegram Premium
    is_premium: ?bool = null,

    /// Optional. True, if this gift has custom colors
    has_colors: ?bool = null,

    /// Optional. Number of unique gift variants
    unique_gift_variant_count: ?i32 = null,

    /// Optional. Chat that published the gift
    publisher_chat: ?Chat = null,
};
