const User = @import("User.zig").User;

pub const ChatInviteLink = struct {
    /// The invite link. If created by another chat administrator, the second part may be replaced with “…”.
    invite_link: []const u8,
    /// The user who created the link.
    creator: User,
    /// True if users joining via the link need administrator approval.
    creates_join_request: bool,
    /// True if this is the primary invite link.
    is_primary: bool,
    /// True if this invite link has been revoked.
    is_revoked: bool,
    /// Optional. Name of the invite link.
    name: ?[]const u8 = null,
    /// Optional. Expiration time of the link in Unix timestamp.
    expire_date: ?i64 = null,
    /// Optional. Maximum number of members that can join via this link; 1-99999.
    member_limit: ?i32 = null,
    /// Optional. Number of pending join requests via this link.
    pending_join_request_count: ?i32 = null,
    /// Optional. Duration in seconds for active subscription before renewal.
    subscription_period: ?i32 = null,
    /// Optional. Cost in Telegram Stars required for initial and recurring subscription.
    subscription_price: ?i32 = null,
};
