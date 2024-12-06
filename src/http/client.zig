const std = @import("std");
const ArrayList = std.ArrayList;

pub const HTTP = struct {
    allocator: std.mem.Allocator,
    client: std.http.Client,

    pub fn init(allocator: std.mem.Allocator) HTTP {
        const client = std.http.Client{ .allocator = allocator };
        return HTTP{
            .allocator = allocator,
            .client = client,
        };
    }

    pub fn deinit(self: *HTTP) void {
        self.client.deinit();
    }

    pub fn make_request(self: *HTTP, url: []const u8) ![]u8 {
        const uri = try std.Uri.parse(url);

        const server_header_buffer: []u8 = try self.allocator.alloc(u8, 1024 * 8);
        defer self.allocator.free(server_header_buffer);

        var request = try self.client.open(.GET, uri, .{
            .server_header_buffer = server_header_buffer,
        });
        defer request.deinit();

        try request.send();
        try request.finish();
        try request.wait();

        std.log.debug("Request to {s} ({d})", .{ url, request.response.status });

        var response = ArrayList(u8).init(self.allocator);
        defer response.deinit();

        _ = try request.reader().readAllArrayList(&response, 1024 * 8);
        return try response.toOwnedSlice();
    }
};
