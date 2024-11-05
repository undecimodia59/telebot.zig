/// Struct representing a refunded payment
pub const RefundedPayment = struct {
    /// Three-letter ISO 4217 currency code, or “XTR” for payments in Telegram Stars
    currency: []const u8,

    /// Total refunded price in the smallest units of the currency
    total_amount: i32,

    /// Bot-specified invoice payload
    invoice_payload: []const u8,

    /// Telegram payment identifier
    telegram_payment_charge_id: []const u8,

    /// Optional. Provider payment identifier
    provider_payment_charge_id: ?*const u8,
};
