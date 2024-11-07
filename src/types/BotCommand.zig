pub const BotCommand = struct {
    /// Text of the command; 1-32 characters. Can contain only lowercase English letters, digits and underscores
    command: []const u8,
    /// Description of the command; 1-256 characters
    description: []const u8,
};
