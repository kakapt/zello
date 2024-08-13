const std = @import("std");

pub fn main() !void {
    // Basic while
    var i: usize = 0;
    while (i < 3) {
        std.debug.print("{} ", .{i});
        i += 1;
    }
    std.debug.print("\n", .{});

    i = 0;
    while (i < 3) : (i += 1) std.debug.print("{} ", .{i});
    std.debug.print("\n", .{});

    // complex continue expression
    i = 0;
    var j: usize = 0;
    while (i < 3) : ({
        i += 1;
        j += 1;
    }) std.debug.print("{}-{} ", .{ i, j });
    std.debug.print("\n", .{});

    // break and continue, labels too
    i = 0;
    outer: while (true) : (i += 1) {
        while (i < 10) : (i += 1) {
            if (i == 4) continue :outer;
            if (i == 5) break :outer;
            std.debug.print("{} ", .{i});
        }
    }
    std.debug.print("\n", .{});

    // While loop as an expression
    const start: usize = 1;
    const end: usize = 20;
    i = start;
    const n: usize = 13;
    const in_range = while (i <= end) : (i += 1) {
        if (n == i) break true;
    } else false;
    std.debug.print("{} in {} to {}? {}\n", .{ n, start, end, in_range });

    // while with optional capture
    count_down = 3;
    while (countDownIterator()) |num| {
        std.debug.print("{} ", .{num});
    } else {
        // when cond = null
        std.debug.print("null ", .{});
    }
    std.debug.print("\n", .{});
}

var count_down: usize = undefined;

fn countDownIterator() ?usize {
    return if (count_down == 0) null else blk: {
        count_down -= 1;
        break :blk count_down;
    };
}
