const std = @import("std");

const MessageOrigin = @import("MessageOrigin.zig").MessageOrigin;
const Chat = @import("Chat.zig").Chat;
const LinkPreviewOptions = @import("LinkPreviewOptions.zig").LinkPreviewOptions;
const Animation = @import("Animation.zig").Animation;
const Audio = @import("Audio.zig").Audio;
const Document = @import("Document.zig").Document;
const PaidMediaInfo = @import("PaidMediaInfo.zig").PaidMediaInfo;
const PhotoSize = @import("PhotoSize.zig").PhotoSize;
const Sticker = @import("Sticker.zig").Sticker;
const Story = @import("Story.zig").Story;
const Video = @import("Video.zig").Video;
const VideoNote = @import("VideoNote.zig").VideoNote;
const Voice = @import("Voice.zig").Voice;
const Contact = @import("Contact.zig").Contact;
const Dice = @import("Dice.zig").Dice;
const Game = @import("Game.zig").Game;
const Giveaway = @import("Giveaway.zig").Giveaway;
const GiveawayWinners = @import("GiveawayWinners.zig").GiveawayWinners;
const Invoice = @import("Invoice.zig").Invoice;
const Location = @import("Location.zig").Location;
const Poll = @import("Poll.zig").Poll;
const Venue = @import("Venue.zig").Venue;

pub const ExternalReplyInfo = struct {
    origin: MessageOrigin, // Origin of the message replied to by the given message

    chat: ?Chat = null, // Optional chat the original message belongs to, if supergroup or channel
    message_id: ?i32 = null, // Optional unique message identifier
    link_preview_options: ?LinkPreviewOptions = null, // Optional link preview options for text messages

    animation: ?Animation = null, // Optional animation
    audio: ?Audio = null, // Optional audio file information
    document: ?Document = null, // Optional document information
    paid_media: ?PaidMediaInfo = null, // Optional paid media information

    photo: ?[]PhotoSize = null, // Optional photo sizes array
    sticker: ?Sticker = null, // Optional sticker information
    story: ?Story = null, // Optional forwarded story
    video: ?Video = null, // Optional video information
    video_note: ?VideoNote = null, // Optional video note information
    voice: ?Voice = null, // Optional voice message information

    has_media_spoiler: ?bool = null, // Optional spoiler animation flag
    contact: ?Contact = null, // Optional contact information
    dice: ?Dice = null, // Optional dice with random value
    game: ?Game = null, // Optional game information
    giveaway: ?Giveaway = null, // Optional scheduled giveaway
    giveaway_winners: ?GiveawayWinners = null, // Optional giveaway with public winners
    invoice: ?Invoice = null, // Optional invoice information for payments
    location: ?Location = null, // Optional shared location
    poll: ?Poll = null, // Optional poll information
    venue: ?Venue = null, // Optional venue information
};
