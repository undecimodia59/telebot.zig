const std = @import("std");

pub const PollTypeError = error{
    InvalidPollType,
};

/// Enum representing the type of poll.
pub const PollType = enum {
    REGULAR,
    QUIZ,

    /// Converts a string representation of a poll type to the corresponding PollType enum.
    pub fn from_string(poll_type: []const u8) PollTypeError!PollType {
        if (std.mem.eql(u8, poll_type, "regular")) {
            return PollType.REGULAR;
        } else if (std.mem.eql(u8, poll_type, "quiz")) {
            return PollType.QUIZ;
        } else {
            return PollTypeError.InvalidPollType;
        }
    }
};
