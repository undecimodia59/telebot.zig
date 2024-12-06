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

    pub fn makeRequest(self: *HTTP, url: []const u8) ![]u8 {
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

    pub fn makePostRequest(self: *HTTP, url: []const u8, body: []const u8) ![]u8 {
        var response_storage = ArrayList(u8).init(self.allocator);
        defer response_storage.deinit();

        _ = try self.client.fetch(.{ .response_storage = .{ .dynamic = &response_storage }, .payload = body, .method = .POST, .location = .{ .url = url }, .headers = .{ .content_type = .{ .override = "application/json" } } });

        std.debug.print("resp_store: {s}\n\n", .{response_storage.items});

        return response_storage.toOwnedSlice();
    }
};
