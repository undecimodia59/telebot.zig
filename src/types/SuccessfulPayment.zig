const OrderInfo = @import("OrderInfo.zig").OrderInfo;

/// Struct representing a successful payment
pub const SuccessfulPayment = struct {
    /// Three-letter ISO 4217 currency code
    currency: []const u8,

    /// Total price in the smallest units of the currency
    total_amount: i32,

    /// Bot specified invoice payload
    invoice_payload: []const u8,

    /// Optional. Identifier of the shipping option chosen by the user
    shipping_option_id: ?[]const u8,

    /// Optional. Order info provided by the user
    order_info: ?OrderInfo,

    /// Telegram payment identifier
    telegram_payment_charge_id: []const u8,

    /// Provider payment identifier
    provider_payment_charge_id: []const u8,
};
