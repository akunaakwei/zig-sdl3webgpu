const std = @import("std");
const LazyPath = std.Build.LazyPath;

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const sdl3_headers = b.option(LazyPath, "sdl3_headers", "Path to SDL3 headers") orelse {
        const fail = b.addFail("must provide path to SDL3 headers");
        b.getInstallStep().dependOn(&fail.step);
        return;
    };
    const sdl3_library = b.option(LazyPath, "sdl3_library", "Path to SDL3 library") orelse {
        const fail = b.addFail("must provide path to SDL3 library");
        b.getInstallStep().dependOn(&fail.step);
        return;
    };
    const webgpu_headers = b.option(LazyPath, "webgpu_headers", "Path to WebGPU headers") orelse {
        const fail = b.addFail("must provide path to WebGPU headers");
        b.getInstallStep().dependOn(&fail.step);
        return;
    };
    const webgpu_library = b.option(LazyPath, "webgpu_library", "Path to WebGPU library") orelse {
        const fail = b.addFail("must provide path to WebGPU library");
        b.getInstallStep().dependOn(&fail.step);
        return;
    };

    const sdl3webgpu_dep = b.dependency("sdl3webgpu", .{});
    const sdl3webgpu = b.addLibrary(.{
        .name = "sdl3webgpu",
        .root_module = b.createModule(.{
            .target = target,
            .optimize = optimize,
            .link_libc = true,
        }),
    });
    sdl3webgpu.addIncludePath(sdl3_headers);
    sdl3webgpu.addObjectFile(sdl3_library);
    sdl3webgpu.addIncludePath(webgpu_headers);
    sdl3webgpu.addObjectFile(webgpu_library);

    sdl3webgpu.addCSourceFiles(.{
        .root = sdl3webgpu_dep.path("."),
        .files = &.{"sdl3webgpu.c"},
    });
    sdl3webgpu.installHeader(sdl3webgpu_dep.path("sdl3webgpu.h"), "sdl3webgpu.h");
    b.installArtifact(sdl3webgpu);

    const mod = b.addModule("sdl3webgpu", .{
        .target = target,
        .optimize = optimize,
        .root_source_file = b.path("src/root.zig"),
    });
    mod.linkLibrary(sdl3webgpu);
}
