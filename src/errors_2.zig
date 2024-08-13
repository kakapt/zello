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
// const ParseError = InputError || NumberError;
const ParseError = InputError || NumberError;

// The return type of this function is an error union, using the `!` operator.
fn parseNumber(s: []const u8) ParseError!u8 {
    return if (s.len == 0) error.EmptyInput else blk: {
        break :blk std.fmt.parseInt(u8, s, 10);
    };
}

pub fn main() ParseError!void {
    const input = "212";
    var result = parseNumber(input);
    std.debug.print("type of result: {}\n", .{@TypeOf(result)});
    std.debug.print("result: {!}\n", .{result});
    std.debug.print("\n", .{});

    // We can use `catch` to provide a default on error (catch is a binary operator)
    result = parseNumber("abd") catch 42;
    std.debug.print("result: {!}\n", .{result});
    std.debug.print("\n", .{});

    // We can use `catch` with `switch` to handle each type of error
    result = parseNumber("100000000000") catch |err| switch (err) {
        error.EmptyInput => 0,
        else => err,
    };
    std.debug.print("result: {!}\n", .{result});
    std.debug.print("\n", .{});

    // We can use `catch` with `unreachable` to ignore the error if it's never going to happen.
    result = parseNumber("123") catch unreachable;
    // result = parseNumber("aca") catch unreachable; // will panic
    std.debug.print("result: {!}\n", .{result});
    std.debug.print("\n", .{});

    // We can use `catch` to propergate the error to the caller
    result = parseNumber("123") catch |err| return err;
    // result = parseNumber("as") catch |err| return err; // will return the error to main
    std.debug.print("result: {!}\n", .{result});
    std.debug.print("\n", .{});

    // There's a shortcut for this: `try`
    result = try parseNumber("123");
    // result = try parseNumber("asd"); // will return error to main

    // if can be used with error unions similar to optionals
    if (parseNumber("aa")) |num| {
        std.debug.print("num: {}\n", .{num});
    } else |err| {
        std.debug.print("error: {}\n", .{err});
    }

    // if as an expression doesnt work with braces
    // result = if (parseNumber("aa")) |num| {
    //     return num;
    // } else |err| {
    //     return err;
    // };

    // while loops can work with error unions similar to optionals
    count_down = 3;
    while (countDownIterator()) |num| {
        std.debug.print("{} ", .{num});
    } else |err| {
        std.debug.print("\nerror: {}\n", .{err});
    }
    std.debug.print("\n", .{});
}

var count_down: usize = undefined;

fn countDownIterator() anyerror!usize {
    return if (count_down == 0) error.ReachedZero else blk: {
        count_down -= 1;
        break :blk count_down;
    };
}
