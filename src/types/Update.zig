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

const Bot = @import("../core/bot.zig").Bot;
const ApiError = @import("../core/error.zig").ApiError;

const params = @import("../core/parameters/parameters.zig");
const json = @import("../json/parser.zig");

const UpdateRaw = @import("UpdateRaw.zig").UpdateRaw;

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

    /// Pointer to bot, if received not in router WILL BE NULLPOINTER!
    /// Use this field only in router!
    _bot: ?*Bot = null,

    /// You can set .chat_id to 0 and it will be automatically based on update
    pub fn reply(self: Update, options: params.sendMessageParams) !json.ParsedResult(Message) {
        options.chat_id = self.getUpdateDialog();
        return try self._bot.?.sendMessage(options);
    }

    fn getUpdateDialog(self: Update) ApiError!i64 {
        if (self.message) |m| {
            return m.chat.id;
        } else if (self.edited_message) |m| {
            return m.chat.id;
        } else if (self.channel_post) |m| {
            return m.chat.id;
        } else if (self.edited_channel_post) |m| {
            return m.chat.id;
        } else if (self.business_connection) |c| {
            return c.user.id;
        } else if (self.edited_business_message) |m| {
            return m.chat.id;
        } else if (self.deleted_business_messages) |bmd| {
            return bmd.chat.id;
        } else if (self.message_reaction) |r| {
            return r.chat.id;
        } else if (self.message_reaction_count) |rc| {
            return rc.chat.id;
        } else if (self.inline_query) |iq| {
            return iq.from.id;
        } else if (self.chosen_inline_result) |cir| {
            return cir.from.id;
        } else if (self.callback_query) |cq| {
            return cq.from.id; // TODO: Change to cq.message.?
        } else if (self.shipping_query) |sq| {
            return sq.from.id;
        } else if (self.pre_checkout_query) |pcq| {
            return pcq.from.id;
        } else if (self.purchased_paid_media) |ppm| {
            return ppm.from.id;
        } else if (self.poll) {
            return ApiError.UpdateReplyError;
        } else if (self.poll_answer) |pa| {
            return if (pa.voter_chat) |chat| chat.id else ApiError.UpdateReplyError;
        } else if (self.my_chat_member) |mcm| {
            return mcm.chat.id;
        } else if (self.chat_member) |cm| {
            return cm.chat.id;
        } else if (self.chat_join_request) |cjr| {
            return cjr.user_chat_id;
        } else if (self.chat_boost) |cb| {
            return cb.chat.id;
        } else if (self.removed_chat_boost) |rcb| {
            return rcb.chat.id;
        }
    }
    /// Initialize Update from UpdateRaw and Bot
    pub fn fromRaw(raw: UpdateRaw, bot: *Bot) Update {
        return Update{
            .update_id = raw.update_id,
            .message = raw.message,
            .edited_message = raw.edited_message,
            .channel_post = raw.channel_post,
            .edited_channel_post = raw.edited_channel_post,
            .business_connection = raw.business_connection,
            .business_message = raw.business_message,
            .edited_business_message = raw.edited_business_message,
            .deleted_business_messages = raw.deleted_business_messages,
            .message_reaction = raw.message_reaction,
            .message_reaction_count = raw.message_reaction_count,
            .inline_query = raw.inline_query,
            .chosen_inline_result = raw.chosen_inline_result,
            .callback_query = raw.callback_query,
            .shipping_query = raw.shipping_query,
            .pre_checkout_query = raw.pre_checkout_query,
            .purchased_paid_media = raw.purchased_paid_media,
            .poll = raw.poll,
            .poll_answer = raw.poll_answer,
            .my_chat_member = raw.my_chat_member,
            .chat_member = raw.chat_member,
            .chat_join_request = raw.chat_join_request,
            .chat_boost = raw.chat_boost,
            .removed_chat_boost = raw.removed_chat_boost,
            ._bot = bot,
        };
    }
};
