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

