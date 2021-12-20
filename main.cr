require "./**"

conn_screen = uninitialized Int32
conn = Pointer(LibXCB::Connection)
xcb_xkb_id = uninitialized LibXCB::Extension
xcb_shape_id = uninitialized LibXCB::Extension
xcb_big_requests_id = uninitialized LibXCB::Extension
xcb_randr_id = uninitialized LibXCB::Extension

conn = LibXCB.xcb_connect(nil, pointerof(conn_screen))
if LibXCB.xcb_connection_has_error(conn)
	puts "Cannot open display"
	exit
end

root_screen = LibXCB.xcb_aux_get_screen(conn, conn_screen)
root_screen_ = root_screen.value
root = root_screen_.root

LibXCB.xcb_prefetch_extension_data(conn, pointerof(xcb_xkb_id))
LibXCB.xcb_prefetch_extension_data(conn, pointerof(xcb_shape_id))
LibXCB.xcb_prefetch_extension_data(conn, pointerof(xcb_big_requests_id))
LibXCB.xcb_prefetch_extension_data(conn, pointerof(xcb_randr_id))

LibXCB.xcb_change_window_attributes(conn, root, LibXCB::XCB_CW_EVENT_MASK, [LibXCB::XCB_EVENT_MASK_PROPERTY_CHANGE])

macro init_atoms(names)
	{% for key, value in names %}
		{{key}} = LibXCB.xcb_intern_atom(conn, 0, {{value}}.size, {{value}})
	{% end %}
	supported_atoms = [
	{% for key in names %}
		{{key}},
	{% end %}
	]
end

init_atoms({NetSupported => "_NET_SUPPORTED",
		  NetSupportingWmCheck => "_NET_SUPPORTING_WM_CHECK",
		  NetStartupId => "_NET_STARTUP_ID",
			NetClientList => "_NET_CLIENT_LIST",
			NetClientListStacking => "_NET_CLIENT_LIST_STACKING",
		  NetNumberOfDesktops => "_NET_NUMBER_OF_DESKTOPS",
			NetDesktopNames => "_NET_DESKTOP_NAMES",
			NetActiveWindow => "_NET_ACTIVE_WINDOW",
			NetCloseWindow => "_NET_CLOSE_WINDOW",
			NetFrameExtents => "_NET_FRAME_EXTENTS",
			NetWmName => "_NET_WM_NAME",
			NetWmStrutPartial => "_NET_WM_STRUT_PARTIAL",
			NetWmIconName => "_NET_WM_ICON_NAME",
			NetWmVisibleIconName => "_NET_WM_VISIBLE_ICON_NAME",
			NetWmDesktop => "_NET_WM_DESKTOP",
			NetWMWindowTypeDesktop => "_NET_WM_WINDOW_TYPE_DESKTOP",
			NetWmWindowTypeDock => "_NET_WM_WINDOW_TYPE_DOCK",
			NetWmWindowTypeToolbar => "_NET_WM_WINDOW_TYPE_TOOLBAR",
			NetWmWindowTypeMenu => "_NET_WM_WINDOW_TYPE_MENU",
			NetWmWindowTypeUtility => "_NET_WM_WINDOW_TYPE_UTILITY",
			NetWmWindowTypeSplash => "_NET_WM_WINDOW_TYPE_SPLASH",
			NetWmWindowTypeDialog => "_NET_WM_WINDOW_TYPE_DIALOG",
			NetWmWindowTypeDropdownMenu => "_NET_WM_WINDOW_TYPE_DROPDOWN_MENU",
			NetWmWindowTypePopupMenu => "_NET_WM_WINDOW_TYPE_POPUP_MENU",
			NetWmWindowTypeTooltip => "_NET_WM_WINDOW_TYPE_TOOLTIP",
			NetWmWindowTypeNotification => "_NET_WM_WINDOW_TYPE_NOTIFICATION",
			NetWmWindowTypeCombo => "_NET_WM_WINDOW_TYPE_COMBO",
			NetWmWindowTypeDND => "_NET_WM_WINDOW_TYPE_DND",
			NetWmWindowTypeNormal => "_NET_WM_WINDOW_TYPE_NORMAL",
			NetWmIcon => "_NET_WM_ICON",
			NetWmPid => "_NET_WM_PID",
			NetWmState => "_NET_WM_STATE",
			NetWmStateSticky => "_NET_WM_STATE_STICKY",
			NetWmStateSticky => "_NET_WM_STATE_SKIP_TASKBAR",
			NetWmStateFullscreen => "_NET_WM_STATE_FULLSCREEN",
			NetWmStateMaximizedHorz => "_NET_WM_STATE_MAXIMIZED_HORZ",
			NetWmStateMaximizedVert => "_NET_WM_STATE_MAXIMIZED_VERT",
			NetWmStateAbove => "_NET_WM_STATE_ABOVE",
			NetWmStateBelow => "_NET_WM_STATE_BELOW",
			NetWmStateModal => "_NET_WM_STATE_MODAL",
			NetWmStateHidden => "_NET_WM_STATE_HIDDEN",
			NetWmStateDemandsAttention => "_NET_WM_STATE_DEMANDS_ATTENTION"})

