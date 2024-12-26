const types = @import("types.zig");
const Message = types.Message;
const BusinessConnection = types.BusinessConnection;
const BusinessMessagesDeleted = types.BusinessMessagesDeleted;
const MessageReactionUpdated = types.MessageReactionUpdated;
const MessageReactionCountUpdated = types.MessageReactionCountUpdated;
const CallbackQuery = types.CallbackQuery;
const Poll = types.Poll;
const PollAnswer = types.PollAnswer;
const ChatMemberUpdated = types.ChatMemberUpdated;
const ChatJoinRequest = types.ChatJoinRequest;
const ChatBoostUpdated = types.ChatBoostUpdated;
const ChatBoostRemoved = types.ChatBoostRemoved;

const InlineQuery = @import("inline_mode/InlineQuery.zig").InlineQuery;
const ChosenInlineResult = @import("inline_mode/ChosenInlineResult.zig").ChosenInlineResult;

const ShippingQuery = @import("payments/ShippingQuery.zig").ShippingQuery;
const PreCheckoutQuery = @import("payments/PreCheckoutQuery.zig").PreCheckoutQuery;
const PaidMediaPurchased = @import("payments/PaidMediaPurchased.zig").PaidMediaPurchased;

pub const UpdateRaw = struct {
    update_id: i64,
    message: ?Message = null,
    edited_message: ?Message = null,
    channel_post: ?Message = null,
    edited_channel_post: ?Message = null,
    business_connection: ?BusinessConnection = null,
    business_message: ?Message = null,
    edited_business_message: ?Message = null,
    deleted_business_messages: ?BusinessMessagesDeleted = null,
    message_reaction: ?MessageReactionUpdated = null,
    message_reaction_count: ?MessageReactionCountUpdated = null,
    inline_query: ?InlineQuery = null,
    chosen_inline_result: ?ChosenInlineResult = null,
    callback_query: ?CallbackQuery = null,
    shipping_query: ?ShippingQuery = null,
    pre_checkout_query: ?PreCheckoutQuery = null,
    purchased_paid_media: ?PaidMediaPurchased = null,
    poll: ?Poll = null,
    poll_answer: ?PollAnswer = null,
    my_chat_member: ?ChatMemberUpdated = null,
    chat_member: ?ChatMemberUpdated = null,
    chat_join_request: ?ChatJoinRequest = null,
    chat_boost: ?ChatBoostUpdated = null,
    removed_chat_boost: ?ChatBoostRemoved = null,
};
