const SharedUser = @import("SharedUser.zig").SharedUser;

/// Struct representing a collection of shared users
pub const UsersShared = struct {
    /// Identifier of the request
    request_id: i32,

    /// List of shared users
    users: []SharedUser,
};
