@[Link("xcb")]
lib LibXCB
	fun xcb_aux_get_depth(x0 : Pointer(Connection), x1 : Pointer(Screen)) : UInt8

	fun xcb_aux_get_depth_of_visual(x0 : Pointer(Screen), x1 : Visualid) :  UInt8 

	fun xcb_aux_get_screen(x0 : Pointer(Connection), x1 : Int32) :  Pointer(Screen)

	fun xcb_aux_get_visualtype(x0 : Pointer(Connection),x1 : Int32, x2 : Visualid) : Pointer(Visualtype)

	fun xcb_aux_find_visual_by_id(x0 : Pointer(Screen), x1 : Visualid) : Pointer(Visualtype)

	fun xcb_aux_find_visual_by_attrs(x0 : Pointer(Screen), x1 : Int8, x2 : Int8) : Pointer(Visualtype)

	fun xcb_aux_sync(x0 : Pointer(Connection)) : Void

	struct ParamsCW 
		back_pixmap : UInt32 
		back_pixel : UInt32 
		border_pixmap : UInt32 
		border_pixel : UInt32 
		bit_gravity : UInt32 
		win_gravity : UInt32 
		backing_store : UInt32 
		backing_planes : UInt32 
		backing_pixel : UInt32 
		override_redirect : UInt32 
		save_under : UInt32 
		event_mask : UInt32 
		dont_propagate : UInt32 
		colormap : UInt32 
		cursor : UInt32 
	end 

	fun xcb_aux_create_window(x0 : Pointer(Connection), x1 : UInt8, x2 : Window, x3 : Window, x4 : Int32, x5 : Int32, x6 : UInt16, x7 : UInt16, x8 : UInt16, x9 : UInt16, x10 : Visualid, x11 : UInt32, x12 : Pointer(ParamsCW)) : VoidCookie  

	fun xcb_aux_create_window_checked(x0 : Pointer(Connection), x1 : UInt8, x2 : Window, x3 : Window, x4 : Int32, x5 : Int32, x6 : UInt16, x7 : UInt16, x8 : UInt16, x9 : UInt16, x10 : Visualid, x11 : UInt32, x12 : Pointer(ParamsCW)) : VoidCookie

	fun xcb_aux_change_window_attributes(x0 : Pointer(Connection), x1 : Window, x2 : UInt32, x3 : Pointer(ParamsCW)) : VoidCookie

	struct ParamsConfigureWindow
		x : Int32   
		y : Int32   
		width : UInt32 
		height : UInt32 
		border_width : UInt32 
		sibling : UInt32 
		stack_mode : UInt32 
	end

	fun xcb_aux_configure_window(x0 : Pointer(Connection), x1 : Window, x2 : UInt16, x3 : Pointer(ParamsConfigureWindow)) : VoidCookie

	struct ParamsGC
		function : UInt32 
		plane_mask : UInt32 
		foreground : UInt32 
		background : UInt32
		line_width : UInt32
		line_style : UInt32
		cap_style : UInt32
		join_style : UInt32
		fill_style : UInt32
		fill_rule : UInt32
		tile : UInt32
		stipple : UInt32
		tile_stipple_origin_x : UInt32
		tile_stipple_origin_y : UInt32
		font : UInt32
		subwindow_mode : UInt32
		graphics_exposures : UInt32
		clip_originX : UInt32
		clip_originY : UInt32
		mask : UInt32
		dash_offset : UInt32 
		dash_list : UInt32
		arc_mode : UInt32
	end

	fun xcb_aux_create_gc(x0 : Pointer(Connection), x1 : GContext, x2 : Drawable, x3 : UInt32, x4 : Pointer(ParamsGC)) : VoidCookie


	fun xcb_aux_create_gc_checked (x0 : Pointer(Connection), x1 : GContext, x2 : Drawable, x3 : UInt32, x4 : Pointer(ParamsGC)) : VoidCookie

	fun xcb_aux_change_gc(x0 : Pointer(Connection), x1 : GContext, x2 : UInt32, x3 : Pointer(ParamsGC)) : VoidCookie
	fun xcb_aux_change_gc_checked (x0 : Pointer(Connection), x2 : GContext, x3 : UInt32, x4 : Pointer(ParamsGC)) : VoidCookie

	struct ParamsKeyboard
		key_click_percent : UInt32 
		bell_percent : UInt32 
		bell_pitch : UInt32 
		bell_duration : UInt32 
		led : UInt32 
		led_mode : UInt32 
		key :  UInt32 
		auto_repeat_mode :  UInt32 
	end 

	fun xcb_aux_change_keyboard_control(x0 : Pointer(Connection), x1 : UInt32, x2 : Pointer(ParamsKeyboard)) : VoidCookie

	fun xcb_aux_parse_color(x0 : Pointer(Char), x1 : Pointer(UInt16), x2 : Pointer(UInt16), x3 : Pointer(UInt16)) : Int32

	fun xcb_aux_set_line_attributes_checked (Pointer(Connection), GContext, UInt16, Int32, Int32, Int32) :  VoidCookie

	fun xcb_aux_clear_window(x0 : Pointer(Connection), x1 : Window) : VoidCookie
end
