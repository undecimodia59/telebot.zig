const types = @import("../types.zig");
const User = types.User;
const ShippingAddress = types.ShippingAddress;

/// This object contains information about an incoming shipping query.
pub const ShippingQuery = struct {
    /// Unique query identifier.
    id: []const u8, // Required

    /// User who sent the query.
    from: User, // Required

    /// Bot-specified invoice payload.
    invoice_payload: []const u8, // Required

    /// User-specified shipping address.
    shipping_address: ShippingAddress, // Required
};
