/// Struct representing write access granted to a bot
pub const WriteAccessAllowed = struct {
    /// Optional. True if the access was granted after the user accepted an explicit request from a Web App sent by the method requestWriteAccess
    from_request: ?bool,

    /// Optional. Name of the Web App, if the access was granted when the Web App was launched from a link
    web_app_name: ?[]const u8,

    /// Optional. True if the access was granted when the bot was added to the attachment or side menu
    from_attachment_menu: ?bool,
};
