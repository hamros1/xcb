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
