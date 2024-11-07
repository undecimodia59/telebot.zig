pub const ResponseParameters = struct {
    // Optional. The group has been migrated to a supergroup with the specified identifier.
    migrate_to_chat_id: ?i64,
    // Optional. In case of exceeding flood control, the number of seconds left to wait before the request can be repeated
    retry_after: ?i32,
};
