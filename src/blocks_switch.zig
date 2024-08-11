const std = @import("std");

pub fn main() !void {
    // A block can defined a new scope.
    {
        const x: u8 = 42;
        std.debug.print("x: {}\n", .{x});
    }

    // x is no longer in scope out here
    // std.debug.print("x: {}\n", .{x});

    // Blocks are expressions and can return a value
    // using a label with `break`
    const x: u8 = blk: {
        const y: u8 = 12;
        const z = 90;
        break :blk y + z;
    };
    std.debug.print("x: {}\n", .{x});

    // `switch` controls execution flow based on a value
    switch (x) {
        // Range inclusive on both ends
        0...20 => std.debug.print("It's 0 to 33.\n", .{}),

        // You can combine several values to test with commas
        // This is like the fallthrough behaviour in other languages
        30, 31, 32 => std.debug.print("It's 40, 41, or 42", .{}),

        // You can capture the matched value
        40...60 => |n| std.debug.print("It's {}.\n", .{n}),

        returnSomething() => |r| std.debug.print("It's {}.\n", .{r}),

        // Use a block for more complex prongs
        77 => {
            const a = 1;
            const b = 2;
            std.debug.print("a + b = {}\n", .{a + b});
        },

        // As long as it's comptime known, any expression can be prong
        blk: {
            const a = 100;
            const b = 2;
            break :blk a + b;
        } => |v| std.debug.print("It's {}.\n", .{v}),

        // `else` is the default if no other prong matches
        // Mandortory if non-exhaustive switch

        else => std.debug.print("None of the above!\n", .{}),
    }

    // Like `if`, `switch` can be an expression
    const answer: u8 = switch (x) {
        0...10 => 1,
        42 => 2,
        blk: {
            const a = 100;
            const b = 2;
            break :blk a + b;
        } => |v| v +| 255,
        else => 3,
    };

    std.debug.print("answer: {}\n", .{answer});
}

fn returnSomething() u8 {
    return 88;
}
