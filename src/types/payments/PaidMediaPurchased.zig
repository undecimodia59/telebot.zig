const User = @import("../types.zig").User;

/// This object contains information about a paid media purchase
pub const PaidMediaPurchased = struct {
    /// User who purchased the media.
    from: User,

    /// Bot-specified paid media payload.
    paid_media_payload: []const u8,
};
