const std = @import("std");
const Chat = @import("Chat.zig").Chat;

/// Struct representing a giveaway.
pub const Giveaway = struct {
    /// The list of chats which the user must join to participate in the giveaway.
    chats: []Chat,

    /// Point in time (Unix timestamp) when winners of the giveaway will be selected.
    winners_selection_date: i32,

    /// The number of users which are supposed to be selected as winners of the giveaway.
    winner_count: i32,

    /// Optional. True, if only users who join the chats after the giveaway started should be eligible to win.
    only_new_members: ?bool,

    /// Optional. True, if the list of giveaway winners will be visible to everyone.
    has_public_winners: ?bool,

    /// Optional. Description of additional giveaway prize.
    prize_description: ?[]const u8,

    /// Optional. A list of two-letter ISO 3166-1 alpha-2 country codes indicating the countries from which eligible users for the giveaway must come.
    /// If empty, then all users can participate in the giveaway. Users with a phone number that was bought on Fragment can always participate in giveaways.
    country_codes: ?[][]const u8,

    /// Optional. The number of Telegram Stars to be split between giveaway winners; for Telegram Star giveaways only.
    prize_star_count: ?i32,

    /// Optional. The number of months the Telegram Premium subscription won from the giveaway will be active for; for Telegram Premium giveaways only.
    premium_subscription_month_count: ?i32,
};
