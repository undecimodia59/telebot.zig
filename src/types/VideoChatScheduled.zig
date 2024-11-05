/// Struct representing a scheduled video chat
pub const VideoChatScheduled = struct {
    /// Point in time (Unix timestamp) when the video chat is supposed to be
    /// started by a chat administrator
    start_date: i32,
};
