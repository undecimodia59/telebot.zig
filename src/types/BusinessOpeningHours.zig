const BusinessOpeningHoursInterval = @import("BusinessOpeningHoursInterval.zig").BusinessOpeningHoursInterval;

/// Struct describing the opening hours of a business
pub const BusinessOpeningHours = struct {
    /// Unique name of the time zone for which the opening hours are defined
    time_zone_name: []const u8,

    /// List of time intervals describing business opening hours
    opening_hours: []BusinessOpeningHoursInterval,
};
