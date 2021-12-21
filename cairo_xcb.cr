@[Link("cairo")]
lib LibXCB
	type Surface = Void
	type Device = Void

	fun cairo_xcb_surface_create(x0 : Pointer(Connection), x1 : Drawable, x2 : Visualtype, x3 : Int32, x4 : Int32) : Pointer(Surface)
	fun cairo_xcb_surface_create_for_bitmap(x0 : Pointer(Connection), x1 : Pointer(Screen), x2 : Pixmap, x3 : Int32, x4 : Int32) : Pointer(Surface)
	fun cairo_xcb_surface_create_with_xrender_format(x0 : Pointer(Connection), x1 : Pointer(Screen), x2 : Drawable, x3 : Pointer(RenderPictforminfo), x4 : Int32, x5 : Int32) : Pointer(Surface) 
	fun cairo_xcb_surface_set_size(x0 : Pointer(Surface), x1 : Int32, x2 : Int32) : Void
	fun cairo_xcb_surface_set_drawable(x0 : Pointer(Surface), x1 : Drawable, x2 : Int32, x3 : Int32) : Void
	fun cairo_xcb_device_get_connection(x0 : Device): Pointer(Connection)
	fun cairo_xcb_device_debug_cap_xshm_version(x0 : Device, x1 : Int32, x2 : Int32); Void
	fun cairo_xcb_device_debug_cap_xrender_version(x0 : Pointer(Device), x1 : Int32, x2 : Int32) : Void 
	fun cairo_xcb_device_debug_set_precision(x0 : Pointer(Device), x1 : Int32) : Void
	fun cairo_xcb_device_debug_get_precision(x0 : Pointer(Device) : Int32
end
