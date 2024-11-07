const User = @import("User.zig").User;

pub const ChatMember = union(enum) {
    ChatMemberOwner: struct {
        /// The member's status in the chat, always “creator”
        status: []const u8 = "creator",
        /// Information about the user
        user: User,
        /// True if the user's presence in the chat is hidden
        is_anonymous: bool,
        /// Custom title for this user
        custom_title: ?[]const u8 = null,
    },
    ChatMemberAdministrator: struct {
        /// The member's status in the chat, always “administrator”
        status: []const u8 = "administrator",
        /// Information about the user
        user: User,
        /// True, if the bot is allowed to edit administrator privileges of that user
        can_be_edited: bool,
        /// True, if the user's presence in the chat is hidden
        is_anonymous: bool,
        /// True, if the administrator can access the chat event log, get boost list, see hidden supergroup and channel members, report spam messages and ignore slow mode
        can_manage_chat: bool,
        /// True, if the administrator can delete messages of other users
        can_delete_messages: bool,
        /// True, if the administrator can manage video chats
        can_manage_video_chats: bool,
        /// True, if the administrator can restrict, ban or unban chat members, or access supergroup statistics
        can_restrict_members: bool,
        /// True, if the administrator can add new administrators with a subset of their own privileges or demote administrators that they have promoted
        can_promote_members: bool,
        /// True, if the user is allowed to change the chat title, photo and other settings
        can_change_info: bool,
        /// True, if the user is allowed to invite new users to the chat
        can_invite_users: bool,
        /// True, if the administrator can post stories to the chat
        can_post_stories: bool,
        /// True, if the administrator can edit stories posted by other users, post stories to the chat page, pin chat stories, and access the chat's story archive
        can_edit_stories: bool,
        /// True, if the administrator can delete stories posted by other users
        can_delete_stories: bool,
        /// Optional. True, if the administrator can post messages in the channel, or access channel statistics; for channels only
        can_post_messages: ?bool = null,
        /// Optional. True, if the administrator can edit messages of other users and can pin messages; for channels only
        can_edit_messages: ?bool = null,
        /// Optional. True, if the user is allowed to pin messages; for groups and supergroups only
        can_pin_messages: ?bool = null,
        /// Optional. True, if the user is allowed to create, rename, close, and reopen forum topics; for supergroups only
        can_manage_topics: ?bool = null,
        /// Custom title for this user
        custom_title: ?[]const u8 = null,
    },
    ChatMemberMember: struct {
        /// The member's status in the chat, always “member”
        status: []const u8 = "member",
        /// Information about the user
        user: User,
        /// Optional. Date when the user's subscription will expire; Unix time
        until_date: ?i32 = null,
    },
    ChatMemberRestricted: struct {
        /// The member's status in the chat, always “restricted”
        status: []const u8 = "restricted",
        /// Information about the user
        user: User,
        /// True, if the user is a member of the chat at the moment of the request
        is_member: bool,
        /// True, if the user is allowed to send text messages, contacts, giveaways, giveaway winners, invoices, locations and venues
        can_send_messages: bool,
        /// True, if the user is allowed to send audios
        can_send_audios: bool,
        /// True, if the user is allowed to send documents
        can_send_documents: bool,
        /// True, if the user is allowed to send photos
        can_send_photos: bool,
        /// True, if the user is allowed to send videos
        can_send_videos: bool,
        /// True, if the user is allowed to send video notes
        can_send_video_notes: bool,
        /// True, if the user is allowed to send voice notes
        can_send_voice_notes: bool,
        /// True, if the user is allowed to send polls
        can_send_polls: bool,
        /// True, if the user is allowed to send animations, games, stickers and use inline bots
        can_send_other_messages: bool,
        /// True, if the user is allowed to add web page previews to their messages
        can_add_web_page_previews: bool,
        /// True, if the user is allowed to change the chat title, photo and other settings
        can_change_info: bool,
        /// True, if the user is allowed to invite new users to the chat
        can_invite_users: bool,
        /// True, if the user is allowed to pin messages
        can_pin_messages: bool,
        /// True, if the user is allowed to create forum topics
        can_manage_topics: bool,
        /// Date when restrictions will be lifted for this user; Unix time. If 0, then the user is restricted forever
        until_date: i32,
    },
    ChatMemberLeft: struct {
        /// The member's status in the chat, always “left”
        status: []const u8 = "left",
        /// Information about the user
        user: User,
    },
    ChatMemberBanned: struct {
        /// The member's status in the chat, always “kicked”
        status: []const u8 = "kicked",
        /// Information about the user
        user: User,
        /// Date when restrictions will be lifted for this user; Unix time. If 0, then the user is banned forever
        until_date: i32,
    },
};
