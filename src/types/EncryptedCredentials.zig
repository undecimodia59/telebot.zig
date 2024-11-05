/// Struct representing encrypted credentials for Telegram Passport
pub const EncryptedCredentials = struct {
    /// Base64-encoded encrypted JSON-serialized data with unique user's payload,
    /// data hashes and secrets required for EncryptedPassportElement decryption
    /// and authentication
    data: []const u8,

    /// Base64-encoded data hash for data authentication
    hash: []const u8,

    /// Base64-encoded secret, encrypted with the bot's public RSA key, required
    /// for data decryption
    secret: []const u8,
};
