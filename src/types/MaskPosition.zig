const std = @import("std");

/// Struct representing the position of a mask on a face.
pub const MaskPosition = struct {
    /// The part of the face relative to which the mask should be placed.
    point: []const u8,

    /// Shift by X-axis measured in widths of the mask scaled to the face size,
    /// from left to right. For example, choosing -1.0 will place mask just to the
    /// left of the default mask position.
    x_shift: f64,

    /// Shift by Y-axis measured in heights of the mask scaled to the face size,
    /// from top to bottom. For example, 1.0 will place the mask just below the
    /// default mask position.
    y_shift: f64,

    /// Mask scaling coefficient. For example, 2.0 means double size.
    scale: f64,
};