xcb_change_property(conn, XCB_PROP_MODE_REPLACE, root, NetSupported, XCB_ATOM_ATOM, 32, XCB_ATOM_ATOM, 32, supported_atoms.size, supported_atoms)

root_depth = root_screen_.root_depth
colormap = root_screen_.default_colormap
if visual_type = LibXCB.xcb_aux_find_visual_by_attrs(root_screen, -1, 32)
	visual_type_ = visual_type.value
	root_depth = LibXCB.xcb_aux_get_depth_of_visual(root_screen, visual_type_.visual_id)
	colormap = LibXCB.xcb_generate_id(conn)

	cm_cookie = LibXCB.xcb_create_colormap_checked(conn, LibXCB::XCB_COLORMAP_ALLOC_NONE, colormap, root, visual_type_.visual_id)

	error = LibXCB.xcb_request_check(conn, cm_cookie)
else
end

LibXCB.xcb_prefetch_maximum_request_length(conn)

gcookie = LibXCB.xcb_get_geometry(conn, root)
pcookie = LibXCB.xcb_query_pointer(conn, root)
LibXCB.xcb_flush(conn)

while event = LibXCB.xcb_wait_for_event(conn).value
	if event.response_type == LibXCB::XCB_PROPERTY_NOTIFY
		break
	end
end

atom_name = LibXCB.xcb_atom_name_by_screen("WM_S".as(Char*), conn_screen)
wm_sn_selection_owner = LibXCB.xcb_generate_id(conn)
if !atom_name
	puts "xcb_atom_name_by_screen(\"WM_S\", #{conn_screen}) failed"
	exit
end

atom_reply = LibXCB.xcb_intern_atom_reply(conn, LibXCB.xcb_intern_atom(conn, 0, atom_name.as(String).size, atom_name), nil)
atom_reply_ = atom_reply.value
wm_sn = atom_reply_.atom

selection_reply = LibXCB.xcb_get_selection_owner_reply(conn, LibXCB.xcb_get_selection_owner(conn, wm_sn), nil)
selection_reply_ = selection_reply.value
if selection_reply_ && selection_reply_.owner != LibXCB::XCB_NONE
	puts "Another window manager is already running (WM_Sn is owned)"
	exit
end

LibXCB.xcb_create_window(conn, root_screen_.root_depth, wm_sn_selection_owner, root_screen_.root, -1, -1, 1, 1, 0, LibXCB::XCB_WINDOW_CLASS_INPUT_OUTPUT, root_screen_.root_visual, 0, nil)
LibXCB.xcb_change_property(conn, LibXCB::XCB_PROP_MODE_REPLACE, wm_sn_selection_owner, LibXCB::XCB_ATOM_WM_CLASS, LibXCB::XCB_ATOM_STRING, 8, ("i3-WM_Sn".as(String).size + 1) * 2, "i3-WM_Sn\0i3-WM_Sn\0")

