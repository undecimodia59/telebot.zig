const std = @import("std");
const PhotoSize = @import("PhotoSize.zig").PhotoSize;
const File = @import("File.zig").File;
const MaskPosition = @import("MaskPosition.zig").MaskPosition;

/// Struct representing a sticker with its attributes.
pub const Sticker = struct {
    /// Unique identifier for this file, which can be used to download or reuse the file.
    file_id: []const u8,

    /// Unique identifier for this file, which is supposed to be the same over time
    /// and for different bots. Can't be used to download or reuse the file.
    file_unique_id: []const u8,

    /// Type of the sticker, currently one of "regular", "mask", "custom_emoji".
    type: []const u8,

    /// Sticker width.
    width: i32,

    /// Sticker height.
    height: i32,

    /// True, if the sticker is animated.
    is_animated: bool,

    /// True, if the sticker is a video sticker.
    is_video: bool,

    /// Optional. Sticker thumbnail in the .WEBP or .JPG format.
    thumbnail: ?PhotoSize,

    /// Optional. Emoji associated with the sticker.
    emoji: ?[]const u8,

    /// Optional. Name of the sticker set to which the sticker belongs.
    set_name: ?[]const u8,

    /// Optional. For premium regular stickers, premium animation for the sticker.
    premium_animation: ?File,

    /// Optional. For mask stickers, the position where the mask should be placed.
    mask_position: ?MaskPosition,

    /// Optional. For custom emoji stickers, unique identifier of the custom emoji.
    custom_emoji_id: ?[]const u8,

    /// Optional. True, if the sticker must be repainted to a text color in messages.
    needs_repainting: ?bool,

    /// Optional. File size in bytes.
    file_size: ?i64,
};
