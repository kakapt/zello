const std = @import("std");

// Constant and variable names are snake_case

// Global constant
const global_const: u8 = 42;

// Global variable
var global_variable: u8 = 0;

// Function names are camelCase
fn printInfo(name: []const u8, x: anytype) void {
    std.debug.print("{s:>10} {any:^10}\t{}\n", .{ name, x, @TypeOf(x) });
}

pub fn main() void {
    std.debug.print("{s:>10} {s:^10}\t{s}\n", .{ "name", "value", "type" });
    std.debug.print("{s:>10} {s:^10}\t{s}\n", .{ "----", "----", "----" });

    const a_const = 1;
    printInfo("a_const", a_const);

    var a_var: u8 = 2;
    a_var += 1;
    printInfo("a_var", a_var);

    var b_var: u8 = 3;
    b_var += 1;
    printInfo("b_var", b_var);

    var d_var: u8 = undefined;
    printInfo("d_var", d_var);
    d_var = 3;
    printInfo("d_var", d_var);

    var e_var: u8 = 0;
    e_var += 1;

    //Intergers
    //Unsigned u8, u16, ..., u128, usize(address size, 64 bits on x_86x64), u{0-65535}
    //Signed i8, i16, ..., i128, isize(address size, 64 bits on x_86x64), i{0-65535}

    _ = 1_000_000; //decimal
    _ = 0x10ff_ffff; //hex
    _ = 0o777; //octal
    _ = 0b1111_0101_0111; //binary

    var f_var: u1 = 0;
    f_var = 1;
    // f_var = 2;

    const g_const: u21 = '@';
    _ = g_const;

    //comptime_int is the type of integer literals.
    const h_const = 42;
    printInfo("h_const", h_const);

    // Floating Point
    // f16, f32, f64, f128
    // Literal can be decimal or hex
    _ = 123.0E+77; // With exponent
    _ = 123.0; // without exponent
    _ = 123.0e+77; //E or e for exponent

    _ = 0x103.70; // hex floating point
    _ = 0x103.70p-5; // P or p for hex exponent

    //Optional underscores for readability
    _ = 299_792;
    _ = 0.000_000;
    _ = 0x1234_5678.9ABCp-10;

    //Infinity and NaN
    _ = std.math.inf(f64); // Positive infinity
    _ = -std.math.inf(f64); // Negative infinity
    _ = -std.math.nan(f64); // Not a Number

    // comptime float is the type of float literals
    const i_const = 3.1415;
    printInfo("i_const", i_const);
}
