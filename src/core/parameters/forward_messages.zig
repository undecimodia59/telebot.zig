pub const ForwardMessagesParameters = struct {
    /// Unique identifier for the target chat
    /// Not supporting username of the target channel (in the format @channelusername)
    chat_id: i64,

    /// Unique identifier for the target message thread (topic) of the forum; for forum supergroups only
    message_thread_id: ?i64 = null,

    /// Unique identifier for the chat where the original message was sent
    /// (@username is not supported)
    from_chat_id: i64,

    /// Sends the message silently. Users will receive a notification with no sound
    disable_notification: ?bool = null,

    /// Protects the contents of the forwarded message from forwarding and saving
    protect_content: ?bool = null,

    /// Message identifier in the chat specified in from_chat_id
    message_ids: []i64,
};
