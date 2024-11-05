const Document = @import("Document.zig").Document;

pub const ChatBackground = struct { type: BackgroundType };

pub const BackgroundType = union(enum) {
    BackgroundTypeFill: BackgroundTypeFill,
    BackgroundTypePattern: BackgroundTypePattern,
    BackgroundTypeWallpaper: BackgroundTypeWallpaper,
    BackgroundTypeChatTheme: BackgroundTypeChatTheme,
};

// Types:
pub const BackgroundTypePattern = struct {
    type: []const u8 = "pattern",
    document: Document,
    fill: BackgroundFill,
    intensity: i32,
    is_inverted: ?bool,
    is_moving: ?bool,
};

pub const BackgroundTypeWallpaper = struct {
    type: []const u8 = "wallpaper",
    document: Document,
    dark_theme_dimming: i32,
    is_blurred: ?bool,
    is_moving: ?bool,
};

pub const BackgroundTypeChatTheme = struct {
    type: []const u8 = "chat_theme",
    theme_name: []const u8,
};

pub const BackgroundTypeFill = struct {
    type: []const u8 = "fill",
    fill: BackgroundFill,
    dark_theme_dimming: i32,
};
// End of types

// Fill types:
pub const BackgroundFill = union(enum) {
    BackgroundFillSolid: BackgroundFillSolid,
    BackgroundFillGradient: BackgroundFillGradient,
    BackgroundFillFreeformGradient: BackgroundFillFreeformGradient,
};

pub const BackgroundFillSolid = struct {
    type: []const u8 = "solid",
    color: i32,
};

pub const BackgroundFillGradient = struct {
    type: []const u8 = "gradient",
    top_color: i32,
    bottom_color: i32,
    rotation_angle: i32,
};

pub const BackgroundFillFreeformGradient = struct {
    type: []const u8 = "freeform_gradient",
    colors: []i32,
};
// End of fill types
