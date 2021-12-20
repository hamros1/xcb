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

macro atom(xxx)
	atom_{{xxx}}_cookie = LibXCB.xcb_intern_atom(conn, 0, {{xxx}}.size, {{xxx}})
end

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
