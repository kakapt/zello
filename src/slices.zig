const std = @import("std");

pub fn main() !void {
    // If our slice with comptime known bounds, the result
    // is not a slice but rather a pointer to an array
    var array = [_]u8{ 0, 1, 2, 3, 4, 5 };
    const array_ptr = array[0..array.len]; // <-- slice operation
    std.debug.print("array_ptr type: {}\n", .{@TypeOf(array_ptr)});

    std.debug.print("\n", .{});

    // So we need this runtime zero to force getting
    // a slice vs a pointer to an array
    var zero: usize = 0;
    zero = 0;

    // We get a slice by using slicing syntax
    const a_slice: []u8 = &array;
    // const a_slice: []u8 = array[zero..]; or array[zero..array.len]
    a_slice[0] += 1;
    std.debug.print("a_slice[0]: {}, a_slice.len: {}\n", .{ a_slice[0], a_slice.len });
    std.debug.print("\n", .{});

    // A slice is a multi-item pointer and a length (usize)
    std.debug.print("type of a_slice.ptr: {}\n", .{@TypeOf(a_slice.ptr)});
    std.debug.print("type of a_slice.len: {}\n", .{@TypeOf(a_slice.len)});

    std.debug.print("\n", .{});

    // Which means we can directly manipulate it if needed
    var b_slice = array[zero..];
    b_slice.ptr += 2; // pointer arithmetic on multi-line pointer
    // Now it's up to us to update the length or suffer naster consequences later on
    b_slice.len -= 2;
    std.debug.print("b_slice: {any}\n", .{b_slice});
    std.debug.print("\n", .{});

    // No problem in slicing a slice. Note we force a const slice
    // by explicitly specifying the result type

    const c_slice: []const u8 = a_slice[0..3];
    std.debug.print("c_slice: {any}\n", .{c_slice});

    // Slices have bounds checking
    // b_slice[10] = 9;

    std.debug.print("\n", .{});

    // We can slice a pointer to an array
    const d_slice = array_ptr[zero..2];
    std.debug.print("d_slice: {any}\n", .{d_slice});
    std.debug.print("\n", .{});

    // A sentinel terminated slice is very similar to a sentinel
    // terminated pointer
    array[4] = 0;
    const e_slice: [:0]u8 = array[0..4 :0];
    std.debug.print("e_slice[e_slice.len]: {}\n", .{e_slice[e_slice.len]});
    std.debug.print("\n", .{});

    // A useful idiom is slicing b length
    var start: usize = 2;
    var length: usize = 4;
    start = 2;
    length = 4;
    const f_slice = array[start..][0..length];
    std.debug.print("f_slice: {any}\n", .{f_slice});
}
