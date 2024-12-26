const Update = @import("../../types/Update.zig").Update;
const EnumValue = @import("handling_values.zig").EnumValue;

/// This type used for bot.registerHandler()
pub const HandlingType = enum(EnumValue) {
    ANY,
    EditedMessage,
    ChannelPost,
    EditedChannelPost,
    BusinessConnection,
    BusinessMessage,
    EditedBusinessMessage,
    DeletedBusinessMessages,
    MessageReaction,
    MessageReactionCount,
    InlineQuery,
    ChoosenInlineResult,
    CallbackQuery,
    ShippingQuery,
    PreCheckoutQuery,
    PurchasedPaidMedia,
    Poll,
    PollAnswer,
    MyChatMember,
    ChatMember,
    ChatJoinRequest,
    ChatBoost,
    RemovedChatBoost,
    MessageText,
    MessagePhoto,
    MessageCommand,
};

pub fn HandlingTypeFromUpdate(update: Update) HandlingType {
    if (update.message) |m| {
        if (m.text) |text| {
            if (text[0] == '/') {
                return HandlingType.MessageCommand;
            } else {
                return HandlingType.MessageText;
            }
        } else if (m.photo) |_| {
            return HandlingType.MessagePhoto;
        }
        // TODO: Complete for all message types
        @panic("Type not supported!");
    } else if (update.business_connection) |_| {
        return HandlingType.BusinessConnection;
    } else if (update.business_message) |_| {
        return HandlingType.BusinessMessage;
    } else if (update.callback_query) |_| {
        return HandlingType.CallbackQuery;
    } else if (update.channel_post) |_| {
        return HandlingType.ChannelPost;
    } else if (update.chat_boost) |_| {
        return HandlingType.ChatBoost;
    } else if (update.chat_join_request) |_| {
        return HandlingType.ChatJoinRequest;
    } else if (update.chat_member) |_| {
        return HandlingType.ChatMember;
    } else if (update.chosen_inline_result) |_| {
        return HandlingType.ChoosenInlineResult;
    } else if (update.deleted_business_messages) |_| {
        return HandlingType.DeletedBusinessMessages;
    } else if (update.edited_business_message) |_| {
        return HandlingType.EditedBusinessMessage;
    } else if (update.edited_channel_post) |_| {
        return HandlingType.EditedChannelPost;
    } else if (update.edited_message) |_| {
        return HandlingType.EditedMessage;
    } else if (update.inline_query) |_| {
        return HandlingType.InlineQuery;
    } else if (update.message_reaction) |_| {
        return HandlingType.MessageReaction;
    } else if (update.message_reaction_count) |_| {
        return HandlingType.MessageReactionCount;
    } else if (update.my_chat_member) |_| {
        return HandlingType.MyChatMember;
    } else if (update.poll) |_| {
        return HandlingType.Poll;
    } else if (update.poll_answer) |_| {
        return HandlingType.PollAnswer;
    } else if (update.pre_checkout_query) |_| {
        return HandlingType.PreCheckoutQuery;
    } else if (update.purchased_paid_media) |_| {
        return HandlingType.PurchasedPaidMedia;
    } else if (update.removed_chat_boost) |_| {
        return HandlingType.RemovedChatBoost;
    } else if (update.shipping_query) |_| {
        return HandlingType.ShippingQuery;
    }

    unreachable;
}
