const User = @import("User.zig").User;

pub const VideoChatParticipantsInvited = struct {
    users: []User,
};
