const std = @import("std");

/// Struct representing an invoice.
pub const Invoice = struct {
    /// Product name.
    title: []const u8,

    /// Product description.
    description: []const u8,

    /// Unique bot deep-linking parameter that can be used to generate this invoice.
    start_parameter: []const u8,

    /// Three-letter ISO 4217 currency code, or “XTR” for payments in Telegram Stars.
    currency: []const u8,

    /// Total price in the smallest units of the currency (integer, not float/double).
    total_amount: i32,
};
