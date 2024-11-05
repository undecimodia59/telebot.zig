const Location = @import("Location.zig").Location;

/// Struct representing a location to which a chat is connected
pub const ChatLocation = struct {
    /// The location to which the supergroup is connected. Can't be a live location.
    location: Location, // Assuming Location is defined elsewhere

    /// Location address; 1-64 characters, as defined by the chat owner
    address: []const u8,
};
