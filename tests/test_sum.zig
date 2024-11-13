const std = @import("std");
const expect = std.testing.expect;

const cpp = @cImport({
    @cInclude("sum.h");
});

test "sum" {
    try expect(cpp.sum(10, 20) == 30);
    try expect(cpp.sum(-10, 10) == 0);
}
