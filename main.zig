const std = @import("std");
const cpp = @cImport({
    @cInclude("sum.h");
});

pub fn main() !void {
    std.debug.print("10 + 20 = {d}\n", .{cpp.sum(10, 20)});
}
