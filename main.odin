package main

import "base:runtime"
import "core:fmt"
import wl "packages/wayland"
import gl "vendor:OpenGL"
import "vendor:egl"

main :: proc() {
	wl.init_oland_context()
	defer wl.fini_oland_context(wl.oland_context)

	wl_ctx := wl.oland_context
	window, window_err := wl.create_new_window(200, 200, "TEST")
	if window_err != nil {
		fmt.println("Failed to create new window: {}", window_err)
		return
	}
	window2, window2_err := wl.create_new_window(200, 200, "TEST2")
	if window2_err != nil {
		fmt.println("Failed to create new window: {}", window_err)
		return
	}

	// for {
	for wl.display_dispatch(wl_ctx.display) != 0 {
		gl.ClearColor(0.0 / 255, 79.0 / 255, 158.0 / 255, 1.0)
		gl.Clear(gl.COLOR_BUFFER_BIT)
		egl.SwapBuffers(window.egl_display, window.egl_surface)
		fmt.printfln("{}", window.title)

		gl.ClearColor(250.0 / 255, 79.0 / 255, 158.0 / 255, 1.0)
		gl.Clear(gl.COLOR_BUFFER_BIT)
		egl.SwapBuffers(window2.egl_display, window2.egl_surface)
		fmt.printfln("{}", window2.title)
	}
	// for wl.display_dispatch(display) != 0 {

	// }
	//wl.registry_destroy(registry)
}

