pub const InputPaidMedia = union(enum) {
    Photo: InputPaidMediaPhoto,
    Video: InputPaidMediaVideo,
};

pub const InputPaidMediaPhoto = struct {
    // Type of the result, must be photo
    type: []const u8,
    // File to send. Pass a file_id to send a file that exists on the Telegram servers
    // or an HTTP URL, or an attach:// for multipart upload
    media: []const u8,
};

pub const InputPaidMediaVideo = struct {
    // Type of the result, must be video
    type: []const u8,
    // File to send. Pass a file_id to send a file that exists on the Telegram servers
    // or an HTTP URL, or an attach:// for multipart upload
    media: []const u8,
    // Optional. Thumbnail of the video sent; can be passed as InputFile or String
    thumbnail: ?[]const u8,
    // Optional. Video width
    width: ?i32,
    // Optional. Video height
    height: ?i32,
    // Optional. Video duration in seconds
    duration: ?i32,
    // Optional. Pass True if the uploaded video is suitable for streaming
    supports_streaming: ?bool,
};
