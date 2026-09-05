# sdl3webgpu
This is [sdl3webgpu](https://github.com/eliemichel/sdl3webgpu) for the zig build system.

# Usage
You need to bring your own headers and library for SDL 3 and a WebGPU implementation (dawn for example).  
```zig
pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const sdl3_dep = b.dependency("sdl", .{
        .target = target,
        .optimize = optimize,
    });
    const sdl3_lib = sdl3_dep.artifact("sdl3");

    const dawn_dep = b.dependency("dawn", .{
        .target = target,
        .optimize = optimize,
    });
    const webgpu_lib = dawn_dep.artifact("webgpu_dawn");

    const sdl3webgpu_dep = b.dependency("sdl3webgpu", .{
        .target = target,
        .optimize = optimize,
    });
    const sdl3webgpu_lib = sdl3webgpu_dep.artifact("sdl3webgpu");
    sdl3webgpu_lib.root_module.linkLibrary(sdl3_lib);
    sdl3webgpu_lib.root_module.linkLibrary(webgpu_lib);

    // ...
}
```

# Example
Check out [sdl3 dawn example](https://github.com/akunaakwei/zig-sdl3-dawn-example) for a fully functional example.