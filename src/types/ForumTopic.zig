pub const ForumTopic = struct {
    /// Unique identifier of the forum topic
    message_thread_id: i32,
    /// Name of the topic
    name: []const u8,
    /// Color of the topic icon in RGB format
    icon_color: i32,
    /// Optional. Unique identifier of the custom emoji shown as the topic icon
    icon_custom_emoji_id: ?[]const u8,
};
