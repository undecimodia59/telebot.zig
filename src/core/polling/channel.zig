const std = @import("std");

// Define a generic Channel type
pub fn Channel(comptime T: type) type {
    return struct {
        allocator: std.mem.Allocator,
        buffer: []T,
        capacity: usize,
        read_index: usize,
        write_index: usize,
        count: usize,

        mutex: std.Thread.Mutex,
        not_empty: std.Thread.Condition,
        not_full: std.Thread.Condition,

        pub fn init(allocator: std.mem.Allocator, capacity: usize) Channel(T) {
            // Allocate buffer
            const buffer = allocator.alloc(T, capacity) catch unreachable;
            return Channel(T){
                .allocator = allocator,
                .buffer = buffer,
                .capacity = capacity,
                .read_index = 0,
                .write_index = 0,
                .count = 0,
                .mutex = std.Thread.Mutex{},
                .not_empty = std.Thread.Condition{},
                .not_full = std.Thread.Condition{},
            };
        }

        pub fn deinit(self: *Channel(T)) void {
            self.allocator.free(self.buffer);
        }

        // Send a value to the channel. Blocks if the channel is full.
        pub fn send(self: *Channel(T), value: T) void {
            self.mutex.lock();
            defer self.mutex.unlock();

            while (self.count == self.capacity) {
                self.not_full.wait(&self.mutex);
            }

            self.buffer[self.write_index] = value;
            self.write_index = (self.write_index + 1) % self.capacity;
            self.count += 1;

            self.not_empty.signal();
        }

        // Receive a value from the channel. Blocks if the channel is empty.
        pub fn receive(self: *Channel(T)) T {
            self.mutex.lock();
            defer self.mutex.unlock();

            while (self.count == 0) {
                // Problem is here
                // Signal sent, but wait not waiting
                self.not_empty.wait(&self.mutex);
            }

            const value = self.buffer[self.read_index];
            self.read_index = (self.read_index + 1) % self.capacity;
            self.count -= 1;

            self.not_full.signal();

            return value;
        }
    };
}

// Test1
const Update = struct { data: i32 };
fn consumer(channel: *Channel(Update), holder: *i32) void {
    const update = channel.receive();
    holder.* = update.data;
}
fn produser(data_to_be_sent: i32, channel: *Channel(Update)) void {
    channel.send(.{ .data = data_to_be_sent });
}
test "Channel" {
    const data_to_be_sent: i32 = 11;
    var holder: i32 = undefined;

    var channel = Channel(Update).init(std.testing.allocator, 10);
    defer channel.deinit();

    var thread = try std.Thread.spawn(.{}, consumer, .{ &channel, &holder });
    produser(data_to_be_sent, &channel);
    thread.join();
    std.debug.print("Expected: {d} | Got: {d}\n", .{ data_to_be_sent, holder });
    try std.testing.expectEqual(data_to_be_sent, holder);
}

//Test 2
const Worker = struct {
    receiver: Channel(*const Update),
    handler: ?std.Thread = null,
    pub fn init() Worker {
        return Worker{ .receiver = Channel(*const Update).init(std.testing.allocator, 5) };
    }
    pub fn deinit(self: *Worker) void {
        self.receiver.deinit();
    }
    pub fn start(self: *Worker) !void {
        self.handler = try std.Thread.spawn(.{}, Worker.pollUpdates, .{self});
    }
    fn pollUpdates(self: *Worker) !void {
        const update = self.receiver.receive();
        std.debug.print("Worker got update: {d}\n", .{update.data});
    }
};
// Some random source of update
fn getUpdate() ?Update {
    const random_data: i32 = @intCast(@rem(std.time.nanoTimestamp(), std.math.maxInt(i32)));
    if (@rem(random_data, 2) == 0) {
        return null;
    } else {
        return Update{ .data = random_data };
    }
}
test "Channel with worker" {
    var worker = Worker.init();
    defer worker.deinit();
    try worker.start();

    // Polling like
    while (true) {
        std.time.sleep(std.time.ns_per_s);
        const update = getUpdate();
        if (update) |u| {
            worker.receiver.send(&u);
            worker.handler.?.join();
            break;
        }
    }
}
