const std = @import("std");

pub const ApiError = error{
    Unauthorized,
    UserNotFound,
    ChatNotFound,
    BadRequest,
    UserIsDeactivated,
    BotWasKicked,
    BotBlockedByUser,
    BotCantSendMessagesToBots,
    Forbidden,
    TooManyRequests,
    Conflict,
    // TODO: Complete all error from docs https://github.com/TelegramBotAPI/errors?tab=readme-ov-file
    UnexpectedError,
    /// If failed to get reply chat
    UpdateReplyError,

    // Not related to telegram
    OutOfMemory,
    UnexpectedCharacter,
    InvalidFormat,
    InvalidPort,
    ConnectionRefused,
    NetworkUnreachable,
    ConnectionTimedOut,
    ConnectionResetByPeer,
    TemporaryNameServerFailure,
    NameServerFailure,
    UnknownHostName,
    HostLacksNetworkAddresses,
    UnexpectedConnectFailure,
    TlsInitializationFailed,
    UnsupportedUriScheme,
    UnexpectedWriteFailure,
    InvalidContentLength,
    UnsupportedTransferEncoding,
    Overflow,
    InvalidCharacter,
    UriMissingHost,
    CertificateBundleLoadFailure,
    TlsFailure,
    TlsAlert,
    UnexpectedReadFailure,
    EndOfStream,
    HttpChunkInvalid,
    NotWriteable,
    MessageTooLong,
    MessageNotCompleted,
    HttpHeadersOversize,
    HttpHeadersInvalid,
    HttpHeaderContinuationsUnsupported,
    HttpTransferEncodingUnsupported,
    HttpConnectionHeaderUnsupported,
    CompressionUnsupported,
    TooManyHttpRedirects,
    RedirectRequiresResend,
    HttpRedirectLocationMissing,
    HttpRedirectLocationInvalid,
    CompressionInitializationFailed,
    DecompressionFailure,
    InvalidTrailers,
    StreamTooLong,
    UnexpectedToken,
    InvalidNumber,
    InvalidEnumTag,
    DuplicateField,
    UnknownField,
    MissingField,
    LengthMismatch,
    SyntaxError,
    UnexpectedEndOfInput,
    BufferUnderrun,
    ValueTooLong,
};

pub fn fromErrorCode(error_code: i32, desc: []u8) ApiError {
    return switch (error_code) {
        401 => ApiError.Unauthorized,
        400 => {
            if (std.mem.indexOf(u8, desc, "User not found") != null) {
                return ApiError.UserNotFound;
            } else if (std.mem.indexOf(u8, desc, "Chat not found") != null) {
                return ApiError.ChatNotFound;
            } else {
                return ApiError.BadRequest;
            }
        },
        403 => {
            if (std.mem.indexOf(u8, desc, "user is deactivated") != null) {
                return ApiError.UserIsDeactivated;
            } else if (std.mem.indexOf(u8, desc, "bot was kicked from the group chat") != null) {
                return ApiError.BotWasKicked;
            } else if (std.mem.indexOf(u8, desc, "bot was blocked by the user") != null) {
                return ApiError.BotBlockedByUser;
            } else if (std.mem.indexOf(u8, desc, "bot can't send messages to bots") != null) {
                return ApiError.BotCantSendMessagesToBots;
            } else {
                return ApiError.Forbidden;
            }
        },
        429 => ApiError.TooManyRequests,
        409 => ApiError.Conflict,
        -1 => ApiError.UpdateReplyError,
        else => ApiError.UnexpectedError,
    };
}
