const User = @import("User.zig").User;

// Struct representing a triggered proximity alert
pub const ProximityAlertTriggered = struct {
    traveler: User, // User that triggered the alert
    watcher: User, // User that set the alert
    distance: i32, // The distance between the users
};
