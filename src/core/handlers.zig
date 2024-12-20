const Update = @import("../types/Update.zig").Update;
const ApiError = @import("error.zig").ApiError;

const EnumValue = i32;

/// This type used for bot.registerHandler()
pub const HandlingType = enum(EnumValue) {
    ANY,
    EditedMessage,
    ChannelPost,
    EditedChannelPost,
    BusinessConnection,
    BusinessMessage,
    EditedBusinessMessage,
    DeletedBusinessMessages,
    MessageReaction,
    MessageReactionCount,
    InlineQuery,
    ChoosenInlineResult,
    CallbackQuery,
    ShippingQuery,
    PreCheckoutQuery,
    PurchasedPaidMedia,
    Poll,
    PollAnswer,
    MyChatMember,
    ChatMember,
    ChatJoinRequest,
    ChatBoost,
    RemovedChatBoost,
    MessageText,
    MessagePhoto,
    MessageCommand,
};

pub const RouterFnType = *const fn (Update) ApiError!void;

const TypesAmount = @typeInfo(HandlingType).Enum.fields.len;

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
                if (h.hType == @intFromEnum(needle)) {
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
