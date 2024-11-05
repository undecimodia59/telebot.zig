// Struct representing an edited forum topic
pub const ForumTopicEdited = struct {
    // New name of the topic, if it was edited
    name: ?*const u8,

    // New identifier of the custom emoji shown as the topic icon, if it was edited;
    // an empty string if the icon was removed
    icon_custom_emoji_id: ?*const u8,
};
