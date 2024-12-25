const types = @import("types.zig");
const Update = types.Update;
const UpdateRaw = types.UpdateRaw;
const json = @import("../json/parser.zig");

pub const Updates = struct {
    data: []Update,
    ptr: json.ParsedResult([]UpdateRaw),
    pub fn deinit(self: *@This()) void {
        self.ptr.deinit();
    }
};
