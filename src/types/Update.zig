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

/// This object represents an incoming update.
/// At most one of the optional parameters can be present in any given update.
pub const Update = struct {
    /// The update's unique identifier. Update identifiers start from a certain positive number and increase sequentially.
    /// This identifier becomes especially handy if you're using webhooks, since it allows you to ignore repeated updates
    /// or to restore the correct update sequence, should they get out of order. If there are no new updates for at least
    /// a week, then the identifier of the next update will be chosen randomly instead of sequentially.
    update_id: i64,

    /// New incoming message of any kind - text, photo, sticker, etc.
    message: ?Message = null,

    /// New version of a message that is known to the bot and was edited.
    /// This update may at times be triggered by changes to message fields that are either unavailable or not actively used by your bot.
    edited_message: ?Message = null,

    /// New incoming channel post of any kind - text, photo, sticker, etc.
    channel_post: ?Message = null,

    /// New version of a channel post that is known to the bot and was edited.
    /// This update may at times be triggered by changes to message fields that are either unavailable or not actively used by your bot.
    edited_channel_post: ?Message = null,

    /// The bot was connected to or disconnected from a business account, or a user edited an existing connection with the bot.
    business_connection: ?BusinessConnection = null,

    /// New message from a connected business account.
    business_message: ?Message = null,

    /// New version of a message from a connected business account.
    edited_business_message: ?Message = null,

    /// Messages were deleted from a connected business account.
    deleted_business_messages: ?BusinessMessagesDeleted = null,

    /// A reaction to a message was changed by a user. The bot must be an administrator in the chat and must
    /// explicitly specify "message_reaction" in the list of allowed_updates to receive these updates.
    /// The update isn't received for reactions set by bots.
    message_reaction: ?MessageReactionUpdated = null,

    /// Reactions to a message with anonymous reactions were changed. The bot must be an administrator in the chat
    /// and must explicitly specify "message_reaction_count" in the list of allowed_updates to receive these updates.
    /// The updates are grouped and can be sent with delay up to a few minutes.
    message_reaction_count: ?MessageReactionCountUpdated = null,

    /// New incoming inline query.
    inline_query: ?InlineQuery = null,

    /// The result of an inline query that was chosen by a user and sent to their chat partner.
    chosen_inline_result: ?ChosenInlineResult = null,

    /// New incoming callback query.
    callback_query: ?CallbackQuery = null,

    /// New incoming shipping query. Only for invoices with flexible price.
    shipping_query: ?ShippingQuery = null,

    /// New incoming pre-checkout query. Contains full information about checkout.
    pre_checkout_query: ?PreCheckoutQuery = null,

    /// A user purchased paid media with a non-empty payload sent by the bot in a non-channel chat.
    purchased_paid_media: ?PaidMediaPurchased = null,

    /// New poll state. Bots receive only updates about manually stopped polls and polls, which are sent by the bot.
    poll: ?Poll = null,

    /// A user changed their answer in a non-anonymous poll.
    /// Bots receive new votes only in polls that were sent by the bot itself.
    poll_answer: ?PollAnswer = null,

    /// The bot's chat member status was updated in a chat.
    /// For private chats, this update is received only when the bot is blocked or unblocked by the user.
    my_chat_member: ?ChatMemberUpdated = null,

    /// A chat member's status was updated in a chat.
    /// The bot must be an administrator in the chat and must explicitly specify "chat_member" in the list of allowed_updates to receive these updates.
    chat_member: ?ChatMemberUpdated = null,

    /// A request to join the chat has been sent. The bot must have the can_invite_users administrator right in the chat to receive these updates.
    chat_join_request: ?ChatJoinRequest = null,

    /// A chat boost was added or changed. The bot must be an administrator in the chat to receive these updates.
    chat_boost: ?ChatBoostUpdated = null,

    /// A boost was removed from a chat. The bot must be an administrator in the chat to receive these updates.
    removed_chat_boost: ?ChatBoostRemoved = null,
};
