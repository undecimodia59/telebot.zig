const std = @import("std");
const Chat = @import("Chat.zig").Chat;
const User = @import("User.zig").User;

pub const PollAnswer = struct {
    /// Unique poll identifier.
    poll_id: []const u8,

    /// Optional. The chat that changed the answer to the poll, if the voter is anonymous.
    voter_chat: ?Chat = null,

    /// Optional. The user that changed the answer to the poll, if the voter isn't anonymous.
    user: ?User = null,

    /// 0-based identifiers of chosen answer options. May be empty if the vote was retracted.
    option_ids: []u32,
};
