const Document = @import("Document.zig").Document;

// Represents a chat background with a specific type
pub const ChatBackground = struct {
    type: BackgroundType,
};

// Union for different background types
pub const BackgroundType = union(enum) {
    BackgroundTypeFill: BackgroundTypeFill,
    BackgroundTypePattern: BackgroundTypePattern,
    BackgroundTypeWallpaper: BackgroundTypeWallpaper,
    BackgroundTypeChatTheme: BackgroundTypeChatTheme,
};

// Struct for a patterned background type
pub const BackgroundTypePattern = struct {
    type: []const u8 = "pattern",
    document: Document,
    fill: BackgroundFill,
    intensity: i32,
    is_inverted: ?bool,
    is_moving: ?bool,
};

// Struct for a wallpaper background type
pub const BackgroundTypeWallpaper = struct {
    type: []const u8 = "wallpaper",
    document: Document,
    dark_theme_dimming: i32,
    is_blurred: ?bool,
    is_moving: ?bool,
};

// Struct for a chat theme background type
pub const BackgroundTypeChatTheme = struct {
    type: []const u8 = "chat_theme",
    theme_name: []const u8,
};

// Struct for a filled background type
pub const BackgroundTypeFill = struct {
    type: []const u8 = "fill",
    fill: BackgroundFill,
    dark_theme_dimming: i32,
};

// Union for different fill types
pub const BackgroundFill = union(enum) {
    BackgroundFillSolid: BackgroundFillSolid,
    BackgroundFillGradient: BackgroundFillGradient,
    BackgroundFillFreeformGradient: BackgroundFillFreeformGradient,
};

// Struct for a solid fill type
pub const BackgroundFillSolid = struct {
    type: []const u8 = "solid",
    color: i32,
};

// Struct for a gradient fill type
pub const BackgroundFillGradient = struct {
    type: []const u8 = "gradient",
    top_color: i32,
    bottom_color: i32,
    rotation_angle: i32,
};

// Struct for a freeform gradient fill type
pub const BackgroundFillFreeformGradient = struct {
    type: []const u8 = "freeform_gradient",
    colors: []i32,
};
