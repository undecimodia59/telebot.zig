const std = @import("std");
const Chat = @import("Chat.zig").Chat;
const User = @import("User.zig").User;

/// Struct representing the winners of a giveaway.
pub const GiveawayWinners = struct {
    /// The chat that created the giveaway.
    chat: Chat,

    /// Identifier of the message with the giveaway in the chat.
    giveaway_message_id: i32,

    /// Point in time (Unix timestamp) when winners of the giveaway were selected.
    winners_selection_date: i32,

    /// Total number of winners in the giveaway.
    winner_count: i32,

    /// List of up to 100 winners of the giveaway.
    winners: []User,

    /// Optional. The number of other chats the user had to join in order to be eligible for the giveaway.
    additional_chat_count: ?i32,

    /// Optional. The number of Telegram Stars that were split between giveaway winners; for Telegram Star giveaways only.
    prize_star_count: ?i32,

    /// Optional. The number of months the Telegram Premium subscription won from the giveaway will be active for; for Telegram Premium giveaways only.
    premium_subscription_month_count: ?i32,

    /// Optional. Number of undistributed prizes.
    unclaimed_prize_count: ?i32,

    /// Optional. True, if only users who had joined the chats after the giveaway started were eligible to win.
    only_new_members: ?bool,

    /// Optional. True, if the giveaway was canceled because the payment for it was refunded.
    was_refunded: ?bool,

    /// Optional. Description of additional giveaway prize.
    prize_description: ?[]const u8,
};
