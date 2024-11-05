const std = @import("std");

const PhotoSize = @import("PhotoSize.zig").PhotoSize;
const Video = @import("Video.zig").Video;

const PaidMediaPreview = struct {
    type: []const u8,
    width: i32,
    height: i32,
    duration: i32,
};
const PaidMediaPhoto = struct {
    type: []const u8,
    photo: []PhotoSize,
};
const PaidMediaVideo = struct {
    type: []const u8,
    video: Video,
};

const PaidMedia = union(enum) {
    preview: PaidMediaPreview,
    photo: PaidMediaPhoto,
    video: PaidMediaVideo,
};
