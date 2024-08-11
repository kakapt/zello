const std = @import("std");

// Auto-assigned integers starting at 0
// Uses smallest possible unsigned integer type.
const Color = enum(u8) {
    red,
    green,
    blue,
    // _,

    fn isRed(self: Color) bool {
        return self == .red;
    }
};

// Size of the largest field; 8 bytes in this case
const Number = union {
    int: u8,
    float: f64,
};

// Tagged Union
const Token = union(enum) {
    keyword_if,
    keyword_switch,
    digit: usize,

    fn is(self: Token, tag: std.meta.Tag(Token)) bool {
        return self == tag;
    }
};

pub fn main() !void {
    // You can omit the enum name is a literal when the type can be inferred.
    var fav_color: Color = .red;
    std.debug.print("fav_color: {s}, is red? {}\n", .{ @tagName(fav_color), fav_color.isRed() });
    fav_color = .blue;
    std.debug.print("fav_color: {s}, is red? {}\n", .{ @tagName(fav_color), fav_color.isRed() });

    // Get the integer value of an enum field.
    std.debug.print("fav_color as int: {}\n", .{@intFromEnum(fav_color)});

    // and the other way around
    fav_color = @enumFromInt(1);
    std.debug.print("1 as Color: {s}\n", .{@tagName(fav_color)});

    // Enums work perfectly with switches
    switch (fav_color) {
        .red => std.debug.print("It's red.\n", .{}),
        .green => std.debug.print("It's green.\n", .{}),
        .blue => std.debug.print("It's blue.\n", .{}),
    }

    // Unions can only be one of the fields at a time.
    var fav_num: Number = .{ .int = 13 };
    std.debug.print("fav_num: {}\n", .{fav_num.int});

    // To change the field you re-assign the whole union
    fav_num = .{ .float = 3.1415 };
    std.debug.print("fav_num: {d:.4}\n", .{fav_num.float});

    // Tagged unions get the best of both worlds
    var tok: Token = .keyword_if;
    std.debug.print("is if? {}\n", .{tok.is(.keyword_if)});

    // And combined with switch and payload capture, they're really useful
    switch (tok) {
        .keyword_if => std.debug.print("if\n", .{}),
        .keyword_switch => std.debug.print("switch\n", .{}),
        .digit => |d| std.debug.print("digit {}\n", .{d}),
    }

    tok = .{ .digit = 42 };

    switch (tok) {
        .keyword_if => std.debug.print("if\n", .{}),
        .keyword_switch => std.debug.print("switch\n", .{}),
        .digit => |d| std.debug.print("digit {}\n", .{d}),
    }

    // You can compare the tagged union with the enum tag type
    if (tok == .digit and tok.digit == 42) std.debug.print("It's 42.\n", .{});
}
