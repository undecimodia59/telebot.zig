const std = @import("std");
const Bot = @import("../bot.zig").Bot;
const Worker = @import("worker.zig").Worker;
const Update = @import("../../types/Update.zig").Update;
const Router = @import("../handler/handlers.zig").Router;

pub const Poller = struct {
    owner: *Bot,
    workers: []Worker,
    workers_error: []bool,
    timeout: u64,
    stop_on_error: bool,
    allocator: std.mem.Allocator,

    const Self = @This();
    const MaxWorkers = 32;
    const UpdatesLimit = 128;

    pub fn init(
        owner: *Bot,
        workers_amount: u8,
        timeout: u64,
        stop_on_error: bool,
        allocator: std.mem.Allocator,
        router: Router,
    ) Self {
        if (workers_amount == 0) {
            @panic("Workers amount can't be 0");
        } else if (workers_amount > MaxWorkers) {
            @panic("Workers amount can't be bigger than 32");
        } else {
            var worker_array: [MaxWorkers]Worker = undefined;
            for (worker_array[0..workers_amount], 0..) |*worker, i| {
                worker.* = Worker.init(@as(u8, i), allocator, UpdatesLimit, router);
            }
            return Self{
                .owner = owner,
                .workers = worker_array[0..workers_amount],
                .workers_error = []bool{false} ** workers_amount,
                .timeout = timeout,
                .stop_on_error = stop_on_error,
                .distribute_counter = 0,
                .allocator = allocator,
            };
        }
    }

    pub fn poll_loop() !void {}
};
