/// Struct representing a shipping address
pub const ShippingAddress = struct {
    /// ISO 3166-1 alpha-2 country code
    country_code: []const u8,

    /// State, if applicable
    state: []const u8,

    /// City
    city: []const u8,

    /// First line for the address
    street_line1: []const u8,

    /// Second line for the address
    street_line2: []const u8,

    /// Address post code
    post_code: []const u8,
};
