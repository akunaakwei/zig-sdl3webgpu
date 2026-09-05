const std = @import("std");
const LazyPath = std.Build.LazyPath;

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const sdl3webgpu_dep = b.dependency("sdl3webgpu", .{});
    const sdl3webgpu_mod = b.createModule(.{
        .target = target,
        .optimize = optimize,
        .link_libc = true,
    });
    sdl3webgpu_mod.addCSourceFiles(.{
        .root = sdl3webgpu_dep.path("."),
        .files = &.{"sdl3webgpu.c"},
    });
    const sdl3webgpu = b.addLibrary(.{
        .name = "sdl3webgpu",
        .root_module = sdl3webgpu_mod,
    });
    sdl3webgpu.installHeader(sdl3webgpu_dep.path("sdl3webgpu.h"), "sdl3webgpu.h");
    b.installArtifact(sdl3webgpu);
}
