const std = @import("std");

pub fn main() !void {
    // A bool can only be true or fasle;
    const t: bool = true;
    const f: bool = false;
    std.debug.print("t: {} f: {}\n", .{ t, f });

    // Convert a bool to an integer (0 or 1 only)
    std.debug.print("t: {} f: {}\n", .{ @intFromBool(t), @intFromBool(f) });

    //Only optionals can be null
    var maybe_byte: ?u8 = null;
    std.debug.print("maybe_byte: {?}\n", .{maybe_byte});
    maybe_byte = 42;
    std.debug.print("maybe_byte: {?}\n", .{maybe_byte});

    // Use the `.?` to assert the optional is not null and extract its payload
    var the_byte = maybe_byte.?;

    // orelse will extract the payload or default to the provided value if null.
    the_byte = maybe_byte orelse 13;

    // You can control execution flow with if, bool, and optionals.
    if (t) {
        std.debug.print("It's {}!\n", .{t});
    } else if (f) {
        std.debug.print("What?\n", .{f});
    } else {
        std.debug.print("None of the abobe are true.\n", .{});
    }

    // You can capture the payload of an optional if it's not null.
    if (maybe_byte) |b| {
        // In here, b is a u8, not an optional.
        std.debug.print("b is {}\n", .{b});
    } else {
        std.debug.print("It's null.\n", .{});
    }

    if (maybe_byte) |_| {
        std.debug.print("It's not null.\n", .{});
    }

    // Only optionals can be compared to null.
    if (maybe_byte == null) {
        std.debug.print("It's null.\n", .{});
    }

    // You can write a simple `if` as a one liner.
    if (t) std.debug.print("It's {}!\n", .{t});

    // You can also use an `if`   as a one liner.
    // Zig's version of the ternary operator ?:
    the_byte = if (maybe_byte) |b| b else 0;
    // `orelse` is a convenient shortcut for the above line/
    the_byte = maybe_byte orelse 0;

    // When using `if` as an expression, the braces are not allowed.
    the_byte = if (maybe_byte != null and maybe_byte.? == 42)
        42 * 2
    else
        0;
    std.debug.print("the_byte: {}\n", .{the_byte});
}
