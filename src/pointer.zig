const std = @import("std");

pub fn main() !void {
    // Single item pointer to a constant
    const a: u8 = 0;
    const a_ptr = &a;
    // a_ptr.* += 1;
    std.debug.print("a_ptr: {}, type of a_ptr: {}\n", .{ a_ptr.*, @TypeOf(a_ptr) });

    var b: u8 = 0;
    const b_ptr = &b;
    b_ptr.* += 1;
    std.debug.print("b_ptr: {}, type of b_ptr: {}\n", .{ b_ptr.*, @TypeOf(b_ptr) });

    // both are const and can't be modified themselves
    // a_ptr = &b;
    // b_ptr = &a;

    // use a var if we need to swap the pointer itself
    var c_ptr = a_ptr;
    c_ptr = b_ptr; // OK -> coerce from *u8 to *const u8
    // var c_ptr = b_ptr;
    // c_ptr = a_ptr; // Error -> coerce from *const u8 to *u8 -> less restrictive conversion
    std.debug.print("c_ptr: {}, type of c_ptr: {}\n", .{ c_ptr.*, @TypeOf(c_ptr) });

    std.debug.print("\n", .{});

    // Multi-item pointer
    var array = [_]u8{ 1, 2, 3, 4, 5, 6 };
    var d_ptr: [*]u8 = &array;
    std.debug.print("d_ptr[0]: {}, type of d_ptr: {}\n", .{ d_ptr[0], @TypeOf(d_ptr) });
    d_ptr[1] += 1; // index op
    d_ptr += 1; // Pointer arithmetic
    std.debug.print("d_ptr[0]: {}, type of d_ptr: {}\n", .{ d_ptr[0], @TypeOf(d_ptr) });
    d_ptr -= 1; // Pointer arithmetic
    std.debug.print("d_ptr[0]: {}, type of d_ptr: {}\n", .{ d_ptr[0], @TypeOf(d_ptr) });

    std.debug.print("\n", .{});

    // Pointer to array
    const e_ptr = &array;
    std.debug.print("e_ptr[0]: {}, type of e_ptr: {}\n", .{ e_ptr[0], @TypeOf(e_ptr) });
    e_ptr[1] += 1;
    std.debug.print("e_ptr[1]: {}, type of e_ptr: {}\n", .{ e_ptr[1], @TypeOf(e_ptr) });
    std.debug.print("array[1]: {}\n", .{array[1]});
    std.debug.print("e_ptr.len: {}\n", .{e_ptr.len});

    std.debug.print("\n", .{});

    // Sentinel terminated pointer
    array[3] = 0;
    const f_ptr: [*:0]const u8 = array[0..3 :0]; // :0 tells the compiler this is a sentinel terminated pointer
    std.debug.print("f_ptr[1]: {}, type of f_ptr: {}\n", .{ f_ptr[1], @TypeOf(f_ptr) });

    std.debug.print("\n", .{});

    // If we ever need the address as an integer
    const address = @intFromPtr(f_ptr);
    std.debug.print("address: {}, type of address: {}\n", .{ address, @TypeOf(address) });
    // and the other way around
    const g_ptr: [*:0]const u8 = @ptrFromInt(address);
    std.debug.print("g_ptr[1]: {}, type of g_ptr: {}\n", .{ g_ptr[1], @TypeOf(g_ptr) });

    std.debug.print("\n", .{});

    // If we need a pointer that can be null like in C, use an optional pointer
    var h_ptr: ?*const usize = null;
    std.debug.print("h_ptr: {?}, type of h_ptr: {}\n", .{ h_ptr, @TypeOf(h_ptr) });
    h_ptr = &address;
    std.debug.print("h_ptr.?.*: {}, type of h_ptr: {}\n", .{ h_ptr.?.*, @TypeOf(h_ptr) });
    // The size of an optional pointer is the same as a normal pointer
    std.debug.print("h_ptr size: {}, *usize size: {}\n", .{ @sizeOf(@TypeOf(h_ptr)), @sizeOf(*usize) });

    // There's also [*c] but that's only for transitioning from C code.
}
