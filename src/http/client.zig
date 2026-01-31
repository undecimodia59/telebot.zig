const std = @import("std");
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
        var response_writer = std.Io.Writer.Allocating.init(self.allocator);
        errdefer response_writer.deinit();
        const status = try self.client.fetch(.{
            .location = .{ .url = url },
            .response_writer = &response_writer.writer,
        });

        std.log.debug("Request to {s} ({d})", .{ url, status.status });

        return try response_writer.toOwnedSlice();
    }

    pub fn makePostRequest(self: *HTTP, url: []const u8, body: []const u8) ![]u8 {
        var response_writer = std.Io.Writer.Allocating.init(self.allocator);
        errdefer response_writer.deinit();

        const status = try self.client.fetch(.{
            .response_writer = &response_writer.writer,
            .payload = body,
            .method = .POST,
            .location = .{ .url = url },
            .headers = .{ .content_type = .{ .override = "application/json" } },
        });

        std.log.debug("Request to {s} ({d})", .{ url, status.status });

        return response_writer.toOwnedSlice();
    }
};
