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
        // Here's find based on fields
        _ = m;
    } else if (update.business_connection) {
        return HandlingType.BusinessConnection;
    } else if (update.business_message) {
        return HandlingType.BusinessMessage;
    } else if (update.callback_query) {
        return HandlingType.CallbackQuery;
    } else if (update.channel_post) {
        return HandlingType.ChannelPost;
    } else if (update.chat_boost) {
        return HandlingType.ChatBoost;
    } else if (update.chat_join_request) {
        return HandlingType.ChatJoinRequest;
    } else if (update.chat_member) {
        return HandlingType.ChatMember;
    } else if (update.chosen_inline_result) {
        return HandlingType.ChoosenInlineResult;
    } else if (update.deleted_business_messages) {
        return HandlingType.DeletedBusinessMessages;
    } else if (update.edited_business_message) {
        return HandlingType.EditedBusinessMessage;
    } else if (update.edited_channel_post) {
        return HandlingType.EditedChannelPost;
    } else if (update.edited_message) {
        return HandlingType.EditedMessage;
    } else if (update.inline_query) {
        return HandlingType.InlineQuery;
    } else if (update.message_reaction) {
        return HandlingType.MessageReaction;
    } else if (update.message_reaction_count) {
        return HandlingType.MessageReactionCount;
    } else if (update.my_chat_member) {
        return HandlingType.MyChatMember;
    } else if (update.poll) {
        return HandlingType.Poll;
    } else if (update.poll_answer) {
        return HandlingType.PollAnswer;
    } else if (update.pre_checkout_query) {
        return HandlingType.PreCheckoutQuery;
    } else if (update.purchased_paid_media) {
        return HandlingType.PurchasedPaidMedia;
    } else if (update.removed_chat_boost) {
        return HandlingType.RemovedChatBoost;
    } else if (update.shipping_query) {
        return HandlingType.ShippingQuery;
    } else {
        unreachable;
    }
}
