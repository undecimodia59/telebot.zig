const std = @import("std");
const Update = @import("../../types/Update.zig").Update;
const HandlingType = @import("handling_type.zig").HandlingType;

pub const EnumValue = i32;
pub const RouterFnType = *const fn (std.mem.Allocator, Update) anyerror!void;
pub const TypesAmount = @typeInfo(HandlingType).@"enum".fields.len;
