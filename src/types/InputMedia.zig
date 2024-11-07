const MessageEntity = @import("MessageEntity.zig").MessageEntity;

pub const InputMedia = union(enum) {
    Photo: InputMediaPhoto,
    Video: InputMediaVideo,
    Animation: InputMediaAnimation,
    Audio: InputMediaAudio,
    Document: InputMediaDocument,
};

pub const InputMediaPhoto = struct {
    // Type of the result, must be photo
    type: []const u8,
    // File to send. Pass a file_id to send a file that exists on the Telegram servers
    media: []const u8,
    // Optional. Caption of the photo to be sent, 0-1024 characters after entities parsing
    caption: ?[]const u8,
    // Optional. Mode for parsing entities in the photo caption
    parse_mode: ?[]const u8,
    // Optional. List of special entities that appear in the caption
    caption_entities: ?[]MessageEntity,
    // Optional. Pass True, if the caption must be shown above the message media
    show_caption_above_media: ?bool,
    // Optional. Pass True if the photo needs to be covered with a spoiler animation
    has_spoiler: ?bool,
};

pub const InputMediaVideo = struct {
    // Type of the result, must be video
    type: []const u8,
    // File to send. Pass a file_id to send a file that exists on the Telegram servers
    media: []const u8,
    // Optional. Thumbnail of the file sent
    thumbnail: ?[]const u8,
    // Optional. Caption of the video to be sent
    caption: ?[]const u8,
    // Optional. Mode for parsing entities in the video caption
    parse_mode: ?[]const u8,
    // Optional. List of special entities that appear in the caption
    caption_entities: ?[]MessageEntity,
    // Optional. Pass True, if the caption must be shown above the message media
    show_caption_above_media: ?bool,
    // Optional. Video width
    width: ?i32,
    // Optional. Video height
    height: ?i32,
    // Optional. Video duration in seconds
    duration: ?i32,
    // Optional. Pass True if the uploaded video is suitable for streaming
    supports_streaming: ?bool,
    // Optional. Pass True if the video needs to be covered with a spoiler animation
    has_spoiler: ?bool,
};

pub const InputMediaAnimation = struct {
    // Type of the result, must be animation
    type: []const u8,
    // File to send. Pass a file_id to send a file that exists on the Telegram servers
    media: []const u8,
    // Optional. Thumbnail of the file sent
    thumbnail: ?[]const u8,
    // Optional. Caption of the animation to be sent
    caption: ?[]const u8,
    // Optional. Mode for parsing entities in the animation caption
    parse_mode: ?[]const u8,
    // Optional. List of special entities that appear in the caption
    caption_entities: ?[]MessageEntity,
    // Optional. Pass True, if the caption must be shown above the message media
    show_caption_above_media: ?bool,
    // Optional. Animation width
    width: ?i32,
    // Optional. Animation height
    height: ?i32,
    // Optional. Animation duration in seconds
    duration: ?i32,
    // Optional. Pass True if the animation needs to be covered with a spoiler animation
    has_spoiler: ?bool,
};

pub const InputMediaAudio = struct {
    // Type of the result, must be audio
    type: []const u8,
    // File to send. Pass a file_id to send a file that exists on the Telegram servers
    media: []const u8,
    // Optional. Thumbnail of the file sent
    thumbnail: ?[]const u8,
    // Optional. Caption of the audio to be sent
    caption: ?[]const u8,
    // Optional. Mode for parsing entities in the audio caption
    parse_mode: ?[]const u8,
    // Optional. List of special entities that appear in the caption
    caption_entities: ?[]MessageEntity,
    // Optional. Duration of the audio in seconds
    duration: ?i32,
    // Optional. Performer of the audio
    performer: ?[]const u8,
    // Optional. Title of the audio
    title: ?[]const u8,
};

pub const InputMediaDocument = struct {
    // Type of the result, must be document
    type: []const u8,
    // File to send. Pass a file_id to send a file that exists on the Telegram servers
    media: []const u8,
    // Optional. Thumbnail of the file sent
    thumbnail: ?[]const u8,
    // Optional. Caption of the document to be sent
    caption: ?[]const u8,
    // Optional. Mode for parsing entities in the document caption
    parse_mode: ?[]const u8,
    // Optional. List of special entities that appear in the caption
    caption_entities: ?[]MessageEntity,
    // Optional. Disables automatic server-side content type detection for files
    disable_content_type_detection: ?bool,
};
