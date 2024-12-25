const std = @import("std");

// Define a generic Channel type
pub fn Channel(comptime T: type) type {
    return struct {
        allocator: *std.mem.Allocator,
        buffer: []T,
        capacity: usize,
        read_index: usize,
        write_index: usize,
        count: usize,

        mutex: std.Thread.Mutex,
        not_empty: std.Thread.Condition,
        not_full: std.Thread.Condition,

        pub fn init(allocator: *std.mem.Allocator, capacity: usize) Channel(T) {
            // Allocate buffer
            const buffer = allocator.alloc(T, capacity) catch unreachable;
            return Channel(T){
                .allocator = allocator,
                .buffer = buffer,
                .capacity = capacity,
                .read_index = 0,
                .write_index = 0,
                .count = 0,
                .mutex = std.Thread.Mutex.init(),
                .not_empty = std.Thread.Condition{},
                .not_full = std.Thread.Condition{},
            };
        }

        pub fn deinit(self: *Channel(T)) void {
            self.mutex.deinit();
            self.not_empty.deinit();
            self.not_full.deinit();
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
