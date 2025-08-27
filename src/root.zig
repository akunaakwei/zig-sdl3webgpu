const webgpu = @import("webgpu");
const sdl3 = @import("sdl3");

pub extern fn SDL_GetWGPUSurface(instance: webgpu.WGPUInstance, window: ?*sdl3.SDL_Window) webgpu.WGPUSurface;
