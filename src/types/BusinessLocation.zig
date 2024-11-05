const Location = @import("Location.zig").Location;

/// Struct containing information about the location of a Telegram Business account
pub const BusinessLocation = struct {
    /// Address of the business
    address: []const u8,

    /// Optional. Location of the business
    location: ?Location, // Assuming Location is defined elsewhere
};
