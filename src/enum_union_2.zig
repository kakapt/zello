const std = @import("std");

// a set of values of the same type
const Direction = enum(u8) {
    north = 100,
    south,
    east,
    west,

    pub fn isNorth(self: Direction) bool {
        return self == .north;
    }
};

const Mode = enum {
    var count: u32 = 0;
};

const Result = union {
    int: i64,
    float: f64,
    bool: bool,
};

const Tagged = union(enum) {
    a: u8,
    b: f32,
    c: bool,
    none, // none: void
};

pub fn main() !void {
    var value = Tagged{ .b = 1.5 };
    switch (value) {
        .a => |*byte| byte.* += 1,
        .b => |*float| float.* += 2,
        .c => |*b| b.* = !b.*,
        .none => {},
    }

    std.debug.print("{}\n", .{value.b});
    std.debug.print("{}\n", .{value.b});
}
