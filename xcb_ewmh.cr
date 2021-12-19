@[Link("xcb-util")]
lib LibXCB
	struct EwmhConnection
		connection : Pointer(Connection)
		xcb_ewmh_screen : Pointer(Screen*)
		nb_screens : Int32 
		net_wm_cm_sN : Pointer(Atom)
		net_supported : Atom
		net_client_list : Atom
		net_client_list_stacking : Atom
		net_number_of_desktops : Atom 
		net_desktop_geometry : Atom 
		net_desktop_viewport : Atom
		net_current_desktop : Atom
		net_desktop_names : Atom
		net_active_window : Atom
		net_workarea : Atom
		net_supporting_wm_check : Atom
		net_virtual_roots : Atom
		net_desktop_layout : Atom
		net_showing_desktop : Atom
		net_close_window : Atom
		net_moveresize_window : Atom
		net_wm_moveresize : Atom
		net_restack_window : Atom
		net_request_frame_extents : Atom
		net_wm_name : Atom
		net_wm_visible_name : Atom
		net_wm_icon_name : Atom
		net_wm_visible_icon_name : Atom
		net_wm_desktop : Atom
		net_wm_window_type : Atom
		net_wm_state : Atom
		net_wm_allowed_actions : Atom
		net_wm_strut : Atom
		net_wm_strut_partial : Atom
		net_wm_icon_geometry : Atom
		net_wm_icon : Atom
		net_wm_pid : Atom
		net_wm_handled_icons : Atom
		net_wm_user_time : Atom
		net_wm_user_time_window : Atom
		net_frame_extents : Atom
		net_wm_ping : Atom
		net_wm_sync_request : Atom
		net_wm_sync_request_counter : Atom
		net_wm_fullscreen_monitors : Atom
		net_wm_full_placement : Atom
		utf8_string : Atom
		wm_protocols : Atom
		manager : Atom
		net_wm_window_type_desktop : Atom
		net_wm_window_type_dock : Atom
		net_wm_window_type_toolbar : Atom
		net_wm_window_type_menu : Atom
		net_wm_window_type_utility : Atom
		net_wm_window_type_splash : Atom
		net_wm_window_type_dialog : Atom
		net_wm_window_type_dropdown_menu : Atom
		net_wm_window_type_popup_menu : Atom
		net_wm_window_type_tooltip : Atom
		net_wm_window_type_notification : Atom
		net_wm_window_type_combo : Atom
		net_wm_window_type_dnd : Atom
		net_wm_window_type_normal : Atom
		net_wm_state_modal : Atom
		net_wm_state_sticky : Atom
		net_wm_state_maximized_vert : Atom
		net_wm_state_maximized_horz : Atom
		net_wm_state_shaded : Atom
		net_wm_state_skip_taskbar : Atom
		net_wm_state_skip_pager : Atom
		net_wm_state_hidden : Atom
		net_wm_state_fullscreen : Atom
		net_wm_state_above : Atom
		net_wm_state_below : Atom
		net_wm_state_demands_attention : Atom
		net_wm_action_move : Atom
		net_wm_action_resize : Atom
		net_wm_action_minimize : Atom
		net_wm_action_shade : Atom
		net_wm_action_stick : Atom
		net_wm_action_maximize_horz : Atom
		net_wm_action_maximize_vert : Atom
		net_wm_action_fullscreen : Atom
		net_wm_action_change_desktop : Atom
		net_wm_action_close : Atom
		net_wm_action_above : Atom
		net_wm_action_below : Atom
	end

	struct EwmhGetAtomsReply
		atoms_len : UInt32 
		atoms : Atom 
		_reply : GetPropertyReply 
	end

	struct EwmhGetWindowsReply
		windows_len : UInt32 
		windows : Pointer(Window)
		_reply : Pointer(GetPropertyReply)
	end

	struct EwmhGetUTF8StringsReply
		strings_len : UInt32 
		strings : Pointer(Char)
		_reply : Pointer(GetPropertyReply)
	end

	struct EwmhCoordinates
		x : UInt32 
		y : UInt32 
	end

	struct EwmhGetDesktopViewportReply
		desktop_viewport_len : UInt32 
		desktop_viewport : Pointer(EwmhCoordinates)
		_reply : Pointer(GetPropertyReply)
	end 

	struct EwmhGeometry
		x : UInt32 
		y : UInt32 
		width : UInt32 
		height : UInt32 
	end

	struct EwmhGetWorkareaReply
		workarea_len : UInt32 
		workarea : Pointer(EwmhGeometry)
		_reply : Pointer(GetPropertyReply)
	end

	XCB_EWMH_CLIENT_SOURCE_TYPE_NONE = 0
	XCB_EWMH_CLIENT_SOURCE_TYPE_NORMAL = 1
	XCB_EWMH_CLIENT_SOURCE_TYPE_OTHER = 2

	XCB_EWMH_WM_ORIENTATION_HORZ = 0
	XCB_EWMH_WM_ORIENTATION_VERT = 1

	XCB_EWMH_WM_TOPLEFT = 0
	XCB_EWMH_WM_TOPRIGHT = 1
	XCB_EWMH_WM_BOTTOMRIGHT = 2
	XCB_EWMH_WM_BOTTOMLEFT = 3

	struct EwmhGetDesktopLayoutReply
		orientation : UInt32 
		columns : UInt32 
		rows : UInt32 
		starting_corner : UInt32 
	end

	XCB_EWMH_MOVERESIZE_WINDOW_X = (1 << 8)
	XCB_EWMH_MOVERESIZE_WINDOW_Y = (1 << 9)
	XCB_EWMH_MOVERESIZE_WINDOW_WIDTH = (1 << 10)
	XCB_EWMH_MOVERESIZE_WINDOW_HEIGHT = (1 << 11)

	XCB_EWMH_WM_MOVERESIZE_SIZE_TOPLEFT = 0
	XCB_EWMH_WM_MOVERESIZE_SIZE_TOP = 1
	XCB_EWMH_WM_MOVERESIZE_SIZE_TOPRIGHT = 2
	XCB_EWMH_WM_MOVERESIZE_SIZE_RIGHT = 3
	XCB_EWMH_WM_MOVERESIZE_SIZE_BOTTOMRIGHT = 4
	XCB_EWMH_WM_MOVERESIZE_SIZE_BOTTOM = 5
	XCB_EWMH_WM_MOVERESIZE_SIZE_BOTTOMLEFT = 6
	XCB_EWMH_WM_MOVERESIZE_SIZE_LEFT = 7
	XCB_EWMH_WM_MOVERESIZE_MOVE = 8
	XCB_EWMH_WM_MOVERESIZE_SIZE_KEYBOARD = 9
	XCB_EWMH_WM_MOVERESIZE_MOVE_KEYBOARD = 10
	XCB_EWMH_WM_MOVERESIZE_CANCEL = 11

	XCB_EWMH_WM_STATE_REMOVE = 0
	XCB_EWMH_WM_STATE_ADD = 1
	XCB_EWMH_WM_STATE_TOGGLE = 2

	struct EwmhWMStrutPartial
		left : UInt32 
		right : UInt32 
		top : UInt32 
		bottom : UInt32 
		left_start_y : UInt32 
		left_end_y : UInt32 
		right_start_y : UInt32 
		right_end_y : UInt32 
		top_start_x : UInt32 
		top_end_x : UInt32 
		bottom_start_x : UInt32 
		bottom_end_x : UInt32 
	end

	struct EwmhWMIconIterator
		width : UInt32 
		height : UInt32 
		data : Pointer(UInt32)
		rem : UInt32 
		index : UInt32 
	end

	struct EwmhGetWMIconReply
		num_icons : UInt32
		_reply : Pointer(GetPropertyReply)
	end

	struct EwmhGetExtentsReply
		left : UInt32 
		right : UInt32 
		top : UInt32 
		bottom : UInt32 
	end

	struct EwmhGetWMFullscreenMonitorsReply
		top : UInt32 
		bottom : UInt32 
		left : UInt32 
		right : UInt32 
	end

	fun xcb_ewmh_init_atoms(x0 : Pointer(Connection), x1 : Pointer(EwmhConnection)) : Pointer(InternAtomCookie)

	fun xcb_ewmh_init_atoms_replies(x0 : Pointer(EwmhConnection), x1 : Pointer(InternAtomCookie), x2 : Pointer(GenericError*)) : UInt8 

	fun xcb_ewmh_connection_wipe(x0 : Pointer(EwmhConnection)) : Void

	fun xcb_ewmh_send_client_message(x0 : Pointer(Connection), x1 : Window, x2 : Window, x3 : Atom, x4 : UInt32, x5 : Pointer(UInt32)) : VoidCookie 

	fun xcb_ewmh_get_window_from_reply(x0 : Pointer(Window), x1 : Pointer(GetPropertyReply)) :  UInt8 

	fun xcb_ewmh_get_window_reply(x0 : Pointer(EwmhConnection), x1 : GetPropertyCookie, x2 : Pointer(Window), x3 : Pointer(GenericError*)) : UInt8 

	fun xcb_ewmh_get_cardinal_from_reply(x0 : Pointer(UInt32), x1 : Pointer(GetPropertyReply)) : UInt8 

	fun xcb_ewmh_get_cardinal_reply(x0 : Pointer(EwmhConnection), x1 : GetPropertyCookie, x2 : Pointer(UInt32), x3 : Pointer(GenericError)) : UInt8 

	fun xcb_ewmh_get_atoms_from_reply(x0 : Pointer(EwmhGetAtomsReply), x1 : Pointer(GetPropertyReply)) : UInt8 

	fun xcb_ewmh_get_atoms_reply(x0 : Pointer(EwmhConnection), x1 : GetPropertyCookie, x2 : Pointer(EwmhGetAtomsReply), x3 : Pointer(GenericError*)) : UInt8 

	fun xcb_ewmh_get_atoms_reply_wipe(x0 : Pointer(EwmhGetAtomsReply)) : Void

	fun xcb_ewmh_get_windows_from_reply(x0 : Pointer(EwmhGetWindowsReply), x1 : Pointer(GetPropertyReply)) : UInt8 

	fun xcb_ewmh_get_utf8_strings_from_reply(x0 : Pointer(EwmhConnection), x1 : Pointer(EwmhGetUTF8StringsReply), x2 : Pointer(GetPropertyReply)) : UInt8 

	fun xcb_ewmh_get_utf8_strings_reply(x0 : Pointer(EwmhConnection), x1 : GetPropertyCookie, x2 : Pointer(EwmhGetUTF8StringsReply), x3 : Pointer(GenericError*)) : UInt8 

	fun xcb_ewmh_get_windows_reply(x0 : Pointer(EwmhConnection), x1 : GetPropertyCookie, x2 : Pointer(EwmhGetWindowsReply), x3 : Pointer(GenericError*)) : UInt8 

	fun xcb_ewmh_get_windows_reply_wipe(x0 : Pointer(EwmhGetWindowsReply)) : Void

	fun xcb_ewmh_get_utf8_strings_reply_wipe(x0 : Pointer(EwmhGetUTF8StringsReply)) : Void 

	fun xcb_ewmh_set_supported(x0 : Pointer(EwmhConnection), x1 : Int32, x2 : UInt32, x3 : Pointer(Atom)) : VoidCookie 

	fun xcb_ewmh_set_supported_checked(x0 : Pointer(EwmhConnection), x1 : Int32, x2 : UInt32, x3 : Pointer(Atom)) : VoidCookie 

	fun xcb_ewmh_get_supported_unchecked(x0 : Pointer(EwmhConnection), x1 : Int32) : GetPropertyCookie 

	fun xcb_ewmh_get_supported(x0 : Pointer(EwmhConnection), x1 : Int32) : GetPropertyCookie 

	fun xcb_ewmh_get_supported_from_reply(x0 : Pointer(EwmhGetAtomsReply), x1 : Pointer(GetPropertyReply)) :  UInt8

	fun xcb_ewmh_get_supported_reply(x0 : Pointer(EwmhConnection), x1 : GetPropertyCookie, x2 : Pointer(EwmhGetAtomsReply), x3 : Pointer(GenericError*)) : UInt8

	fun xcb_ewmh_set_client_list(x0 : Pointer(EwmhConnection), x1 : Int32, x2 : UInt32, x3 : Pointer(Window)) : VoidCookie 

	fun xcb_ewmh_set_client_list_checked(x0 : Pointer(EwmhConnection), x1 : Int32, x2 : UInt32, x3 : Window) : VoidCookie 

	fun xcb_ewmh_get_client_list_unchecked(x0 : Pointer(EwmhConnection), x1 : Int32) : GetPropertyCookie 

	fun xcb_ewmh_get_client_list(x0 : Pointer(EwmhConnection), x1 : Int32) : GetPropertyCookie 

	fun xcb_ewmh_get_client_list_from_reply(x0 : Pointer(EwmhGetWindowsReply), x1 : Pointer(GetPropertyReply)) : UInt8

	fun xcb_ewmh_get_client_list_reply(x0 : Pointer(EwmhConnection), x1 : GetPropertyCookie, x2 : Pointer(EwmhGetWindowsReply), x3 : Pointer(GenericError*)) : UInt8

	fun xcb_ewmh_set_client_list_stacking(x0 : Pointer(EwmhConnection), x1 : Int32, x2 : UInt32, x3 : Pointer(Window)) : VoidCookie 

	fun xcb_ewmh_set_client_list_stacking_checked(x0 : Pointer(EwmhConnection), x1 : Int32, x2 : UInt32, x3 : Pointer(Window)) : VoidCookie 

	fun xcb_ewmh_get_client_list_stacking_unchecked(x0 : Pointer(EwmhConnection), x1 : Int32) : GetPropertyCookie 

	fun xcb_ewmh_get_client_list_stacking(x0 : Pointer(EwmhConnection), x1 : Int32) : GetPropertyCookie 

	fun xcb_ewmh_get_client_list_stacking_from_reply(x0 : Pointer(EwmhGetWindowsReply), x1 : Pointer(GetPropertyReply)) :  UInt8

	fun xcb_ewmh_get_client_list_stacking_reply(Pointer(EwmhConnection), GetPropertyCookie, Pointer(EwmhGetWindowsReply), Pointer(GenericError*)) : UInt8

	fun xcb_ewmh_set_number_of_desktops(x0 : Pointer(EwmhConnection), x1 : Int32, x2 : UInt32) : VoidCookie 

	fun xcb_ewmh_set_number_of_desktops_checked(x0 : Pointer(EwmhConnection), x1 : Int32, x2 : UInt32) : VoidCookie 

	fun xcb_ewmh_get_number_of_desktops_unchecked(x0 : Pointer(EwmhConnection), x1 : Int32) : GetPropertyCookie 

	fun xcb_ewmh_get_number_of_desktops(x0 : Pointer(EwmhConnection), x1 : Int32) : GetPropertyCookie 

	fun xcb_ewmh_get_number_of_desktops_from_reply(x0 : Pointer(UInt32), x1 : Pointer(GetPropertyReply)) : UInt8

	fun xcb_ewmh_get_number_of_desktops_reply(x0 : Pointer(EwmhConnection), x1 : GetPropertyCookie, x2 : Pointer(UInt32), x3 : Pointer(GenericError*)) : UInt8

	fun xcb_ewmh_request_change_number_of_desktops(x0 : Pointer(EwmhConnection), x1 : Int32, x2 : UInt32) : VoidCookie

	fun xcb_ewmh_set_desktop_geometry(x0 : Pointer(EwmhConnection), x1 : Int32, x2 : UInt32, x3 : UInt32) : VoidCookie 

	fun xcb_ewmh_set_desktop_geometry_checked(x0 : Pointer(EwmhConnection), x1 : Int32, x2 : UInt32, x3 : UInt32) : VoidCookie 

	fun xcb_ewmh_get_desktop_geometry_unchecked(x0 : Pointer(EwmhConnection), x1 : Int32) : GetPropertyCookie 

	fun xcb_ewmh_get_desktop_geometry(x0 : Pointer(EwmhConnection), x1 : Int32) : GetPropertyCookie 

	fun xcb_ewmh_request_change_desktop_geometry(x0 : Pointer(EwmhConnection), x1 : Int32, x2 : UInt32, x3 : UInt32) : VoidCookie 

	fun xcb_ewmh_get_desktop_geometry_from_reply(x0 : Pointer(UInt32), x1 : Pointer(UInt32), x2 : Pointer(GetPropertyReply)) : UInt8 

	fun xcb_ewmh_get_desktop_geometry_reply(x0 : Pointer(EwmhConnection), x1 : GetPropertyCookie, x2 : Pointer(UInt32), x3 : Pointer(UInt32), x4 : Pointer(GenericError*)) : UInt8 

	fun xcb_ewmh_set_desktop_viewport(x0 : Pointer(EwmhConnection), x1 : Int32, x2 : UInt32, x3 : Pointer(EwmhCoordinates)) : VoidCookie 

	fun xcb_ewmh_set_desktop_viewport_checked(x0 : Pointer(EwmhConnection), x1 : Int32, x2 : UInt32, x3 : Pointer(EwmhCoordinates)) : VoidCookie 

	fun xcb_ewmh_get_desktop_viewport_unchecked(x0 : Pointer(EwmhConnection), x1 : Int32) : GetPropertyCookie 

	fun xcb_ewmh_get_desktop_viewport(x0 : Pointer(EwmhConnection), x1 : Int32) : GetPropertyCookie 

	fun xcb_ewmh_request_change_desktop_viewport(x0 : Pointer(EwmhConnection), x1 : Int32, x2 : UInt32, x3 : UInt32) : VoidCookie 
	fun xcb_ewmh_get_desktop_viewport_from_reply(x0 : Pointer(EwmhGetDesktopViewportReply), x1 : Pointer(GetPropertyReply)) :  UInt8 
	fun xcb_ewmh_get_desktop_viewport_reply(x0 : Pointer(EwmhConnection), x1 : GetPropertyCookie, x2 : Pointer(EwmhGetDesktopViewportReply), x3 : Pointer(GenericError*)) : UInt8 

	fun xcb_ewmh_get_desktop_viewport_reply_wipe(x0 : Pointer(EwmhGetDesktopViewportReply)) : Void

	fun xcb_ewmh_set_current_desktop(x0 : Pointer(EwmhConnection), x1 : Int32, x2 : UInt32) : VoidCookie 

	fun xcb_ewmh_set_current_desktop_checked(x0 : Pointer(EwmhConnection), x1 : Int32, x2 : UInt32) : VoidCookie 

	fun xcb_ewmh_get_current_desktop_unchecked(x0 : Pointer(EwmhConnection), x1 : Int32) : GetPropertyCookie 

	fun xcb_ewmh_get_current_desktop(x0 : Pointer(EwmhConnection), x1 : Int32) : GetPropertyCookie 

	fun xcb_ewmh_request_change_current_desktop(x0 : Pointer(EwmhConnection), x1 : Int32, x2 : UInt32, x3 : Timestamp) : VoidCookie 

	fun xcb_ewmh_get_current_desktop_from_reply(x0 : Pointer(UInt32), x1 : Pointer(GetPropertyReply)) : UInt8

	fun xcb_ewmh_get_current_desktop_reply(x0 : Pointer(EwmhConnection), x1 : GetPropertyCookie, x2 : Pointer(UInt32), x3 : Pointer(GenericError*)) : UInt8

	fun xcb_ewmh_set_desktop_names(x0 : Pointer(EwmhConnection), x1 : Int32, x2 : UInt32, x3 : Pointer(Char)) : VoidCookie 

	fun xcb_ewmh_set_desktop_names_checked(x0 : Pointer(EwmhConnection), x1 : Int32, x2 : UInt32, x3 : Pointer(Char)) : VoidCookie 

	fun xcb_ewmh_get_desktop_names_unchecked(x0 : Pointer(EwmhConnection), x1 : Int32) : GetPropertyCookie 

	fun xcb_ewmh_get_desktop_names(x0 : Pointer(EwmhConnection), x1 : Int32) : GetPropertyCookie 

	fun xcb_ewmh_get_desktop_names_from_reply(x0 : Pointer(EwmhConnection), x1 : Pointer(EwmhGetUTF8StringsReply), x2 : Pointer(GetPropertyReply)) : UInt8

	fun xcb_ewmh_get_desktop_names_reply(x0 : Pointer(EwmhConnection), x1 : GetPropertyCookie, x2 : Pointer(EwmhGetUTF8StringsReply), x3 : Pointer(GenericError*)) : UInt8

	fun xcb_ewmh_set_active_window(x0 : Pointer(EwmhConnection), x1 : Int32, x2 : Window) : VoidCookie 

	fun xcb_ewmh_set_active_window_checked(x0 : Pointer(EwmhConnection), x1 : Int32, x2 : Window) : VoidCookie 

	fun xcb_ewmh_request_change_active_window(x0 : Pointer(EwmhConnection), x1 : Int32, x2 : Window, x3 : UInt32, x4 : Timestamp, x5 : Window) : VoidCookie 

	fun xcb_ewmh_get_active_window_unchecked(x0 : EwmhConnection, x1 : Int32) : GetPropertyCookie 

	fun xcb_ewmh_get_active_window(x0 : Pointer(EwmhConnection), x1 : Int32) : GetPropertyCookie 

	fun xcb_ewmh_get_active_window_from_reply(x0 : Pointer(Window), x1 : Pointer(GetPropertyReply)) : UInt8

	fun xcb_ewmh_get_active_window_reply(x0 : Pointer(EwmhConnection), x1 : GetPropertyCookie, x2 : Pointer(Window), x3 : Pointer(GenericError*)) : UInt8

	fun xcb_ewmh_set_workarea(x0 : Pointer(EwmhConnection), x1 : Int32, x2 : UInt32, x3 : Pointer(EwmhGeometry)) : VoidCookie

	fun xcb_ewmh_set_workarea_checked(x0 : Pointer(EwmhConnection), x1 : Int32, x2 : UInt32, x3 : Pointer(EwmhGeometry)) : VoidCookie 

	fun xcb_ewmh_get_workarea_unchecked(x0 : Pointer(EwmhConnection), x1 : Int32) : GetPropertyCookie 

	fun xcb_ewmh_get_workarea(x0 : Pointer(EwmhConnection), x1 : Int32) : GetPropertyCookie 

	fun xcb_ewmh_get_workarea_from_reply(x0 : Pointer(EwmhGetWorkareaReply), x1 : Pointer(GetPropertyReply)) : UInt8 

	fun xcb_ewmh_get_workarea_reply(x0 : Pointer(EwmhConnection), x1 : GetPropertyCookie, x2 : EwmhGetWorkareaReply, x3 : Pointer(GenericError*)) : UInt8 

	fun xcb_ewmh_get_workarea_reply_wipe(x0 : Pointer(EwmhGetWorkareaReply)) : Void

	fun xcb_ewmh_set_supporting_wm_check(x0 : Pointer(EwmhConnection), x1 : Window, x2 : Window) : VoidCookie 

	fun xcb_ewmh_set_supporting_wm_check_checked(x0 : Pointer(EwmhConnection), x1 : Window, x2 : Window) : VoidCookie 

	fun xcb_ewmh_get_supporting_wm_check_unchecked(x0 : Pointer(EwmhConnection), x1 : Window) : GetPropertyCookie 

	fun xcb_ewmh_get_supporting_wm_check(x0 : Pointer(EwmhConnection), x1 : Window) : GetPropertyCookie 

	fun xcb_ewmh_get_supporting_wm_check_from_reply(x0 : Pointer(Window), x1 : Pointer(GetPropertyReply)) : UInt8

	fun xcb_ewmh_get_supporting_wm_check_reply(x0 : Pointer(EwmhConnection), x1 : GetPropertyCookie, x2 : Pointer(Window), x3 : Pointer(GenericError*)) : UInt8

	fun xcb_ewmh_set_virtual_roots(x0 : Pointer(EwmhConnection), x2 : Int32, x3 : UInt32, x4 : Pointer(Window)) : VoidCookie 

	fun xcb_ewmh_set_virtual_roots_checked(x0 : Pointer(EwmhConnection), x1 : Int32, x2 : UInt32, x3 : Pointer(Window)) : VoidCookie 

	fun xcb_ewmh_get_virtual_roots_unchecked(x0 : Pointer(EwmhConnection), x1 : Int32) : GetPropertyCookie 

	fun xcb_ewmh_get_virtual_roots(x0 : Pointer(EwmhConnection), x1 : Int32) : GetPropertyCookie 

	fun xcb_ewmh_get_virtual_roots_from_reply(x0 : Pointer(EwmhGetWindowsReply), x1 : Pointer(GetPropertyReply)) : UInt8

	fun xcb_ewmh_get_virtual_roots_reply(x0 : Pointer(EwmhConnection), x1 : GetPropertyCookie, x2 : Pointer(EwmhGetWindowsReply), x3 : Pointer(GenericError*)) : UInt8

	fun xcb_ewmh_set_desktop_layout(x0 : Pointer(EwmhConnection), x1 : Int32, x2 : UInt32, x3 : UInt32, x4 : UInt32, x5 : UInt32) : VoidCookie 

	fun xcb_ewmh_set_desktop_layout_checked(x0 : Pointer(EwmhConnection), x1 : Int32, x2 : UInt32, x3 : UInt32, x4 : UInt32, x5 : UInt32) : VoidCookie 

	fun xcb_ewmh_get_desktop_layout_unchecked(x0 : Pointer(EwmhConnection), x1 : Int32) : GetPropertyCookie 

	fun xcb_ewmh_get_desktop_layout(x0 : Pointer(EwmhConnection), x1 : Int32) : GetPropertyCookie 

	fun xcb_ewmh_get_desktop_layout_from_reply(x0 : Pointer(EwmhGetDesktopLayoutReply), x1 : Pointer(GetPropertyReply)) : UInt8 

	fun xcb_ewmh_set_showing_desktop(x0 : Pointer(EwmhConnection), x1 : Int32, x2 : UInt32) : VoidCookie 

	fun xcb_ewmh_set_showing_desktop_checked(x0 : EwmhConnection *, x1 : Int32, x2 : UInt32) : VoidCookie 

	fun xcb_ewmh_get_showing_desktop_unchecked(x0 : Pointer(EwmhConnection), x1 : Int32) : GetPropertyCookie 

	fun xcb_ewmh_get_showing_desktop(x0 : Pointer(EwmhConnection), x1 : Int32) : GetPropertyCookie 

	fun xcb_ewmh_get_showing_desktop_from_reply(x0 : Pointer(UInt32), x1 : Pointer(GetPropertyReply)) : UInt8 

	fun xcb_ewmh_get_showing_desktop_reply(x0 : Pointer(EwmhConnection), x1 : GetPropertyCookie, x2 : Pointer(UInt32), x3 : Pointer(GenericError*)) : UInt8

	fun xcb_ewmh_request_change_showing_desktop(x0 : Pointer(EwmhConnection), x1 : Int32, x2 : UInt32) : VoidCookie

	fun xcb_ewmh_request_close_window(x0 : Pointer(EwmhConnection), x1 : Int32, x2 : Window, x3 : Timestamp, x4 : UInt32) : VoidCookie 

	fun xcb_ewmh_request_moveresize_window(x0 : Pointer(EwmhConnection), x1 : Int32, x2 : Window, x3 : Gravity, x4 : UInt32, x5 : UInt32, x6 : UInt32, x7 : UInt32, x8 : UInt32, x9 : UInt32) : VoidCookie 

	fun xcb_ewmh_request_wm_moveresize(x0 : Pointer(EwmhConnection), x1 : Int32, x2 : Window, x3 : UInt32, x4 : UInt32, x5 : UInt32, x6 : UInt32, x7 : UInt32) : VoidCookie 

	fun xcb_ewmh_request_restack_window(x0 : Pointer(EwmhConnection), x1 : Int32, x2 : Window, x3 : Window, x4 : UInt32) : VoidCookie 

	fun xcb_ewmh_request_frame_extents(x0 : Pointer(EwmhConnection), x1 : Int32, x2 : Window) : VoidCookie

	fun xcb_ewmh_set_wm_name(x0 : Pointer(EwmhConnection), x1 : Window, x2 : UInt32, x3 : Pointer(Char)) : VoidCookie 

	fun xcb_ewmh_set_wm_name_checked(x0 : Pointer(EwmhConnection), x1 : Window, x2 : UInt32, x3 : Pointer(Char)) : VoidCookie 

	fun xcb_ewmh_get_wm_name_unchecked(x0 : Pointer(EwmhConnection), x1 : Window) : GetPropertyCookie 

	fun xcb_ewmh_get_wm_name(x0 : Pointer(EwmhConnection), x1 : Window) : GetPropertyCookie 

	fun xcb_ewmh_get_wm_name_from_reply(x0 : Pointer(EwmhConnection), x1 : Pointer(EwmhGetUTF8StringsReply), x2 : Pointer(GetPropertyReply)) : UInt8

	fun get_wm_name_reply(x0 : Pointer(EwmhConnection), x1 : GetPropertyCookie, x2 : Pointer(EwmhGetUTF8StringsReply), x3 : Pointer(GenericError*)) : UInt8

	fun set_wm_visible_name(x0 : Pointer(EwmhConnection), x1 : Window, x2 : UInt32, x3 : Pointer(Char)) : VoidCookie 

	fun xcb_ewmh_set_wm_visible_name_checked(x0 : Pointer(EwmhConnection), x1 : Window, x2 : UInt32, x3 : Pointer(Char)) : VoidCookie 

	fun xcb_ewmh_get_wm_visible_name_unchecked(x0 : Pointer(EwmhConnection), x1 : Window) : GetPropertyCookie 

	fun xcb_ewmh_get_wm_visible_name(x0 : Pointer(EwmhConnection), x1 : Window) : GetPropertyCookie 

	fun xcb_ewmh_get_wm_visible_name_from_reply(x0 : Pointer(EwmhConnection), x1 : Pointer(EwmhGetUTF8StringsReply), x2 : Pointer(GetPropertyReply)) : UInt8

	fun xcb_ewmh_get_wm_visible_name_reply(x0 : Pointer(EwmhConnection), x1 : GetPropertyCookie, x2 : Pointer(EwmhGetUTF8StringsReply), x3 : Pointer(GenericError*)) : UInt8

	fun xcb_ewmh_set_wm_icon_name(x0 : Pointer(EwmhConnection), x1 : Window, x2 : UInt32, x3 : Pointer(Char)) : VoidCookie 

	fun xcb_ewmh_set_wm_icon_name_checked(x0 : Pointer(EwmhConnection), x1 : Window, x2 : UInt32, x3 : Pointer(Char)) : VoidCookie 

	fun get_wm_icon_name_unchecked(x0 : Pointer(EwmhConnection), x1 : Window) : GetPropertyCookie 

	fun xcb_ewmh_get_wm_icon_name(x0 : Pointer(EwmhConnection), x1 : Window) : GetPropertyCookie 

	fun xcb_ewmh_get_wm_icon_name_from_reply(x0 : Pointer(EwmhConnection), x1 : Pointer(EwmhGetUTF8StringsReply), x2 : Pointer(GetPropertyReply)) : UInt8

	fun xcb_ewmh_get_wm_icon_name_reply(x0 : Pointer(EwmhConnection), x1 : GetPropertyCookie, x2 : Pointer(EwmhGetUTF8StringsReply), x3 : Pointer(GenericError*)) : UInt8

	fun xcb_ewmh_set_wm_visible_icon_name(x0 : Pointer(EwmhConnection), x1 : Window, x2 : UInt32, x3 : Pointer(Char)) : VoidCookie

	fun xcb_ewmh_set_wm_visible_icon_name_checked(x0 : Pointer(EwmhConnection), x1 : Window, x2 : UInt32, x3 : Pointer(Char)) : VoidCookie 

	fun xcb_ewmh_get_wm_visible_icon_name_unchecked(x0 : Pointer(EwmhConnection), x1 : Window) : GetPropertyCookie

	fun xcb_ewmh_get_wm_visible_icon_name(x0 : Pointer(EwmhConnection), x1 : Window) : GetPropertyCookie 

	fun xcb_ewmh_get_wm_visible_icon_name_from_reply(x0 : Pointer(EwmhConnection), x1 : Pointer(EwmhGetUTF8StringsReply), x2 : Pointer(GetPropertyReply)) : UInt8

	fun xcb_ewmh_get_wm_visible_icon_name_reply(x0 : Pointer(EwmhConnection), x1 : GetPropertyCookie, x2 : Pointer(EwmhGetUTF8StringsReply), x3 : Pointer(GenericError*)) : UInt8

	fun xcb_ewmh_set_wm_desktop(x0 : Pointer(EwmhConnection), x1 : Window, x2 : UInt32) : VoidCookie 

	fun xcb_ewmh_set_wm_desktop_checked(x0 : Pointer(EwmhConnection), x1 : Window, x2 : UInt32) : VoidCookie 

	fun xcb_ewmh_get_wm_desktop_unchecked(x0 : Pointer(EwmhConnection), x1 : Window) : GetPropertyCookie 

	fun xcb_ewmh_get_wm_desktop(x0 : Pointer(EwmhConnection), x1 : Window) : GetPropertyCookie 

	fun xcb_ewmh_get_wm_desktop_from_reply(x0 : UInt32, x1 : Pointer(GetPropertyReply)) : UInt8

	fun xcb_ewmh_get_wm_desktop_reply(Pointer(EwmhConnection), GetPropertyCookie, Pointer(UInt32), Pointer(GenericError*)) : UInt8

	fun xcb_ewmh_request_change_wm_desktop(x0 : Pointer(EwmhConnection), x1 : Int32, x2 : Window, x3 : UInt32, x4 : UInt32) : VoidCookie 

	fun xcb_ewmh_set_wm_window_type(x0 : Pointer(EwmhConnection), x1 : Window, x2 : UInt32, x3 : Pointer(Atom)) : VoidCookie 

	fun xcb_ewmh_set_wm_window_type_checked(x0 : Pointer(EwmhConnection), x1 : Window, x2 : UInt32, x3 : Pointer(Atom)) : VoidCookie 

	fun xcb_ewmh_get_wm_windowtype_unchecked(x0 : Pointer(EwmhConnection), x1 : Window) : GetPropertyCookie 

	fun xcb_ewmh_get_wm_windowtype(x0 : Pointer(EwmhConnection), x1 : Window) : GetPropertyCookie 

	fun xcb_ewmh_get_wm_windowtype_from_reply(x0 : Pointer(EwmhGetAtomsReply), x1 : Pointer(GetPropertyReply)) : UInt8 

	fun xcb_ewmh_get_wm_windowtype_reply(x0 : Pointer(EwmhConnection), x1 : GetPropertyCookie, x2 : Pointer(EwmhGetAtomsReply), x3 : Pointer(GenericError*)) : UInt8 

	fun xcb_ewmh_set_wm_state(x0 : Pointer(EwmhConnection), x1 : Window, x2 : UInt32, x3 : Pointer(Atom)) : VoidCookie 

	fun xcb_ewmh_set_wm_state_checked(x0 : Pointer(EwmhConnection), x1 : Window, x2 : UInt32, x3 : Pointer(Atom)) : VoidCookie 

	fun xcb_ewmh_get_wm_state_unchecked(x0 : Pointer(EwmhConnection), x1 : Window) : GetPropertyCookie 

	fun xcb_ewmh_get_wm_state(x0 : Pointer(EwmhConnection), x1 : Window) : GetPropertyCookie 

	fun xcb_ewmh_get_wm_state_from_reply(x0 : Pointer(EwmhGetAtomsReply), x1 : Pointer(GetPropertyReply)) : UInt8 

	fun xcb_ewmh_get_wm_state_reply(x0 : Pointer(EwmhConnection), x1 : GetPropertyCookie, x2 : Pointer(EwmhGetAtomsReply), x3 : Pointer(GenericError*)) : UInt8 

	#	fun request_change_wm_state(x0 : Pointer(EwmhConnection), x1 : Int32, x2 : Window, x3 : EwmhWMStateAction, x4 : Atom, x5 : Atom, x6 : EwmhClientSourceType) : VoidCookie 

	fun xcb_ewmh_set_wm_allowed_actions(x0 : Pointer(EwmhConnection), x1 : Window, x2 : UInt32, x3 : Pointer(Atom)) : VoidCookie 

	fun xcb_ewmh_set_wm_allowed_actions_checked(x0 : Pointer(EwmhConnection), x1 : Window, x2 : UInt32, x3 : Atom) : VoidCookie 
	fun xcb_ewmh_get_wm_allowed_actions_unchecked(x0 : Pointer(EwmhConnection), x1 : Window) : GetPropertyCookie 

	fun xcb_ewmh_get_wm_allowed_actions(x0 : Pointer(EwmhConnection), x1: Window) : GetPropertyCookie 

	fun xcb_ewmh_get_wm_allowed_actions_from_reply(x0 : Pointer(EwmhGetAtomsReply), x1 : Pointer(GetPropertyReply)) : UInt8 

	fun xcb_ewmh_get_wm_allowed_actions_reply(x0 : Pointer(EwmhConnection), x1 : GetPropertyCookie, x2 : Pointer(EwmhGetAtomsReply), x3 : Pointer(GenericError*)) : GetPropertyCookie

	fun xcb_ewmh_set_wm_strut(x0 : Pointer(EwmhConnection), x1 : Window, x2 : UInt32, x3 : UInt32, x4 : UInt32, x5 : UInt32) : VoidCookie 

	fun xcb_ewmh_set_wm_strut_checked(x0 : Pointer(EwmhConnection), x1 : Window, x2 : UInt32, x3 : UInt32, x4 : UInt32, x5 : UInt32) : VoidCookie 

	fun xcb_ewmh_get_wm_strut_unchecked(x0 : Pointer(EwmhConnection), x1 : Window) : GetPropertyCookie 

	fun xcb_ewmh_get_wm_strut(x0 : Pointer(EwmhConnection), x1 : Window) : GetPropertyCookie 

	fun xcb_ewmh_get_wm_strut_from_reply(x0 : Pointer(EwmhGetExtentsReply), x1 : Pointer(GetPropertyReply)) : UInt8 

	fun xcb_ewmh_get_wm_strut_reply(x0 : Pointer(EwmhConnection), x1 : GetPropertyCookie, x2 : Pointer(EwmhGetExtentsReply), x3 : Pointer(GenericError*)) : UInt8 

	#	fun set_wm_strut_partial(x0 : Pointer(EwmhConnection), x1 : Window, x2 : EwmhWMStrutPartial) : VoidCookie 

	#	fun set_wm_strut_partial_checked(x0 : Pointer(EwmhConnection), x1 : Window, x2 : EwmhWMStrutPartial) : VoidCookie 

	fun xcb_ewmh_get_wm_strut_partial_unchecked(x0 : Pointer(EwmhConnection), x1 : Window) : GetPropertyCookie 

	fun xcb_ewmh_get_wm_strut_partial(x0 : Pointer(EwmhConnection), x1 : Window) : GetPropertyCookie 

	fun xcb_ewmh_get_wm_strut_partial_from_reply(x0 : Pointer(EwmhWMStrutPartial), x1 : Pointer(GetPropertyReply)) : UInt8 

	fun xcb_ewmh_get_wm_strut_partial_reply(x0 : Pointer(EwmhConnection), x1 : GetPropertyCookie, x2 : Pointer(EwmhWMStrutPartial), x3 : Pointer(GenericError*)) : UInt8 

	fun xcb_ewmh_set_wm_icon_geometry(x0 : Pointer(EwmhConnection), x1 : Window, x2 : UInt32, x3 : UInt32, x4 : UInt32, x5 : UInt32) : VoidCookie 

	fun xcb_ewmh_set_wm_icon_geometry_checked(x0 : Pointer(EwmhConnection), x1 : Window, x2 : UInt32, x3 : UInt32, x4 : UInt32, x5 : UInt32) : VoidCookie 

	fun xcb_ewmh_get_wm_icon_geometry_unchecked(x0 : Pointer(EwmhConnection), x1 : Window) : GetPropertyCookie 

	fun xcb_ewmh_get_wm_icon_geometry(x0 : Pointer(EwmhConnection), x1 : Window) : GetPropertyCookie 

	fun xcb_ewmh_get_wm_icon_geometry_from_reply(x0 : Pointer(EwmhGeometry), x1 : Pointer(GetPropertyReply)) : UInt8 

	fun xcb_ewmh_get_wm_icon_geometry_reply(x0 : Pointer(EwmhConnection), x1 : GetPropertyCookie, x2 : Pointer(EwmhGeometry), x3 : Pointer(GenericError*)) : UInt8 

	fun xcb_ewmh_set_wm_icon_checked(x0 : Pointer(EwmhConnection), x1 : UInt8, x2 : Window, x3 : UInt32, x4 : Pointer(UInt32)) : VoidCookie

	fun xcb_ewmh_set_wm_icon(x0 : Pointer(EwmhConnection), x1 : UInt8, x2 : Window, x3 : UInt32, x4 : Pointer(UInt32)) : VoidCookie

	fun xcb_ewmh_append_wm_icon_checked(x0 : Pointer(EwmhConnection), x1 : Window, x2 : UInt32, x3 : UInt32, x4 : UInt32, x5 : Pointer(UInt32)) : VoidCookie 

	fun xcb_ewmh_append_wm_icon(x0 : Pointer(EwmhConnection), x1 : Window, x2 : UInt32, x3 : UInt32, x4 : UInt32, x5 : Pointer(UInt32)) : VoidCookie 

	fun xcb_ewmh_get_wm_icon_unchecked(x0 : Pointer(EwmhConnection), x1 : Window) : GetPropertyCookie 

	fun xcb_ewmh_get_wm_icon(x0 : Pointer(EwmhConnection), x1 : Window) : GetPropertyCookie 

	fun xcb_ewmh_get_wm_icon_from_reply(x0 : Pointer(EwmhGetWMIconReply), x1 : Pointer(GetPropertyReply)) : UInt8 

	fun xcb_ewmh_get_wm_icon_reply(x0 : Pointer(EwmhConnection), x1 : GetPropertyCookie, x2 : Pointer(EwmhGetWMIconReply), x3 : Pointer(GenericError*)) : UInt8 

	fun xcb_ewmh_get_wm_icon_iterator(x0 : Pointer(EwmhGetWMIconReply)) : EwmhWMIconIterator 

	fun xcb_ewmh_get_wm_icon_length(x0 : Pointer(EwmhGetWMIconReply)) : UInt32

	fun xcb_ewmh_get_wm_icon_next(x0 : Pointer(EwmhWMIconIterator)) : Void

	fun xcb_ewmh_get_wm_icon_reply_wipe(x0 : Pointer(EwmhGetWMIconReply)) : Void

	fun xcb_ewmh_set_wm_pid(x0 : Pointer(EwmhConnection), x1 : Window, x2 : UInt32) : VoidCookie 

	fun xcb_ewmh_set_wm_pid_checked(x0 : Pointer(EwmhConnection), x1 : Window, x2 : UInt32) : VoidCookie 

	fun xcb_ewmh_get_wm_pid_unchecked(x0 : Pointer(EwmhConnection), x1 : Window) : GetPropertyCookie 

	fun xcb_ewmh_get_wm_pid(x0 : Pointer(EwmhConnection), x1 : Window) : GetPropertyCookie 

	fun xcb_ewmh_get_wm_pid_from_reply(x0 : Pointer(UInt32), x1 : Pointer(GetPropertyReply)) : UInt8

	fun xcb_ewmh_get_wm_pid_reply(x0 : Pointer(EwmhConnection), x1 : GetPropertyCookie, x2 : Pointer(UInt32), x3 : Pointer(GenericError*)) : UInt8

	fun xcb_ewmh_set_wm_handled_icons(x0 : Pointer(EwmhConnection), x1 : Window, x2 : UInt32) : VoidCookie 

	fun xcb_ewmh_set_wm_handled_icons_checked(x0 : Pointer(EwmhConnection), x1 : Window, x2 : UInt32) : VoidCookie 

	fun xcb_ewmh_get_wm_handled_icons_unchecked(x0 : Pointer(EwmhConnection), x1 : Window) : GetPropertyCookie 

	fun xcb_ewmh_get_wm_handled_icons(x0 : Pointer(EwmhConnection), x1 : Window) : GetPropertyCookie 

	fun xcb_ewmh_get_wm_handled_icons_from_reply(x0 : Pointer(UInt32), x1 : Pointer(GetPropertyReply)) : UInt8

	fun xcb_ewmh_get_wm_handled_icons_reply(x0 : Pointer(EwmhConnection), x1 : GetPropertyCookie, x2 : UInt32, x3 : Pointer(GenericError*)) : UInt8

	fun xcb_ewmh_set_wm_userime(x0 : Pointer(EwmhConnection), x1 : Window, x2 : UInt32) : VoidCookie 

	fun xcb_ewmh_set_wm_userime_checked(x0 : Pointer(EwmhConnection), x1 : Window, x2 : UInt32) : VoidCookie 

	fun xcb_ewmh_get_wm_userime_unchecked(x0 : Pointer(EwmhConnection), x1 : Window) : GetPropertyCookie 

	fun xcb_ewmh_get_wm_userime(x0 : Pointer(EwmhConnection), x1 : Window) : GetPropertyCookie 

	fun xcb_ewmh_get_wm_userime_from_reply(x0 : Pointer(UInt32), x1 : Pointer(GetPropertyReply)) : UInt8

	fun xcb_ewmh_get_wm_userime_reply(x0 : Pointer(EwmhConnection), x1 : GetPropertyCookie, x2 : Pointer(UInt32), x3 : Pointer(GenericError*)) : UInt8

	fun xcb_ewmh_set_wm_userime_window(x0 : Pointer(EwmhConnection), x1 : Window, x2 : UInt32) : VoidCookie 

	fun xcb_ewmh_set_wm_userime_window_checked(x0 : Pointer(EwmhConnection), x1 : Window, x2 : UInt32) : VoidCookie 

	fun xcb_ewmh_get_wm_userime_window_unchecked(x0 : Pointer(EwmhConnection), x1 : Window) : GetPropertyCookie 

	fun xcb_ewmh_get_wm_userime_window(x0 : Pointer(EwmhConnection), x1 : Window) : GetPropertyCookie 

	fun xcb_ewmh_get_wm_userime_window_from_reply(x0 : Pointer(UInt32), x1 : Pointer(GetPropertyReply)) : UInt8

	fun xcb_ewmh_get_wm_userime_window_reply(Pointer(EwmhConnection), GetPropertyCookie, Pointer(UInt32), Pointer(GenericError*)) : UInt8

	fun xcb_ewmh_set_ewmh_frame_extents(x0 : Pointer(EwmhConnection), x1 : Window, x2 : UInt32, x3 : UInt32, x4 : UInt32, x5 : UInt32) : VoidCookie 

	fun xcb_ewmh_set_frame_extents_checked(x0 : Pointer(EwmhConnection), x1 : Window, x2 : UInt32, x3 : UInt32, x4 : UInt32, x5 : UInt32) : VoidCookie 

	fun xcb_ewmh_get_frame_extents_unchecked(x0 : Pointer(EwmhConnection), x1 : Window) : GetPropertyCookie 

	fun xcb_ewmh_get_frame_extents(x0 : Pointer(EwmhConnection), x1 : Window) : GetPropertyCookie 

	fun xcb_ewmh_get_frame_extents_from_reply(x0 : Pointer(EwmhGetExtentsReply), x1 : Pointer(GetPropertyReply)) : UInt8 

	fun get_ewmh_frame_extents_reply(x0 : Pointer(EwmhConnection), x1 : GetPropertyCookie, x2 : Pointer(EwmhGetExtentsReply), x3 : Pointer(GenericError*)) : UInt8 

	fun xcb_ewmh_send_wm_ping(x0 : Pointer(EwmhConnection), x1 : Window, x2 : Timestamp) : VoidCookie 

	fun xcb_ewmh_set_wm_sync_request_counter(x0 : Pointer(EwmhConnection), x1 : Window, x2 : Atom, x3 : UInt32, x4 : UInt32) : VoidCookie 

	fun xcb_ewmh_set_wm_sync_request_counter_checked(x0 : Pointer(EwmhConnection), x1 : Window, x2 : Atom, x3 : UInt32, x4 : UInt32) : VoidCookie 

	fun xcb_ewmh_get_wm_sync_request_counter_unchecked(x0 : Pointer(EwmhConnection), x1 : Window) : GetPropertyCookie 

	fun xcb_ewmh_get_wm_sync_request_counter(x0 : Pointer(EwmhConnection), x1 : Window) : GetPropertyCookie 

	fun xcb_ewmh_get_wm_sync_request_counter_from_reply(x0 : Pointer(UInt64), x1 : Pointer(GetPropertyReply)) : UInt8 

	fun xcb_ewmh_get_wm_sync_request_counter_reply(x0 : Pointer(EwmhConnection), x1 : GetPropertyCookie, x2 : Pointer(UInt64), x3 : Pointer(GenericError*)) : UInt8 

	fun xcb_ewmh_send_wm_sync_request(x0 : Pointer(EwmhConnection), x1 : Window, x2 : Atom, x3 : Atom, x4 : Timestamp, x5 : UInt64) : VoidCookie 

	fun xcb_ewmh_set_wm_fullscreen_monitors(x0 : Pointer(EwmhConnection), x1 : Window, x2 : UInt32, x3 : UInt32, x4 : UInt32, x5 : UInt32) : VoidCookie 

	fun xcb_ewmh_set_wm_fullscreen_monitors_checked(x0 : Pointer(EwmhConnection), x1 : Window, x2 : UInt32, x3 : UInt32, x4 : UInt32, x5 : UInt32) : VoidCookie 

	fun xcb_ewmh_get_wm_fullscreen_monitors_unchecked(x0 : EwmhConnection, x1 : Window) : GetPropertyCookie 

	fun xcb_ewmh_get_wm_fullscreen_monitors(x0 : Pointer(EwmhConnection), x1 : Window) : GetPropertyCookie 

	fun xcb_ewmh_get_wm_fullscreen_monitors_from_reply(x0 : Pointer(EwmhGetWMFullscreenMonitorsReply), x1 : Pointer(GetPropertyReply)) : UInt8 

	fun xcb_ewmh_get_wm_fullscreen_monitors_reply(x0 : Pointer(EwmhConnection), x1 : GetPropertyCookie, x2 : Pointer(EwmhGetWMFullscreenMonitorsReply), x3 : Pointer(GenericError*)) : UInt8 

	fun xcb_ewmh_request_change_wm_fullscreen_monitors(x0 : Pointer(EwmhConnection), x1 : Int32, x2 : Window, x3 : UInt32, x4 : UInt32, x5 : UInt32, x6 : UInt32, x7 : UInt32) : VoidCookie 

	fun xcb_ewmh_set_wm_cm_owner(x0 : Pointer(EwmhConnection), x1 : Int32, x2 : Window, x3 : Timestamp, x4 : UInt32, x5 : UInt32) : VoidCookie 

	fun xcb_ewmh_set_wm_cm_owner_checked(x0 : Pointer(EwmhConnection), x1 : Int32, x2 : Window, x3 : Timestamp, x4 : UInt32, x5 : UInt32) : VoidCookie 

	fun xcb_ewmh_get_wm_cm_owner_unchecked(x0 : Pointer(EwmhConnection), x1 : Int32) : GetSelectionOwnerCookie 

	fun xcb_ewmh_get_wm_cm_owner(x0 : Pointer(EwmhConnection), x1 : Int32) : GetSelectionOwnerCookie 

	fun xcb_ewmh_get_wm_cm_owner_from_reply(x0 : Pointer(Window), x1 : Pointer(GetSelectionOwnerReply)) : UInt8 

	fun xcb_ewmh_get_wm_cm_owner_reply(x0 : Pointer(EwmhConnection), x1 : GetSelectionOwnerCookie, x2 : Pointer(Window), x3 : Pointer(GenericError*)) : UInt8 
end 