if selection_reply && selection_reply_.owner != LibXCB::XCB_NONE
	usleep_time = 100000
	check_rounds = 150
	loop do
		#sleep(usleep_time)
		geom_reply = LibXCB.xcb_get_geometry_reply(conn, LibXCB.xcb_get_geometry(conn, selection_reply_.owner), nil)
		if geom_reply
			break
		end
	end
end

event = ClientMessageEvent.new(response_type: XCB_CLIENT_MESSAGE, window: root_screen_.root, format: 32, type: A_MANAGER, data.data32: [last_timestamp, wm_sn, wm_sn_selection_owner])
LibXCB.send_event(conn, 0, window, XCB_EVENT_MASK_NO_EVENT, pointerof(event).as(LibC::Char*))

cookie = LibXCB.xcb_change_window_attributes_checked(conn, root, LibXCB::XCB_CW_EVENT_MASK, [LibXCB::XCB_EVENT_MASK_SUBSTRUCTURE_REDIRECT | LibXCB::XCB_EVENT_MASK_BUTTON_PRESS | LibXCB::XCB_EVENT_MASK_STRUCTURE_NOTIFY | LibXCB::XCB_EVENT_MASK_POINTER_MOTION | LibXCB::XCB_EVENT_MASK_PROPERTY_CHANGE | LibXCB::XCB_EVENT_MASK_FOCUS_CHANGE | LibXCB::XCB_EVENT_MASK_ENTER_WINDOW])
if error = LibXCB.xcb_request_check(conn, cookie)
	puts "Another window manager seems to be running (X error #{error.value.error_code})"
	exit
end

greply = LibXCB.xcb_get_geometry_reply(conn, gcookie, nil)
if !greply
	puts "Could not get geometry of the root windw, exiting"
	exit
end

cursors = ["left_ptr", "sb_h_double_arrow", "sb_v_double_arrow", "watch", "fleur", "top_left_corner", "top_right_corner", "bottom_left_corner", "bottom_right_corner"]

LibXCB.xcb_change_window_attributes(conn, root, LibXCB::XCB_CW_CURSOR, "left_ptr")

extreply = LibXCB.xcb_get_extension_data(conn, pointerof(xcb_xkb_id))
extreply_ = extreply.value
xkb_supported = extreply_.present
if extreply_.present
	puts "xkb is not present on this server"
else
	LibXCB.xcb_xkb_use_extension(conn, LibXCB::XCB_XKB_MAJOR_VERSION, LibXCB::XCB_XKB_MINOR_VERSION)
	LibXCB.xcb_xkb_select_events(conn, conn, LibXCB::XCB_XKB_ID_USE_CORE_KBD,LibXCB::XCB_XKB_EVENT_TYPE_STATE_NOTIFY | LibXCB::XCB_XKB_EVENT_TYPE_MAP_NOTIFY | LibXCB::XCB_XKB_EVENT_TYPE_NEW_KEYBOARD_NOTIFY, 0, LibXCB::XCB_XKB_EVENT_TYPE_STATE_NOTIFY | LibXCB::XCB_XKB_EVENT_TYPE_MAP_NOTIFY | LibXCB::XCB_XKB_EVENT_TYPE_NEW_KEYBOARD_NOTIFY, 0xff, 0xff, nil)
	mask = LibXCB::XCB_XKB_PER_CLIENT_FLAG_GRABS_USE_XKB_STATE | LibXCB::XCB_XKB_PER_CLIENT_FLAG_LOOKUP_STATE_WHEN_GRABBED | LibXCB::XCB_XKB_PER_CLIENT_FLAG_DETECTABLE_AUTO_REPEAT
	pcf_reply = xcb_xkb_per_client_flags_reply(conn, xcb_xkb_per_client_flags(conn, LibXCB::XCB_XKB_ID_USE_CORE_KBD, mask, mask, 0, 0, 0), nil)

	xkb_base = extreply_.first_event
end

extreply = LibXCB.xcb_get_extension_data(conn, pointerof(xcb_shape_id))
if extreply.present
	shape_base = extreply.first_event
	cookie = LibXCB.xcb_shape_query_version(conn)
	version = LibXCB.xcb_shape_query_version_reply(conn, cookie, nil)
	shape_supported = version && version_minor >= 1
