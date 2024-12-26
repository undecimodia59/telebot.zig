const Update = @import("../../types/Update.zig").Update;
const ApiError = @import("../error.zig").ApiError;
const HandlingType = @import("handling_type.zig").HandlingType;

pub const EnumValue = i32;
pub const RouterFnType = *const fn (Update) ApiError!void;
pub const TypesAmount = @typeInfo(HandlingType).Enum.fields.len;
