const std = @import("std");
const Location = @import("Location.zig").Location;

/// Struct representing a venue.
pub const Venue = struct {
    // Venue location
    location: Location,

    // Venue name
    name: []const u8,

    // Venue address
    address: []const u8,

    // Optional. Foursquare identifier of the venue
    foursquare_id: ?[]const u8,

    // Optional. Foursquare type of the venue. (For example, “arts_entertainment/default”,
    // “arts_entertainment/aquarium” or “food/icecream”.)
    foursquare_type: ?[]const u8,

    // Optional. Google Places identifier of the venue
    google_place_id: ?[]const u8,

    // Optional. Google Places type of the venue
    google_place_type: ?[]const u8,
};
