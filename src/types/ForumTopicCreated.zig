// Struct representing a created forum topic
pub const ForumTopicCreated = struct {
    // Name of the topic
    name: *const u8,

    // Color of the topic icon in RGB format
    icon_color: i32,

    // Optional. Unique identifier of the custom emoji
    icon_custom_emoji_id: ?*const u8,
};
