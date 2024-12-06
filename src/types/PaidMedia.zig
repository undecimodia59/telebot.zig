const std = @import("std");

const PhotoSize = @import("PhotoSize.zig").PhotoSize;
const Video = @import("Video.zig").Video;

pub const PaidMedia = union(enum) {
    PaidMediaPreview: struct {
        type: []const u8,
        width: i32,
        height: i32,
        duration: i32,
    },
    PaidMediaPhoto: struct {
        type: []const u8,
        photo: []PhotoSize,
    },
    PaidMediaVideo: struct {
        type: []const u8,
        video: Video,
    },
};
