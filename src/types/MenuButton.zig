const WebAppInfo = @import("WebAppInfo.zig").WebAppInfo;

pub const MenuButton = union(enum) {
    MenuButtonCommands: struct {
        // Type of the button, must be "commands"
        type: []const u8,
    },
    MenuButtonWebApp: struct {
        // Type of the button, must be "web_app"
        type: []const u8,
        // Text on the button
        text: []const u8,
        // Web App details
        web_app: WebAppInfo,
    },
    MenuButtonDefault: struct {
        // Type of the button, must be "default"
        type: []const u8,
    },
};
