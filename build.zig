const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const app_name = "zig-cpp";
    const entrypoint: []const u8 = "src/sum.cpp";

    const exe = b.addExecutable(.{
        .name = app_name,
        .root_source_file = b.path("main.zig"),
        .target = target,
        .optimize = optimize,
    });

    // link with the standard library libcpp
    exe.linkLibCpp();
    exe.addIncludePath(.{ .cwd_relative = "src" });
    exe.addCSourceFile(.{ .file = .{ .cwd_relative = entrypoint } });

    b.installArtifact(exe);

    // run step
    const run_exe = b.addRunArtifact(exe);
    const run_step = b.step("run", "Run the application");
    run_step.dependOn(&run_exe.step);

    // test step
    const test_step = b.step("test", "Run unit tests");
    const tests = b.addTest(.{
        .root_source_file = b.path("tests/root.zig"),
        .target = target,
    });
    tests.linkLibCpp();
    tests.addIncludePath(.{ .cwd_relative = "src" });
    tests.addCSourceFile(.{ .file = .{ .cwd_relative = entrypoint } });

    const run_unit_tests = b.addRunArtifact(tests);
    test_step.dependOn(&run_unit_tests.step);
}
