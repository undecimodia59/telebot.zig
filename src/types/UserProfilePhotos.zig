const std = @import("std");
const PhotoSize = @import("PhotoSize.zig").PhotoSize;

pub const UserProfilePhotos = struct {
    /// Total number of profile pictures the target user has.
    total_count: u32,

    /// Requested profile pictures, with each entry containing up to 4 sizes.
    photos: [][]PhotoSize,
};
