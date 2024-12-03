const std = @import("std");
const ArrayList = std.ArrayList;

pub const HTTP = struct {
    pub fn make_request(allocator: std.mem.Allocator, url: []const u8) ![]u8 {
        const uri = try std.Uri.parse(url);

        var client = std.http.Client{.allocator = allocator};
        defer client.deinit();

        const server_header_buffer: []u8 = try allocator.alloc(u8, 1024*8);
        defer allocator.free(server_header_buffer);

        var request = try client.open(.GET, uri, .{
            .server_header_buffer = server_header_buffer
        });
        defer request.deinit();

        try request.send();
        try request.finish();
        try request.wait();

        std.log.debug("Request to {s} ({d})", .{url, request.response.status});

        var response = ArrayList(u8).init(allocator);
        _ = try request.reader().readAllArrayList(&response, 1024*8);
        const body = try response.toOwnedSlice();
        return body;
    }
};