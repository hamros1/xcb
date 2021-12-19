@[Link("xcb-icccm")]
lib LibXCB
	struct IcccmGetTextPropertyReply
		_reply : Pointer(GetPropertyReply)
		encoding : Atom 
		name_len : UInt32 
		name : Pointer(Char)
		format : UInt8 
	end

	fun xcb_icccm_get_text_property(Pointer(Connection), Window, Atom) : GetPropertyCookie 

	fun xcb_icccm_get_text_property_unchecked(Pointer(Connection), Window, Atom) :  GetPropertyCookie 

	fun xcb_icccm_get_text_property_reply(Pointer(Connection), GetPropertyCookie, Pointer(IcccmGetTextPropertyReply), Pointer(GenericError*)) : UInt8 

	fun xcb_icccm_get_text_property_reply_wipe(Pointer(IcccmGetTextPropertyReply)) : Void 

	fun xcb_icccm_set_wm_name_checked(Pointer(Connection), Window, Atom, UInt8, UInt32, Pointer(Char)) : VoidCookie

	fun xcb_icccm_set_wm_name(Pointer(Connection), Window, Atom, UInt8, UInt32, Pointer(Char)) : VoidCookie

	fun xcb_icccm_get_wm_name(Pointer(Connection), Window) : GetPropertyCookie 

	fun xcb_icccm_get_wm_name_unchecked(Pointer(Connection), Window) : GetPropertyCookie 


	fun xcb_icccm_get_wm_name_reply(Pointer(Connection), GetPropertyCookie, Pointer(IcccmGetTextPropertyReply), Pointer(GenericError*)) : UInt8 

	fun xcb_icccm_set_wm_icon_name_checked(Pointer(Connection), Window, Atom, UInt8, UInt32, Pointer(Char)) : VoidCookie 

	fun xcb_icccm_set_wm_icon_name(Pointer(Connection), Window, Atom, UInt8, UInt32, Pointer(Char)) : VoidCookie 

	fun xcb_icccm_get_wm_icon_name(Pointer(Connection), Window) : GetPropertyCookie 

	fun xcb_icccm_get_wm_icon_name_unchecked(Pointer(Connection), Window) : GetPropertyCookie 

	fun xcb_icccm_get_wm_icon_name_reply(Pointer(Connection), GetPropertyCookie, Pointer(IcccmGetTextPropertyReply), Pointer(GenericError*)) : UInt8 

	fun xcb_icccm_set_wm_colormap_windows_checked(Pointer(Connection), Window, Atom, UInt32, Pointer(Window)) : VoidCookie 

	fun xcb_icccm_set_wm_colormap_windows(Pointer(Connection), Window, Atom, UInt32, Pointer(Window)) : VoidCookie 

	struct IcccmGetWMColormapWindowsReply
		windows_len : UInt32 
		windows : Pointer(Window) 
		_reply : Pointer(GetPropertyReply) 
	end

	fun xcb_icccm_get_wm_colormap_windows(Pointer(Connection), Window, Atom) : GetPropertyCookie 

	fun xcb_icccm_get_wm_colormap_windows_unchecked(Pointer(Connection), Window, Atom) : GetPropertyCookie 


	fun xcb_icccm_get_wm_colormap_windows_from_reply(Pointer(GetPropertyReply), Pointer(IcccmGetWMColormapWindowsReply)) : UInt8 
	fun xcb_icccm_get_wm_colormap_windows_reply(Pointer(Connection), GetPropertyCookie, Pointer(IcccmGetWMColormapWindowsReply), Pointer(GenericError)) : UInt8 

	fun xcb_icccm_get_wm_colormap_windows_reply_wipe(Pointer(IcccmGetWMColormapWindowsReply)) : Void 

	fun xcb_icccm_set_wm_client_machine_checked(Pointer(Connection), Window, Atom, UInt8, UInt32, Pointer(Char)) : VoidCookie 

	fun xcb_icccm_set_wm_client_machine(Pointer(Connection), Window, Atom, UInt8, UInt32, Pointer(Char)) : VoidCookie 


	fun xcb_icccm_get_wm_client_machine(Pointer(Connection), Window) : GetPropertyCookie 

	fun xcb_icccm_get_wm_client_machine_unchecked(Pointer(Connection), Window) : GetPropertyCookie 


	fun xcb_icccm_get_wm_client_machine_reply(Pointer(Connection), GetPropertyCookie, Pointer(IcccmGetTextPropertyReply), Pointer(GenericError*)) : UInt8 


	fun cxcb_icccm_set_wm_class_checked(Pointer(Connection), Window, UInt32, Pointer(Char)) : VoidCookie 


	fun xcb_icccm_set_wm_class(Pointer(Connection), Window, UInt32, Pointer(Char)) : VoidCookie 

	struct IcccmGetWMClassReply
		instance_name : Pointer(Char)
		class_name : Pointer(Char)
		_reply : GetPropertyReply 
	end

	fun xcb_icccm_get_wm_class(Pointer(Connection), Window) : GetPropertyCookie 

	fun xcb_icccm_get_wm_class_unchecked(Pointer(Connection), Window) : GetPropertyCookie 

	fun xcb_icccm_get_wm_class_from_reply(Pointer(IcccmGetWMClassReply), Pointer(GetPropertyReply)) : UInt8

	fun xcb_icccm_get_wm_class_reply(Pointer(Connection), GetPropertyCookie, Pointer(IcccmGetWMClassReply), Pointer(GenericError*)) : UInt8 

	fun xcb_icccm_get_wm_class_reply_wipe(Pointer(IcccmGetWMClassReply)) : Void 

	fun xcb_icccm_set_wm_transient_for_checked(Pointer(Connection), Window, Window) : VoidCookie 

	fun xcb_icccm_set_wm_transient_for(Pointer(Connection), Window, Window) : VoidCookie 


	fun xcb_icccm_get_wm_transient_for(Pointer(Connection), Window) : GetPropertyCookie 

	fun xcb_icccm_get_wm_transient_for_unchecked(Pointer(Connection), Window) : GetPropertyCookie 

	fun xcb_icccm_get_wm_transient_for_from_reply(Pointer(Window), Pointer(GetPropertyReply)) : UInt8

	fun xcb_icccm_get_wm_transient_for_reply(Pointer(Connection), GetPropertyCookie, Pointer(Window), Pointer(GenericError)) : UInt8 

	XCB_ICCCM_SIZE_HINT_US_POSITION = 1 << 0
		XCB_ICCCM_SIZE_HINT_US_SIZE = 1 << 1
		XCB_ICCCM_SIZE_HINT_P_POSITION = 1 << 2
		XCB_ICCCM_SIZE_HINT_P_SIZE = 1 << 3
		XCB_ICCCM_SIZE_HINT_P_MIN_SIZE = 1 << 4
		XCB_ICCCM_SIZE_HINT_P_MAX_SIZE = 1 << 5
		XCB_ICCCM_SIZE_HINT_P_RESIZE_INC = 1 << 6
		XCB_ICCCM_SIZE_HINT_P_ASPECT = 1 << 7
		XCB_ICCCM_SIZE_HINT_BASE_SIZE = 1 << 8
		XCB_ICCCM_SIZE_HINT_P_WIN_GRAVITY = 1 << 9

	struct SizeHints
		flags : UInt32 
		x, y : Int32 
		width, height : Int32 
		min_width, min_height : Int32 
		max_width, max_height : Int32 
		width_inc, height_inc : Int32 
		min_aspect_num, min_aspect_den : Int32 
		max_aspect_num, max_aspect_den : Int32 
		base_width, base_height : Int32 
		win_gravity : UInt32 
	end

	XCB_ICCCM_NUM_WM_SIZE_HINTS_ELEMENTS = 18

	fun xcb_icccm_size_hints_set_position(Pointer(SizeHints), Int32, Int32, Int32) : Void 

	fun xcb_icccm_size_hints_set_size(Pointer(SizeHints), Int32, Int32, Int32) : Void 

	fun xcb_icccm_size_hints_set_min_size(Pointer(SizeHints), Int32, Int32) : Void 

	fun xcb_icccm_size_hints_set_max_size(Pointer(SizeHints), Int32, Int32) : Void

	fun xcb_icccm_size_hints_set_resize_inc(Pointer(SizeHints), Int32,  Int32) : Void 

	fun xcb_icccm_size_hints_set_aspect(Pointer(SizeHints), Int32, Int32, Int32, Int32) : Void 

	fun xcb_icccm_size_hints_set_base_size(Pointer(SizeHints), Int32, Int32) : Void

	fun xcb_icccm_size_hints_set_win_gravity(Pointer(SizeHints), Gravity) : Void 

	fun xcb_icccm_set_wm_size_hints_checked(Pointer(Connection), Window, Atom, Pointer(SizeHints)) : VoidCookie 

	fun xcb_icccm_set_wm_size_hints(Pointer(Connection), Window, Atom, Pointer(SizeHints)) : VoidCookie 

	fun xcb_icccm_get_wm_size_hints(Pointer(Connection), Window, Atom) : GetPropertyCookie 

	fun xcb_icccm_get_wm_size_hints_unchecked(Pointer(Connection), Window, Atom) : GetPropertyCookie 

	fun xcb_icccm_get_wm_size_hints_reply(Pointer(Connection), GetPropertyCookie, Pointer(SizeHints), Pointer(GenericError*)) : UInt8 

	fun xcb_icccm_set_wm_normal_hints_checked(Pointer(Connection), Window, Pointer(SizeHints)) : VoidCookie 

	fun xcb_icccm_set_wm_normal_hints(Pointer(Connection), Window, Pointer(SizeHints)) : VoidCookie 

	fun xcb_icccm_get_wm_normal_hints(Pointer(Connection), Window) : GetPropertyCookie 

	fun xcb_icccm_get_wm_normal_hints_unchecked(Pointer(Connection), Window) : GetPropertyCookie 

	fun xcb_icccm_get_wm_size_hints_from_reply(Pointer(SizeHints), Pointer(GetPropertyReply)) : UInt8

	fun xcb_icccm_get_wm_normal_hints_reply(Pointer(Connection), GetPropertyCookie, Pointer(SizeHints), Pointer(GenericError)) : UInt8 

	struct IcccmWMHints
		flags : Int32 
		input : UInt32 
		initial_state : Int32 
		icon_pixmap : Pixmap
		icon_window : Window 
		icon_x, icon_y : Int32 
		icon_mask : Pixmap
		window_group : Window 
	end 

	XCB_ICCCM_NUM_WM_HINTS_ELEMENTS = 9

	XCB_ICCCM_WM_STATE_WITHDRAWN = 0
	XCB_ICCCM_WM_STATE_NORMAL = 1
	XCB_ICCCM_WM_STATE_ICONIC = 3

	XCB_ICCCM_WM_HINT_INPUT = (1_i64 << 0)
	XCB_ICCCM_WM_HINT_STATE = (1_i64 << 1)
	XCB_ICCCM_WM_HINT_ICON_PIXMAP = (1_i64 << 2)
	XCB_ICCCM_WM_HINT_ICON_WINDOW = (1_i64 << 3)
	XCB_ICCCM_WM_HINT_ICON_POSITION = (1_i64 << 4)
	XCB_ICCCM_WM_HINT_ICON_MASK = (1_i64 << 5)
	XCB_ICCCM_WM_HINT_WINDOW_GROUP = (1_i64 << 6)
	XCB_ICCCM_WM_HINT_X_URGENCY = (1_i64 << 8)

	XCB_ICCCM_WM_ALL_HINTS = XCB_ICCCM_WM_HINT_INPUT | XCB_ICCCM_WM_HINT_STATE | XCB_ICCCM_WM_HINT_ICON_PIXMAP | XCB_ICCCM_WM_HINT_ICON_WINDOW | XCB_ICCCM_WM_HINT_ICON_POSITION | XCB_ICCCM_WM_HINT_ICON_MASK | XCB_ICCCM_WM_HINT_WINDOW_GROUP

	fun xcb_icccm_wm_hints_get_urgency(Pointer(IcccmWMHints)) : UInt32 

	fun xcb_icccm_wm_hints_set_input(Pointer(IcccmWMHints), UInt8) : Void 

	fun xcb_icccm_wm_hints_set_iconic(Pointer(IcccmWMHints)) : Void 

	fun xcb_icccm_wm_hints_set_normal(Pointer(IcccmWMHints)) : Void 

	fun xcb_icccm_wm_hints_set_withdrawn(Pointer(IcccmWMHints)) : Void 

	fun xcb_icccm_wm_hints_set_none(Pointer(IcccmWMHints)) : Void 

	fun xcb_icccm_wm_hints_set_icon_pixmap(Pointer(IcccmWMHints), Pixmap) : Void 

	fun xcb_icccm_wm_hints_set_icon_mask(Pointer(IcccmWMHints), Pixmap) : Void 

	fun xcb_icccm_wm_hints_set_icon_window(Pointer(IcccmWMHints), Window) : Void 

	fun xcb_icccm_wm_hints_set_window_group(Pointer(IcccmWMHints), Window) : Void 

	fun xcb_icccm_wm_hints_set_urgency(Pointer(IcccmWMHints)) : Void 

	fun xcb_icccm_set_wm_hints_checked(Pointer(Connection), Window, Pointer(IcccmWMHints)) : VoidCookie 

	fun xcb_icccm_set_wm_hints(Pointer(Connection), Window, Pointer(IcccmWMHints)) : VoidCookie 

	fun xcb_icccm_get_wm_hints(Pointer(Connection), Window) : GetPropertyCookie 

	fun xcb_icccm_get_wm_hints_unchecked(Pointer(Connection),  Window) : GetPropertyCookie 


	fun xcb_icccm_get_wm_hints_from_reply(Pointer(IcccmWMHints), Pointer(GetPropertyReply)) : UInt8

	fun xcb_icccm_get_wm_hints_reply(Pointer(Connection), GetPropertyCookie, Pointer(IcccmWMHints), Pointer(GenericError*)) : UInt8 

	fun xcb_icccm_set_wm_protocols_checked(Pointer(Connection), Window, Atom, UInt32, Pointer(Atom)) : VoidCookie 

	fun xcb_icccm_set_wm_protocols(Pointer(Connection), Window, Atom, UInt32, Pointer(Atom)) : VoidCookie 

	struct GetWMProtocolsReply
		atoms_len : UInt32 
		atoms : Pointer(Atom) 
		_reply : Pointer(GetPropertyReply)
	end

	fun xcb_icccm_get_wm_protocols(Pointer(Connection), Window, Atom) : GetPropertyCookie 

	fun xcb_icccm_get_wm_protocols_unchecked(Pointer(Connection), Window, Atom) : GetPropertyCookie 

	fun xcb_icccm_get_wm_protocols_from_reply(Pointer(GetPropertyReply), Pointer(GetWMProtocolsReply)) : UInt8 

	fun xcb_icccm_get_wm_protocols_reply(Pointer(Connection), GetPropertyCookie, Pointer(GetWMProtocolsReply), Pointer(GenericError*)) : UInt8 

	fun xcb_icccm_get_wm_protocols_reply_wipe(Pointer(GetWMProtocolsReply)) : Void 
end
