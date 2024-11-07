/// Represents an interface to prompt the user to reply to a bot message. Useful for guiding
/// users through step-by-step interactions in privacy mode without losing context.
/// Example:
///
/// ```
/// const forceReplyExample = ForceReply{
///     .force_reply = true,
///     .input_field_placeholder = "Please enter your answer",
///     .selective = true,
/// };
/// ```
///
/// This example could be used in a polling bot to guide users through creating a new poll:
/// 1. 'Please send me your question'
/// 2. 'Cool, now let's add the first answer option'
/// 3. 'Great. Keep adding answer options, then send /done when you're ready'
pub const ForceReply = struct {
    /// Shows reply interface to the user, as if they manually selected the bot's message and tapped 'Reply'.
    force_reply: bool,
    /// Optional. The placeholder to be shown in the input field when the reply is active; must be 1-64 characters.
    input_field_placeholder: ?[]const u8 = null,
    /// Optional. Use this parameter to request a reply only from specific users, such as those mentioned in a message or the original sender of a replied message.
    selective: ?bool = null,
};
