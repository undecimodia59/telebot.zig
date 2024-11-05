const ShippingAddress = @import("ShippingAddress.zig").ShippingAddress;

/// Struct representing order information
pub const OrderInfo = struct {
    /// Optional. User name
    name: ?[]const u8,

    /// Optional. User's phone number
    phone_number: ?[]const u8,

    /// Optional. User email
    email: ?[]const u8,

    /// Optional. User shipping address
    shipping_address: ?ShippingAddress,
};
