const std = @import("std");

// Enum
const Color = enum(u2) {
    red,
    green,
    blue,

    //method
    pub fn isRed(self: Color) bool {
        return self == Color.red;
    }

    //namespaced global variables
    var darkness: u8 = 0;
};

// Union
const Number = union {
    int: i32,
    float: f64,

    pub fn get(self: Number) void {
        std.debug.print("from get: {}\n", .{self.int});
    }
};

// Tagged union
const Count = union(enum) {
    people: i32,
    money: f64,

    pub fn is(self: Count, tag: std.meta.Tag(Count)) bool {
        return self == tag;
    }
};

pub fn main() !void {
    std.debug.print("Enum:\n", .{});
    const red: Color = .red; // Color.red - is a member of Color enum type
    std.debug.print("{}\t{s}\tis red: {}\n", .{ @intFromEnum(red), @tagName(red), red.isRed() });

    const blue: Color = .blue;
    std.debug.print("{}\t{s}\tis red: {}\n", .{ @intFromEnum(blue), @tagName(blue), blue.isRed() });
    Color.darkness += 1; // Namespaced global
    std.debug.print("darkness: {}\n", .{Color.darkness});

    switch (red) {
        .red => std.debug.print("It's red\n", .{}),
        .blue => std.debug.print("The sky is blue!\n", .{}),
        .green => std.debug.print("Green is my favorite color\n", .{}),
    }

    std.debug.print("-------------------------\n", .{});
    std.debug.print("Union:\n", .{});

    var num: Number = .{ .int = 32 };
    num.int += 1;
    std.debug.print("{}\n", .{num.int});
    num.get();
    num = .{ .float = 3.1415 };
    std.debug.print("{}\n", .{num.float});

    // Cannot switch on bare union
    // switch (num) {
    //     .int => std.debug.print("It's int\n", .{}),
    //     .float => std.debug.print("It's float\n", .{}),
    // }

    std.debug.print("-------------------------\n", .{});
    std.debug.print("Tagged union:\n", .{});
    var count: Count = .{ .people = 10 };
    count.people += 1;
    std.debug.print("{}\t{s}\n", .{ count.people, @tagName(count) });
    count = .{ .money = 12.23 };
    std.debug.print("{}\t{s}\n", .{ count.money, @tagName(count) });

    switch (count) {
        .people => |p| std.debug.print("{} people\n", .{p}),
        .money => |m| std.debug.print("${}\n", .{m}),
    }

    std.debug.print("{}\n", .{count.is(Count.people)});
    std.debug.print("{}\n", .{count.is(.people)});

    // payload capture is a constant
    // switch (count) {
    //     .people => |p| p += 1,
    //     .money => |m| m *= 2,
    // }

    // pointer payload capture
    switch (count) {
        .people => |*p| p.* += 1,
        .money => |*m| m.* *= 2,
    }

    switch (count) {
        .people => |p| std.debug.print("{} people\n", .{p}),
        .money => |m| std.debug.print("${}\n", .{m}),
    }
}
