const std = @import("std");
const PaidMedia = @import("PaidMedia.zig").PaidMedia;

/// Represents information about paid media, including the required payment in stars.
pub const PaidMediaInfo = struct {
    /// The number of Telegram stars that must be paid to buy access to the media
    star_count: i32,

    /// Information about the paid media
    paid_media: []PaidMedia, // A slice of PaidMedia structs
};
