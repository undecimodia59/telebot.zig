pub const ChatAdministratorRights = struct {
    /// True, if the user's presence in the chat is hidden.
    is_anonymous: bool,

    /// True, if the administrator can access the chat event log, get boost list, see hidden supergroup and channel members, report spam messages and ignore slow mode. Implied by any other administrator privilege.
    can_manage_chat: bool,

    /// True, if the administrator can delete messages of other users.
    can_delete_messages: bool,

    /// True, if the administrator can manage video chats.
    can_manage_video_chats: bool,

    /// True, if the administrator can restrict, ban or unban chat members, or access supergroup statistics.
    can_restrict_members: bool,

    /// True, if the administrator can add new administrators with a subset of their own privileges or demote administrators that they have promoted, directly or indirectly.
    can_promote_members: bool,

    /// True, if the user is allowed to change the chat title, photo and other settings.
    can_change_info: bool,

    /// True, if the user is allowed to invite new users to the chat.
    can_invite_users: bool,

    /// True, if the administrator can post stories to the chat.
    can_post_stories: bool,

    /// True, if the administrator can edit stories posted by other users, post stories to the chat page, pin chat stories, and access the chat's story archive.
    can_edit_stories: bool,

    /// True, if the administrator can delete stories posted by other users.
    can_delete_stories: bool,

    /// Optional. True, if the administrator can post messages in the channel, or access channel statistics; for channels only.
    can_post_messages: ?bool,

    /// Optional. True, if the administrator can edit messages of other users and can pin messages; for channels only.
    can_edit_messages: ?bool,

    /// Optional. True, if the user is allowed to pin messages; for groups and supergroups only.
    can_pin_messages: ?bool,

    /// Optional. True, if the user is allowed to create, rename, close, and reopen forum topics; for supergroups only.
    can_manage_topics: ?bool,
};
