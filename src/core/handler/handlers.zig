const Update = @import("../../types/Update.zig").Update;
const ApiError = @import("../error.zig").ApiError;
const HandlingType = @import("handling_type.zig").HandlingType;

const handling_values = @import("handling_values.zig");
const TypesAmount = handling_values.TypesAmount;
const RouterFnType = handling_values.RouterFnType;
const EnumValue = handling_values.EnumValue;

pub const Router = struct {
    handlers: [TypesAmount]?RouterPair = [_]?RouterPair{null} ** TypesAmount,
    last_idx: usize = 0,

    const Self = @This();

    pub inline fn init() Self {
        return Self{};
    }

    pub inline fn add(
        comptime self: *Self,
        comptime handlingType: HandlingType,
        comptime routerFn: RouterFnType,
    ) void {
        // Check for duplicate handler types
        inline for (self.handlers) |pair| {
            if (pair) |h| {
                if (@as(HandlingType, @enumFromInt(h.hType)) == handlingType) {
                    @compileError("Duplicate of handler types!");
                }
                if (h.hType == 0 and self.handlers.len > 1) {
                    @compileError("HandlingType.ANY should be single handler");
                }
            } else {
                // Got null
                break;
            }
        }
        self.handlers[self.last_idx] = RouterPair.init(@intFromEnum(handlingType), routerFn);
        self.last_idx += 1;
    }

    pub fn get(self: Self, needle: HandlingType) ?RouterFnType {
        for (self.handlers) |pair| {
            if (pair) |h| {
                if (h.hType == @intFromEnum(needle) or h.hType == @intFromEnum(HandlingType.ANY)) {
                    return h.hFn;
                }
            }
        }
        return null;
    }
};

const RouterPair = struct {
    hType: EnumValue,
    hFn: RouterFnType,

    pub inline fn init(comptime hType: EnumValue, comptime hFn: RouterFnType) RouterPair {
        return RouterPair{ .hType = hType, .hFn = hFn };
    }
};
