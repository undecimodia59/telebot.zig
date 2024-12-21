const std = @import("std");
const MessageEntity = @import("MessageEntity.zig").MessageEntity;
const PollOption = @import("PollOption.zig").PollOption;

/// Struct representing a poll.
pub const Poll = struct {
    /// Unique poll identifier.
    id: []const u8,

    /// Poll question, 1-300 characters.
    question: []const u8,

    /// Optional. Special entities that appear in the question. Currently, only custom emoji entities are allowed in poll questions.
    question_entities: ?[]MessageEntity,

    /// List of poll options.
    options: []PollOption,

    /// Total number of users that voted in the poll.
    total_voter_count: i32,

    /// True, if the poll is closed.
    is_closed: bool,

    /// True, if the poll is anonymous.
    is_anonymous: bool,

    /// Poll type, currently can be “regular” or “quiz”.
    type: []const u8,

    /// True, if the poll allows multiple answers.
    allows_multiple_answers: bool,

    /// Optional. 0-based identifier of the correct answer option. Available only for polls in the quiz mode, which are closed, or was sent (not forwarded) by the bot or to the private chat with the bot.
    correct_option_id: i32,

    /// Optional. Text that is shown when a user chooses an incorrect answer or taps on the lamp icon in a quiz-style poll, 0-200 characters.
    explanation: ?[]const u8,

    /// Optional. Special entities like usernames, URLs, bot commands, etc. that appear in the explanation.
    explanation_entities: ?[]MessageEntity,

    /// Optional. Amount of time in seconds the poll will be active after creation.
    open_period: ?i32,

    /// Optional. Point in time (Unix timestamp) when the poll will be automatically closed.
    close_date: ?i32,
};
