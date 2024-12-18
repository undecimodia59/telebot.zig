const types = @import("../types.zig");
const User = types.User;
const OrderInfo = types.OrderInfo;

/// This object contains information about an incoming pre-checkout query
pub const PreCheckoutQuery = struct {
    /// Unique query identifier.
    id: []const u8, // Required

    /// User who sent the query.
    from: User, // Required

    /// Three-letter ISO 4217 currency code, or “XTR” for payments in Telegram Stars.
    currency: []const u8, // Required

    /// Total price in the smallest units of the currency (integer, not float/double).
    /// For example, for a price of US$ 1.45 pass amount = 145. See the exp parameter in currencies.json,
    /// it shows the number of digits past the decimal point for each currency (2 for the majority of currencies).
    total_amount: i64, // Required

    /// Bot-specified invoice payload.
    invoice_payload: []const u8, // Required

    /// Identifier of the shipping option chosen by the user.
    shipping_option_id: ?[]const u8 = null, // Optional

    /// Order information provided by the user.
    order_info: ?OrderInfo = null, // Optional
};
