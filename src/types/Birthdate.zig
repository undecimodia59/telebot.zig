/// Struct describing the birthdate of a user
pub const Birthdate = struct {
    /// Day of the user's birth; 1-31
    day: i32,

    /// Month of the user's birth; 1-12
    month: i32,

    /// Optional. Year of the user's birth
    year: ?i32,
};
