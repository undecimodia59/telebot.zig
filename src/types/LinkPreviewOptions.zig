const std = @import("std");

/// Describes the options used for link preview generation.
pub const LinkPreviewOptions = struct {
    /// Optional. True if the link preview is disabled
    is_disabled: bool = false,

    /// Optional. URL to use for the link preview. If empty, the first URL
    /// found in the message text will be used
    url: ?[]const u8 = null,

    /// Optional. True if the media in the link preview should be shrunk.
    /// Ignored if the URL isn't explicitly specified or media resizing isn't
    /// supported for the preview
    prefer_small_media: bool = false,

    /// Optional. True if the media in the link preview should be enlarged.
    /// Ignored if the URL isn't explicitly specified or media resizing isn't
    /// supported for the preview
    prefer_large_media: bool = false,

    /// Optional. True if the link preview should be shown above the message text;
    /// otherwise, the link preview will be shown below the message text
    show_above_text: bool = false,
};
