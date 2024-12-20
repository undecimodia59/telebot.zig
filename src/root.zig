pub const Bot = @import("core/bot.zig").Bot;
pub const types = @import("types/types.zig");
pub const Update = types.Update;
pub const ApiError = @import("core/error.zig").ApiError;
const handlers = @import("core/handlers.zig");
pub const HandlerType = handlers.HandlingType;
pub const Router = handlers.Router;

// TODO: Delete this
pub const cfg = @import("config.zig");
pub const TOKEN = cfg.TOKEN;
pub const TEST_RECEIVER = cfg.TEST_RECEIVER;
