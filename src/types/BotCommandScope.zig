/// Determining list of commands
///
/// The following algorithm is used to determine the list of commands for a particular user viewing the bot menu.
/// The first list of commands which is set is returned:
///
/// Commands in the chat with the bot
///
///    botCommandScopeChat + language_code
///    botCommandScopeChat
///    botCommandScopeAllPrivateChats + language_code
///    botCommandScopeAllPrivateChats
///    botCommandScopeDefault + language_code
///    botCommandScopeDefault
///
/// Commands in group and supergroup chats
///
///    botCommandScopeChatMember + language_code
///    botCommandScopeChatMember
///    botCommandScopeChatAdministrators + language_code (administrators only)
///    botCommandScopeChatAdministrators (administrators only)
///    botCommandScopeChat + language_code
///    botCommandScopeChat
///    botCommandScopeAllChatAdministrators + language_code (administrators only)
///    botCommandScopeAllChatAdministrators (administrators only)
///    botCommandScopeAllGroupChats + language_code
///    botCommandScopeAllGroupChats
///    botCommandScopeDefault + language_code
///    botCommandScopeDefault
pub const BotCommandScope = union(enum) {
    BotCommandScopeDefault: struct {
        /// Scope type, must be "default"
        type: []const u8 = "default",
    },

    BotCommandScopeAllPrivateChats: struct {
        /// Scope type, must be "all_private_chats"
        type: []const u8 = "all_private_chats",
    },

    BotCommandScopeAllGroupChats: struct {
        /// Scope type, must be "all_group_chats"
        type: []const u8 = "all_group_chats",
    },

    BotCommandScopeAllChatAdministrators: struct {
        /// Scope type, must be "all_chat_administrators"
        type: []const u8 = "all_chat_administrators",
    },

    BotCommandScopeChat: struct {
        /// Scope type, must be "chat"
        type: []const u8 = "chat",
        /// Unique identifier for the target chat or username of the target supergroup
        chat_id: []const u8,
    },

    BotCommandScopeChatAdministrators: struct {
        /// Scope type, must be "chat_administrators"
        type: []const u8 = "chat_administrators",
        /// Unique identifier for the target chat or username of the target supergroup
        chat_id: []const u8,
    },

    BotCommandScopeChatMember: struct {
        /// Scope type, must be "chat_member"
        type: []const u8 = "chat_member",
        /// Unique identifier for the target chat or username of the target supergroup
        chat_id: []const u8,
        /// Unique identifier of the target user
        user_id: i32,
    },
};
