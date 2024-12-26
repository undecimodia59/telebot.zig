pub const Bot = @import("core/bot.zig").Bot;
pub const types = @import("types/types.zig");
pub const Update = types.Update;
pub const ApiError = @import("core/error.zig").ApiError;
pub const HandlingType = @import("core/handler/handling_type.zig").HandlingType;
pub const Router = @import("core/handler/handlers.zig").Router;
pub const ParsedResult = @import("json/parser.zig").ParsedResult;

// TODO: Delete this
pub const cfg = @import("config.zig");
pub const TOKEN = cfg.TOKEN;
pub const TEST_RECEIVER = cfg.TEST_RECEIVER;
