const std = @import("std");

pub fn main() !void {
    // Slices

    // slice vs pointer to array
    // Pointer to array when bounds are comptime known
    var array = [_]u8{ 1, 2, 3, 4, 5 };
    array[0] = 1;
    const array_ptr = &array;
    std.debug.print("{}\n", .{@TypeOf(array_ptr)}); // *[5]u8
    // slice when bounds are runtime known, e.g when bounds are variables
    var start: u8 = 0;
    start = 0;
    var slice = array[start..]; // when slice is a const, we cant modify its internal ptr and len
    std.debug.print("{}\n", .{@TypeOf(slice)}); // []u8

    // A slice is a multi-item pointer and a length (usize)
    std.debug.print("slice.ptr: {any}\tslice.len: {}\n", .{ slice.ptr, slice.len });
    slice.ptr += 1;
    slice.len -= 1;
    std.debug.print("{any}\t{}\n", .{ slice, slice.len });

    // A sentinel terminated slice is very similar to a sentinel
    // terminated pointer
    array[3] = 0;
    var end: u8 = undefined;
    end = 3;
    // const t_slice = array[0..3 :0]; // t_slice will be of type *[3:0]u8 is this case
    // const t_slice: [:0]u8 = array[0..3 :0]; // [:0]u8, *[3:0]u8 coerce to [:0]u8
    const t_slice = array[start..end :0]; // [:0]u8
    std.debug.print("{}\t{any}\t{}\n", .{ @TypeOf(t_slice), t_slice, t_slice.len });

    // slice idiom
    const length: u8 = 3;
    const s_slice: []u8 = array[start..][0..length];
    std.debug.print("{}\t{any}\t{}\n", .{ @TypeOf(s_slice), s_slice, s_slice.len });
    // Slices have bounds checking
    // _ = s_slice[4]; // runtime panic
    std.debug.print("\n----------\n\n", .{});

    // for loop
    var array_f = [_]u8{ 0, 1, 2, 3, 4, 5 };

    // We can iterate over an array
    for (array_f) |item| std.debug.print("{} ", .{item});
    std.debug.print("\n", .{});

    // or a slice
    for (slice) |item| std.debug.print("{} ", .{item});
    std.debug.print("\n", .{});

    // Add a range to have an index
    for (slice, 100..) |item, i| std.debug.print("{}:{} ", .{ i, item });
    std.debug.print("\n", .{});

    // We can iterate over multiple objects
    // but they all must be of equal lengths
    for (slice[0..2], array_f[0..2], 0..) |a, b, c| {
        std.debug.print("{}-{}-{} ", .{ a, b, c });
    }
    std.debug.print("\n", .{});

    // Iterate over a range but it cannot be unbounded
    for (0..10) |item| std.debug.print("{} ", .{item});
    std.debug.print("\n", .{});

    // break and continue
    var sum: u8 = 0;
    for (array_f) |item| {
        if (item == 3) continue;
        if (item == 4) break;
        sum += item;
    }
    std.debug.print("sum: {}\n", .{sum});

    // Use a label to break or continue from a nested for loop
    outer: for (array_f) |oi| {
        for (slice) |ii| {
            if (oi == 3) continue;
            if (oi == 4) break :outer;
            std.debug.print("{}-{} ", .{ oi, ii });
        }
    }
    std.debug.print("\n", .{});

    // We can obtain a pointer to the item to modify it
    // The object must not be const and we must use a pointer to it
    // Remember a slice is also a pointer type
    for (&array_f) |*item| {
        item.* = 0;
    }

    for (slice) |*item| {
        item.* = 0;
    }
    std.debug.print("{any}\n", .{array_f});
    std.debug.print("{any}\n", .{slice});

    // A for loop can be an expression with an else clause
    // Here's a handy way to obtain a slice of just the first non-null
    // elements of an array of optionals
    const null_arr = [_]?u8{ 1, 2, 3, null, null };

    const nums_slice = for (null_arr, 0..) |item, i| {
        if (item == null) break null_arr[0..i];
    } else null_arr[0..];

    std.debug.print("{any}\ttype: {}\n", .{ nums_slice, @TypeOf(nums_slice) });

    // while loop
    // basic while
    var i: usize = 0;
    var sum_w: usize = 0;
    while (i <= 3) {
        sum_w += i;
        i += 1;
    }
    std.debug.print("sum_w: {}\n", .{sum_w});

    // complex continue expression
    i = 0;
    sum_w = 0;
    while (i <= 3) : (i += 1) {
        sum_w += i;
    }
    std.debug.print("sum_w: {}\n", .{sum_w});

    i = 0;
    var j: usize = 0;
    while (i < 5) : ({
        i += 1;
        j += 3;
    }) {
        std.debug.print("{}-{} ", .{ i, j });
    }
    std.debug.print("\n", .{});

    // break and continue, labels too
    i = 0;
    j = 0;
    outer: while (i < 4) : (i += 1) {
        while (j < 3) : (j += 1) {
            if (j == 2) continue;
            if (i == 3) break :outer;
            std.debug.print("{}-{} ", .{ i, j });
        }
    }
    std.debug.print("\n", .{});

    // while loop as an expression
    i = 0;
    const num: usize = while (i < 5) : (i += 1) {
        if (i == 3) break i + 1;
    } else 100;
    std.debug.print("num: {}\n", .{num});

    // while with optional capture
    count_down = 3;
    while (countDownIterator()) |n| {
        std.debug.print("count_down: {}\n", .{n});
    } else {
        std.debug.print("null\n", .{});
    }
}

var count_down: usize = undefined;

fn countDownIterator() ?usize {
    return if (count_down == 0) null else blk: {
        count_down -= 1;
        break :blk count_down;
    };
}
