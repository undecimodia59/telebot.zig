const ChatPhoto = @import("ChatPhoto.zig").ChatPhoto;
const Birthdate = @import("Birthdate.zig").Birthdate;
const BusinessIntro = @import("BusinessIntro.zig").BusinessIntro;
const BusinessLocation = @import("BusinessLocation.zig").BusinessLocation;
const BusinessOpeningHours = @import("BusinessOpeningHours.zig").BusinessOpeningHours;
const Chat = @import("Chat.zig").Chat;
const ReactionType = @import("ReactionType.zig").ReactionType;
const ChatPermissions = @import("ChatPermissions.zig").ChatPermissions;
const Message = @import("Message.zig").Message;
const ChatLocation = @import("ChatLocation.zig").ChatLocation;

/// Struct representing full information about a chat
pub const ChatFullInfo = struct {
    /// Unique identifier for this chat. This number may have more than 32 significant bits
    /// and some programming languages may have difficulty/silent defects in interpreting it.
    /// But it has at most 52 significant bits, so a signed 64-bit integer or
    /// double-precision float type are safe for storing this identifier.
    id: i64,

    /// Type of the chat, can be either “private”, “group”, “supergroup” or “channel”
    chat_type: []const u8,

    /// Optional. Title, for supergroups, channels and group chats
    title: ?[]const u8,

    /// Optional. Username, for private chats, supergroups and channels if available
    username: ?[]const u8,

    /// Optional. First name of the other party in a private chat
    first_name: ?[]const u8,

    /// Optional. Last name of the other party in a private chat
    last_name: ?[]const u8,

    /// Optional. True, if the supergroup chat is a forum (has topics enabled)
    is_forum: ?bool,

    /// Identifier of the accent color for the chat name and backgrounds
    /// of the chat photo, reply header, and link preview.
    accent_color_id: ?i64,

    /// The maximum number of reactions that can be set on a message in the chat
    max_reaction_count: ?i64,

    /// Optional. Chat photo
    photo: ?ChatPhoto,

    /// Optional. If non-empty, the list of all active chat usernames; for private chats,
    /// supergroups and channels
    active_usernames: ?[]const []const u8,

    /// Optional. For private chats, the date of birth of the user
    birthdate: ?Birthdate,

    /// Optional. For private chats with business accounts, the intro of the business
    business_intro: ?BusinessIntro,

    /// Optional. For private chats with business accounts, the location of the business
    business_location: ?BusinessLocation,

    /// Optional. For private chats with business accounts, the opening hours of the business
    business_opening_hours: ?BusinessOpeningHours,

    /// Optional. For private chats, the personal channel of the user
    personal_chat: ?Chat,

    /// Optional. List of available reactions allowed in the chat.
    /// If omitted, then all emoji reactions are allowed.
    available_reactions: ?[]const ReactionType,

    /// Optional. Custom emoji identifier of the emoji chosen by the chat for the
    /// reply header and link preview background
    background_custom_emoji_id: ?[]const u8,

    /// Optional. Identifier of the accent color for the chat's profile background.
    /// See profile accent colors for more details.
    profile_accent_color_id: ?i64,

    /// Optional. Custom emoji identifier of the emoji chosen by the chat for its profile background
    profile_background_custom_emoji_id: ?[]const u8,

    /// Optional. Custom emoji identifier of the emoji status of the chat or the
    /// other party in a private chat
    emoji_status_custom_emoji_id: ?[]const u8,

    /// Optional. Expiration date of the emoji status of the chat or the
    /// other party in a private chat, in Unix time, if any
    emoji_status_expiration_date: ?i64,

    /// Optional. Bio of the other party in a private chat
    bio: ?[]const u8,

    /// Optional. True, if privacy settings of the other party in the private chat allows to
    /// use tg://user?id=<user_id> links only in chats with the user
    has_private_forwards: ?bool,

    /// Optional. True, if the privacy settings of the other party restrict sending
    /// voice and video note messages in the private chat
    has_restricted_voice_and_video_messages: ?bool,

    /// Optional. True, if users need to join the supergroup before they can send messages
    join_to_send_messages: ?bool,

    /// Optional. True, if all users directly joining the supergroup without using
    /// an invite link need to be approved by supergroup administrators
    join_by_request: ?bool,

    /// Optional. Description, for groups, supergroups and channel chats
    description: ?[]const u8,

    /// Optional. Primary invite link, for groups, supergroups and channel chats
    invite_link: ?[]const u8,

    /// Optional. The most recent pinned message (by sending date)
    pinned_message: ?Message,

    /// Optional. Default chat member permissions, for groups and supergroups
    permissions: ?ChatPermissions,

    /// Optional. True, if paid media messages can be sent or forwarded to the channel chat.
    /// The field is available only for channel chats.
    can_send_paid_media: ?bool,

    /// Optional. For supergroups, the minimum allowed delay between consecutive messages
    /// sent by each unprivileged user; in seconds
    slow_mode_delay: ?i64,

    /// Optional. For supergroups, the minimum number of boosts that a non-administrator
    /// user needs to add in order to ignore slow mode and chat permissions
    unrestrict_boost_count: ?i64,

    /// Optional. The time after which all messages sent to the chat will be
    /// automatically deleted; in seconds
    message_auto_delete_time: ?i64,

    /// Optional. True, if aggressive anti-spam checks are enabled in the supergroup.
    /// The field is only available to chat administrators.
    has_aggressive_anti_spam_enabled: ?bool,

    /// Optional. True, if non-administrators can only get the list of bots and administrators in the chat
    has_hidden_members: ?bool,

    /// Optional. True, if messages from the chat can't be forwarded to other chats
    has_protected_content: ?bool,

    /// Optional. True, if new chat members will have access to old messages;
    /// available only to chat administrators
    has_visible_history: ?bool,

    /// Optional. For supergroups, name of the group sticker set
    sticker_set_name: ?[]const u8,

    /// Optional. True, if the bot can change the group sticker set
    can_set_sticker_set: ?bool,

    /// Optional. For supergroups, the name of the group's custom emoji sticker set.
    /// Custom emoji from this set can be used by all users and bots in the group.
    custom_emoji_sticker_set_name: ?[]const u8,

    /// Optional. Unique identifier for the linked chat,
    /// i.e. the discussion group identifier for a channel and vice versa;
    /// for supergroups and channel chats.
    linked_chat_id: ?i64,

    /// Optional. For supergroups, the location to which the supergroup is connected
    location: ?ChatLocation,
};
