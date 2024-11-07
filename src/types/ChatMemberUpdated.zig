const Chat = @import("Chat.zig").Chat;
const User = @import("User.zig").User;
const ChatMember = @import("ChatMember.zig").ChatMember;
const ChatInviteLink = @import("ChatInviteLink.zig").ChatInviteLink;

pub const ChatMemberUpdated = struct {
    /// Chat the user belongs to
    chat: Chat,
    /// Performer of the action which resulted in the change
    from: User,
    /// Date the change was done in Unix time
    date: i32,
    /// Previous information about the chat member
    old_chat_member: ChatMember,
    /// New information about the chat member
    new_chat_member: ChatMember,
    /// Chat invite link, used by the user to join the chat; for joining by invite link events only
    invite_link: ?ChatInviteLink = null,
    /// True if the user joined the chat after sending a direct join request without using an invite link and being approved by an administrator
    via_join_request: ?bool = null,
    /// True if the user joined the chat via a chat folder invite link
    via_chat_folder_invite_link: ?bool = null,
};
