const std = @import("std");

// An error set is like an enum, but with special treatment
const InputError = error{
    EmptyInput,
};

// We can define as many as we need
const NumberError = error{
    InvalidCharacter,
    Overflow,
};

// And merge them together with the `||` operator.
const ParseError = InputError || NumberError;

// The return type of this function is an error union, using the `!` operator.
fn parseNumber(s: []const u8) ParseError!u8 {
    if (s.len == 0) return error.EmptyInput;
    return std.fmt.parseInt(u8, s, 10);
}

pub fn main() ParseError!void {
    const input = "212";
    var result = parseNumber(input);
    std.debug.print("type of result: {}\n", .{@TypeOf(result)});
    std.debug.print("result: {!}\n", .{result});
    std.debug.print("\n", .{});

    // We can use `catch` to provide a default on error (catch is a binary operator)
    result = parseNumber(input) catch 42;
    std.debug.print("result: {!}\n", .{result});
    std.debug.print("\n", .{});

    const result2: u8 = parseNumber("qa") catch 42;
    std.debug.print("result2: {!}\n", .{result2});
    std.debug.print("\n", .{});

    // We can use `catch` with `switch` to handle each type of error
    result = parseNumber(input) catch |err| switch (err) {
        error.EmptyInput => blk: {
            std.debug.print("Empty input is not allowed.\n", .{});
            break :blk 42;
        },
        else => err,
        // else => |e| return e,
    };
    std.debug.print("result: {!}\n", .{result});
    std.debug.print("\n", .{});

    // We can use `catch` with `unreachable` to ignore the error if it's never going to happen.
    result = parseNumber("123") catch unreachable;
    std.debug.print("result: {!}\n", .{result});
    std.debug.print("\n", .{});

    // We can use `catch` to propergate the error to the caller
    result = parseNumber(input) catch |err| return err;
    // There's a shortcut for this: `try`
    result = try parseNumber(input);
    std.debug.print("result: {!}\n", .{result});
    std.debug.print("\n", .{});

    // if can be used with error unions similar to optionals
    if (parseNumber(input)) |num| {
        std.debug.print("result: {}\n", .{num});
    } else |err| {
        std.debug.print("error: {}\n", .{err});
    }
    std.debug.print("\n", .{});

    // while loops can work with error unions similar to optionals
    count_down = 3;
    while (countDownIterator()) |num| {
        std.debug.print("{} \n", .{num});
    } else |err| {
        std.debug.print("error: {}\n", .{err});
    }
    std.debug.print("\n", .{});
}

var count_down: usize = undefined;

fn countDownIterator() !usize { // !usize <=> anyerror!usize
    return if (count_down == 0) error.ReachedZero else blk: {
        count_down -= 1;
        break :blk count_down;
    };
}
