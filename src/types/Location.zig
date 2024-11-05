const std = @import("std");

/// Struct representing a geographical location.
pub const Location = struct {
    /// Longitude as defined by the sender.
    longitude: f64,

    /// Latitude as defined by the sender.
    latitude: f64,

    /// Optional. The radius of uncertainty for the location, measured in meters; 0-1500.
    horizontal_accuracy: ?f64,

    /// Optional. Time relative to the message sending date, during which the location can be updated; in seconds. For active live locations only.
    live_period: ?i32,

    /// Optional. The direction in which the user is moving, in degrees; 1-360. For active live locations only.
    heading: ?i32,

    /// Optional. The maximum distance for proximity alerts about approaching another chat member, in meters. For sent live locations only.
    proximity_alert_radius: ?i32,
};
