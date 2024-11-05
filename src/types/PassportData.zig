const EncryptedPassportElement = @import("EncryptedPassportElement.zig").EncryptedPassportElement;
const EncryptedCredentials = @import("EncryptedCredentials.zig").EncryptedCredentials;

/// Struct representing Telegram Passport data
pub const PassportData = struct {
    /// Array with information about documents and other Telegram Passport elements that was shared with the bot
    data: []EncryptedPassportElement,

    /// Encrypted credentials required to decrypt the data
    credentials: EncryptedCredentials,
};
