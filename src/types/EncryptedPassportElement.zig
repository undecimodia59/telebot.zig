const PassportFile = @import("PassportFile.zig").PassportFile;

/// Struct representing an encrypted element in Telegram Passport
pub const EncryptedPassportElement = struct {
    /// Element type. One of “personal_details”, “passport”, “driver_license”,
    /// “identity_card”, “internal_passport”, “address”, “utility_bill”,
    /// “bank_statement”, “rental_agreement”, “passport_registration”,
    /// “temporary_registration”, “phone_number”, “email”.
    type: []const u8,

    /// Optional. Base64-encoded encrypted Telegram Passport element data provided
    /// by the user; available only for specific types. Can be decrypted and verified
    /// using the accompanying EncryptedCredentials.
    data: ?[]const u8,

    /// Optional. User's verified phone number; available only for “phone_number” type
    phone_number: ?[]const u8,

    /// Optional. User's verified email address; available only for “email” type
    email: ?[]const u8,

    /// Optional. Array of encrypted files with documents provided by the user;
    /// available only for specific types. Files can be decrypted and verified
    /// using the accompanying EncryptedCredentials.
    files: ?[]PassportFile,

    /// Optional. Encrypted file with the front side of the document, provided by
    /// the user; available only for specific types. The file can be decrypted
    /// and verified using the accompanying EncryptedCredentials.
    front_side: ?PassportFile,

    /// Optional. Encrypted file with the reverse side of the document, provided by
    /// the user; available only for specific types. The file can be decrypted
    /// and verified using the accompanying EncryptedCredentials.
    reverse_side: ?PassportFile,

    /// Optional. Encrypted file with the selfie of the user holding a document,
    /// provided by the user; available if requested for specific types. The file
    /// can be decrypted and verified using the accompanying EncryptedCredentials.
    selfie: ?PassportFile,

    /// Optional. Array of encrypted files with translated versions of documents
    /// provided by the user; available if requested for specific types. Files can
    /// be decrypted and verified using the accompanying EncryptedCredentials.
    translation: ?[]PassportFile,

    /// Optional. Base64-encoded element hash for using in PassportElementErrorUnspecified
    hash: ?[]const u8,
};
