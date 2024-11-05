const std = @import("std");

pub const KeyboardButtonRequestUsers = struct {
    /// Signed 32-bit identifier of the request that will be received back in the `UsersShared` object. Must be unique within the message.
    request_id: i32,

    /// Optional. Set to `true` to request bots, `false` to request regular users. If not specified, no additional restrictions are applied.
    user_is_bot: ?bool = null,

    /// Optional. Set to `true` to request premium users, `false` to request non-premium users. If not specified, no additional restrictions are applied.
    user_is_premium: ?bool = null,

    /// Optional. The maximum number of users to be selected; valid range is 1-10. Defaults to 1.
    max_quantity: ?u8 = null,

    /// Optional. Set to `true` to request the users' first and last names.
    request_name: ?bool = null,

    /// Optional. Set to `true` to request the users' usernames.
    request_username: ?bool = null,

    /// Optional. Set to `true` to request the users' photos.
    request_photo: ?bool = null,
};
