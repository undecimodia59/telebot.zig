pub const ForwardMessageParameters = struct {
    /// Unique identifier for the target chat
    /// Not supporting username of the target channel (in the format @channelusername)
    chat_id: i64,

    /// Unique identifier for the target message thread (topic) of the forum; for forum supergroups only
    message_thread_id: ?i64 = null,

    /// Unique identifier for the target direct messages chat topic; for channel direct messages chats only
    direct_messages_topic_id: ?i64 = null,

    /// Unique identifier for the chat where the original message was sent
    /// (@username is not supported)
    from_chat_id: i64,

    /// Sends the message silently. Users will receive a notification with no sound
    disable_notification: ?bool = null,

    /// Protects the contents of the forwarded message from forwarding and saving
    protect_content: ?bool = null,

    /// Unique identifier of the message effect to be added to the message; for private chats only
    message_effect_id: ?[]const u8 = null,

    /// New start timestamp for forwarded video
    video_start_timestamp: ?i32 = null,

    /// A JSON-serialized object describing the suggested post parameters
    suggested_post_parameters: ?[]u8 = null,

    /// Message identifier in the chat specified in from_chat_id
    message_id: i64,
};
