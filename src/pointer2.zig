const std = @import("std");

pub fn main() !void {
    // Single item pointer
    // to a constant
    const a: u8 = 1;
    const a_ptr = &a;
    // a_ptr.* += 1; // invalid op
    std.debug.print("{}\t{}\t\ttype: {}\n", .{ a_ptr, a_ptr.*, @TypeOf(a_ptr) });

    // to a variable
    var b: u8 = 2;
    const b_ptr = &b;
    b_ptr.* *%= 2; // valid
    std.debug.print("{}\t{}\t\ttype: {}\n", .{ b_ptr, b_ptr.*, @TypeOf(b_ptr) });

    // const pointer vs var pointer
    // const ptr
    const d_ptr = &a;
    // d_ptr = b_ptr; // invalid
    std.debug.print("{}\t{}\t\ttype: {}\n", .{ d_ptr, d_ptr.*, @TypeOf(d_ptr) });

    // var ptr
    var e_ptr = &a;
    e_ptr = b_ptr;
    std.debug.print("{}\t{}\t\ttype: {}\n", .{ d_ptr, d_ptr.*, @TypeOf(d_ptr) });

    // We can't do pointer arithmetic on single-item pointer type in Zig
    std.debug.print("\n-------\n\n", .{});

    // Multi-item pointer
    var arr = [_]u8{ 1, 2, 3, 4 };
    std.debug.print("arr.len: {}\ttype: {}\n", .{ arr.len, @TypeOf(arr) });
    // arr[0] = 5; // cannot assign to constant array
    var f_ptr: [*]u8 = &arr;
    f_ptr += 1;
    // f_ptr.* is not valid, only f_ptr[0] is
    std.debug.print("f_ptr[0]: {}\ttype: {}\n", .{ f_ptr[0], @TypeOf(f_ptr) });
    f_ptr -= 1;
    std.debug.print("f_ptr[0]: {}\ttype: {}\n", .{ f_ptr[0], @TypeOf(f_ptr) });

    std.debug.print("\n-------\n\n", .{});

    // Pointer to array
    var arr2 = [_]u8{ 5, 6, 7, 8, 10 };
    const g_ptr = &arr2;
    // g_ptr += 1; // invalid op
    g_ptr[1] += 4;
    std.debug.print("g_ptr[0]: {}\ttype: {}\n", .{ g_ptr[0], @TypeOf(g_ptr) });
    std.debug.print("arr2[0]: {}\tarr2.len: {}\n", .{ g_ptr[0], g_ptr.len });

    std.debug.print("\n-------\n\n", .{});

    // Sentinel terminated pointer
    const s_arr = [2:5]u8{ 1, 2 };
    std.debug.print("s_arr: {any}\ttype: {}\n", .{ s_arr, @TypeOf(s_arr) });
    std.debug.print("s_arr.len: {}\ts_arr[s_arr.len]: {}\n", .{ s_arr.len, s_arr[s_arr.len] });

    const arr_3 = [_]u8{ 3, 4, 5, 0, 9 };
    const h_ptr: [*:0]const u8 = arr_3[0..3 :0];
    std.debug.print("h_ptr[0]: {}\ttype: {}\n", .{ h_ptr[0], @TypeOf(h_ptr) });
    // std.debug.print("h_ptr.len: {}\n", .{h_ptr.len}); // invalid op

    std.debug.print("\n-------\n\n", .{});

    // Convert pointer address to integer and other way around
    const address = @intFromPtr(h_ptr);
    std.debug.print("address: {}\ttype: {}\n", .{ address, @TypeOf(address) });
    std.debug.print("size of address: {}\n", .{@sizeOf(@TypeOf(address))});

    const j_ptr: [*:0]const u8 = @ptrFromInt(address);
    std.debug.print("j_ptr[0]: {}\ttype: {}\n", .{ j_ptr[0], @TypeOf(j_ptr) });

    // std.debug.print("address1: {}\taddress2: {}\n", .{ address, @intFromPtr(&arr_3) });
    // std.debug.print("g_ptr integer value: {}\n", .{@intFromPtr(g_ptr)});
    // std.debug.print("a_ptr integer value: {}\n", .{@intFromPtr(a_ptr)});

    std.debug.print("\n-------\n\n", .{});

    // Optional pointer
    var op_ptr: ?*const usize = null;
    std.debug.print("op_ptr: {?}\ttype: {}\n", .{ op_ptr, @TypeOf(op_ptr) });
    op_ptr = &address;
    std.debug.print("op_ptr: {?}\ttype: {}\n", .{ op_ptr, @TypeOf(op_ptr) });

    var op_ptr2: ?[*]u8 = null;
    std.debug.print("op_ptr2: {any}\ttype: {}\n", .{ op_ptr2, @TypeOf(op_ptr2) });
    op_ptr2 = f_ptr;
    std.debug.print("op_ptr2: {any}\ttype: {}\n", .{ op_ptr2, @TypeOf(op_ptr2) });
}
