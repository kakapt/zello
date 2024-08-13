const std = @import("std");

// A simple function
fn add(a: u8, b: u8) u8 {
    return a +| b;
}

// A function that doesn't return a value
fn printU8(n: u8) void {
    std.debug.print("{}", .{n});
}

// A function that never returns.
fn oops() noreturn {
    @panic("Oops!");
}

// If a function is never called, it isn't even evaluated
fn never() void {
    @compileError("Never happens...");
}

// A `pub` function can be imported from another namespace
pub fn sub(a: u8, b: u8) u8 {
    return a -| b;
}

// An `extern` function is linked in from an external object file
extern "c" fn atan2(a: f64, b: f64) f64;

// An `export` function is made available for use in the generated object file
export fn mul(a: u8, b: u8) u8 {
    return a *| b;
}

// We can force inlining of a function, but usually not necessary
inline fn answer() u8 {
    return 42;
}

// Zig determines whether to pass parameters by value for by reference
// Parameters are always constants
fn addOneNot(n: u8) void {
    n += 1;
}

// If we want to modify a parameter inside the function, make it a pointer
fn addOne(n: *u8) void {
    n.* += 1;
}

pub fn main() !void {
    var n: u8 = 0;
    n = 0;

    addOneNot(n);
    std.debug.print("n: {}\n", .{n});
}
