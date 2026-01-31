const std = @import("std");
const Bot = @import("../bot.zig").Bot;
const Worker = @import("worker.zig").Worker;
const Update = @import("../../types/Update.zig").Update;
const Router = @import("../handler/handlers.zig").Router;
const GetUpdatesParams = @import("../parameters/get_updates.zig").GetUpdatesParameters;
const HandlingTypeFromUpdate = @import("../handler/handling_type.zig").HandlingTypeFromUpdate;

const types = @import("../../types/types.zig");

var processing_counter = std.atomic.Value(usize).init(0);
var processing_semaphore = std.Thread.Semaphore{};

pub const Poller = struct {
    owner: *Bot,
    worker: union(enum) {
        single: void,
        multi: struct {
            workers: []Worker,
            amount: usize,
        },
    },
    timeout: u64,
    router: Router,

    const Self = @This();
    const MaxWorkers = 32;
    const UpdatesLimit = 128;

    pub fn init(
        owner: *Bot,
        workers_amount: u8,
        timeout: u64,
        allocator: std.mem.Allocator,
        router: Router,
    ) !Self {
        switch (workers_amount) {
            0 => @panic("Workers amount can't be 0"),
            1 => return Self{
                .owner = owner,
                .worker = .{ .single = {} },
                .timeout = timeout,
                .router = router,
            },
            2...MaxWorkers => |valid_amount| {
                var workers = try allocator.alloc(Worker, valid_amount);
                for (workers[0..valid_amount], 0..) |*worker, i| {
                    worker.* = Worker.init(@intCast(i), allocator, UpdatesLimit, router, Poller.notify_processed);
                    try worker.start();
                }
                return Self{
                    .owner = owner,
                    .worker = .{ .multi = .{ .workers = workers, .amount = valid_amount } },
                    .timeout = timeout,
                    .router = router,
                };
            },
            else => @panic("Workers amount can't be bigger than 32"),
        }
    }

    pub fn deinit(self: *Self, allocator: std.mem.Allocator) void {
        switch (self.worker) {
            .multi => |m| {
                for (m.workers) |*worker| {
                    worker.deinit(allocator);
                }
                allocator.free(m.workers);
            },
            else => {},
        }
    }

    pub fn poll_loop(self: *Self, allocator: std.mem.Allocator, skip_updates: bool, user_options: GetUpdatesParams) !void {
        var options = user_options;
        options.limit = UpdatesLimit;

        var last_update_id: i64 = 0;
        if (skip_updates) {
            var updates = try self.owner.getUpdates(allocator, options);
            if (updates.data.len != 0) {
                last_update_id = updates.data[updates.data.len - 1].update_id;
            }
            updates.deinit(allocator);
        }

        while (true) {
            std.Thread.sleep(std.time.ns_per_ms * self.timeout);
            options.offset = last_update_id + 1;
            var updates = self.owner.getUpdates(allocator, options) catch |e| {
                std.log.err("Failed to get new updates: {any}", .{e});
                return;
            };
            defer updates.deinit(allocator);

            switch (self.worker) {
                .single => {
                    try self.single_worker(allocator, &updates);
                },
                .multi => {
                    try self.multi_worker(allocator, &updates);
                },
            }

            if (updates.data.len != 0) last_update_id = updates.data[updates.data.len - 1].update_id;
        }
    }

    fn single_worker(self: *Self, allocator: std.mem.Allocator, updates: *types.Updates) !void {
        for (updates.data) |update| {
            // Find type of update
            const hType = HandlingTypeFromUpdate(update);
            if (self.router.get(hType)) |f| {
                f(allocator, update) catch |e| {
                    std.log.err("Error on user defined handler: {any}", .{e});
                };
            }
        }
    }

    fn multi_worker(self: *Self, allocator: std.mem.Allocator, updates: *types.Updates) !void {
        // Increment the processing counter by the number of updates
        const num_updates = updates.data.len;
        _ = processing_counter.fetchAdd(num_updates, .monotonic);

        // Distribute updates to workers
        for (updates.data) |update| {
            // Select a worker (e.g., round-robin)
            const worker_index = processing_counter.load(.monotonic) % self.worker.multi.amount;
            var worker = &self.worker.multi.workers[worker_index];

            std.log.debug("Sending update to worker №{d} ({*})", .{ worker.id, &worker });
            // Send the update to the worker's channel
            worker.getChannel().send(.{ .allocator = allocator, .update = &update });
        }

        // After sending all updates, wait for all to be processed
        while (processing_counter.load(.monotonic) > 0) {
            processing_semaphore.wait();
        }
    }

    // Function to be called by workers after processing an update
    pub fn notify_processed() void {
        const remaining = processing_counter.fetchSub(1, .monotonic) - 1;
        if (remaining == 0) {
            processing_semaphore.post();
        }
    }
};
