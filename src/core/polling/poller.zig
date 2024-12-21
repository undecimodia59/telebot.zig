const std = @import("std");
const Bot = @import("../bot.zig").Bot;
const Worker = @import("worker.zig").Worker;
const Update = @import("../../types/Update.zig").Update;

pub const Poller = struct {
    owner: *Bot,
    workers: union(enum) {
        multi_workers: []Worker,
        single_worker: Worker,
    },
    timeout: u64,
    stop_on_error: bool,
    distribute_counter: usize = 0,
    allocator: std.mem.Allocator,

    const Self = @This();
    const MaxWorkers = 32;

    pub fn init(owner: *Bot, workers_amount: u8, timeout: u64, stop_on_error: bool, allocator: std.mem.Allocator) Self {
        if (workers_amount == 0) {
            @panic("Workers amount can't be 0");
        } else if (workers_amount > MaxWorkers) {
            @panic("Workers amount can't be bigger than 32");
        } else if (workers_amount == 1) {
            // Implement single thread
            var single_worker = Worker.init(0, owner, stop_on_error);
            _ = single_worker.start() catch @panic("Failed to start single worker");
            return Self{
                .owner = owner,
                .workers = .{ .single_worker = single_worker },
                .timeout = timeout,
                .stop_on_error = stop_on_error,
                .distribute_counter = 0,
                .allocator = allocator,
            };
        } else {
            // Implement multithread
            var worker_array: [MaxWorkers]Worker = undefined;
            for (worker_array[0..workers_amount], 0..) |*worker, i| {
                worker.* = Worker.init(@as(u8, i), owner, stop_on_error);
                _ = worker.start() catch @panic("Failed to start worker");
            }
            return Self{
                .owner = owner,
                .workers = .{ .multi_workers = worker_array[0..workers_amount] },
                .timeout = timeout,
                .stop_on_error = stop_on_error,
                .distribute_counter = 0,
                .allocator = allocator,
            };
        }
    }

    pub fn poll_loop(self: *Self) !void {
        while (true) {
            const json_obj = self.owner.getUpdates(self.timeout) catch |err| {
                std.debug.print("Error fetching updates: {}\n", .{err});
                continue;
            };
            defer json_obj.deinit();
            const updates = json_obj.data;

            for (updates) |update| {
                // Allocate the update on the heap to pass a pointer to workers
                const update_ptr = try self.allocator.create(Update);
                update_ptr.* = update;

                // Distribute the update to workers
                self.distribute_update(update_ptr) catch |err| {
                    std.debug.print("Error distributing update: {}\n", .{err});
                    // Depending on your error handling strategy, you might want to free the update_ptr
                    self.allocator.destroy(update_ptr);
                };
            }
        }
    }

    fn distribute_update(self: *Self, update_ptr: *Update) !void {
        switch (self.workers) {
            .single_worker => |worker| {
                _ = worker.send_update(update_ptr) catch |err| {
                    if (self.stop_on_error) {
                        std.debug.print("Failed to send update to single worker: {}\n", .{err});
                        // Implement logic to stop the poll loop, e.g., by returning an error
                        return err;
                    } else {
                        std.debug.print("Failed to send update to single worker: {}\n", .{err});
                    }
                };
            },
            .multi_workers => |workers| {
                const worker = &workers[self.distribute_counter % workers.len];
                _ = worker.send_update(update_ptr) catch |err| {
                    if (self.stop_on_error) {
                        std.debug.print("Failed to send update to worker {}: {}\n", .{ worker.id, err });
                        return err;
                    } else {
                        std.debug.print("Failed to send update to worker {}: {}\n", .{ worker.id, err });
                    }
                };
                self.distribute_counter += 1;
            },
        }
    }

    pub fn shutdown(self: *Self) void {
        switch (self.workers) {
            .single_worker => |worker| {
                worker.receiver.close();
                worker.join();
            },
            .multi_workers => |workers| {
                for (workers) |worker| {
                    worker.receiver.close();
                    worker.join();
                }
            },
        }
    }
};