else
	shape_supported = false
end 

supported_atoms = [_NET_SUPPORTED,
									 _NET_SUPPORTING_WM_CHECK,
									 _NET_WM_NAME,
									 _NET_WM_VISIBLE_NAME,
									 _NET_WM_MOVERESIZE,
									 _NET_WM_STATE_FULLSCREEN,
									 _NET_WM_STATE_DEMANDS_ATTENTION,
									 _NET_WM_STATE_MODAL,
									 _NET_WM_STATE_HIDDEN,
									 _NET_WM_STATE_FOCUSED,
									 _NET_WM_STATE,
									 _NET_WM_WINDOW_TYPE,
									 _NET_WM_WINDOW_TYPE_NORMAL,
									 _NET_WM_WINDOW_TYPE_DOCK,
									 _NET_WM_WINDOW_TYPE_DIALOG,
									 _NET_WM_WINDOW_TYPE_UTILITY,
									 _NET_WM_WINDOW_TYPE_TOOLBAR,
									 _NET_WM_WINDOW_TYPE_SPLASH,
									 _NET_WM_WINDOW_TYPE_MENU,
									 _NET_WM_WINDOW_TYPE_DROPDOWN_MENU,
									 _NET_WM_WINDOW_TYPE_POPUP_MENU,
									 _NET_WM_WINDOW_TYPE_TOOLTIP,
									 _NET_WM_WINDOW_TYPE_NOTIFICATION,
									 _NET_WM_DESKTOP,
									 _NET_WM_STRUT_PARTIAL,
									 _NET_CLIENT_LIST,
									 _NET_CLIENT_LIST_STACKING,
									 _NET_CURRENT_DESKTOP,
									 _NET_NUMBER_OF_DESKTOPS,
									 _NET_DESKTOP_NAMES,
									 _NET_DESKTOP_VIEWPORT,
									 _NET_ACTIVE_WINDOW,
									 _NET_CLOSE_WINDOW,
									 _NET_MOVERESIZE_WINDOW]

ewmh_window = LibXCB.xcb_generate_id(conn)
LibXCB.xcb_create_window(conn, LibXCB::XCB_COPY_FROM_PARENT, ewmh_window, root, -1, -1, 1, 1, 0, LibXCB::XCB_WINDOW_CLASS_INPUT_ONLY, LibXCB::XCB_COPY_FROM_PARENT, LibXCB::XCB_CW_OVERRIDE_REDIRECT, [1])
LibXCB.xcb_change_property(conn, LibXCB::XCB_PROP_MODE_REPLACE, ewmh_window, NetSupportingWmCheck, LibXCB::XCB_ATOM_WINDOW, 32, 1, pointerof(ewmh))
LibXCB.xcb_change_property(conn, LibXCB::XCB_PROP_MODE_REPLACE, ewmh_window, NetWmName, LibXCB::XCB_ATOM_WINDOW, 8, "i3".size, "i3")
LibXCB.xcb_change_property(conn, LibXCB::XCB_PROP_MODE_REPLACE, root, NetSupportingWmCheck, LibXCB::XCB_ATOM_WINDOW, 32, 1, pointerof(ewmh_window))
LibXCB.xcb_change_property(conn, LibXCB::XCB_PROP_MODE_REPLACE, root, NetWmName, LibXCB::XCB_ATOM_WINDOW, 8, "i3".size, "i3")
LibXCB.xcb_change_property(conn, LibXCB::XCB_PROP_MODE_REPLACE, root, NetSupported, LibXCB::XCB_ATOM_ATOM, 32, sizeof(supported_atoms) / sizeof(LibXCB::Atom), supported_atoms)
LibXCB.xcb_map_window(conn, ewmh_window)
LibXCB.xcb_configure_window(conn, ewmh_window, LibXCB::XCB_CONFIG_WINDOW_STACK_MODE, [LibXCB::XCB_STACK_MODE_BELOW])
