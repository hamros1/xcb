require "./**"

conn_screen = uninitialized Int32
conn = LibXCB.xcb_connect(nil, pointerof(conn_screen))

root_screen = LibXCB.xcb_aux_get_screen(conn, conn_screen)

LibXCB.xcb_change_window_attributes(conn, root_screen.value.root, LibXCB::XCB_CW_EVENT_MASK, [LibXCB::XCB_EVENT_MASK_PROPERTY_CHANGE])
LibXCB.xcb_change_property(conn, LibXCB::XCB_PROP_MODE_APPEND, root_screen.value.root, LibXCB::XCB_ATOM_SUPERSCRIPT_X, LibXCB::XCB_ATOM_CARDINAL, 32, 0, "")

root_depth = root_screen.value.root_depth
colormap = root_screen.value.default_colormap
if visual_type = LibXCB.xcb_aux_find_visual_by_attrs(root_screen, -1, 32)
	root_depth = LibXCB.xcb_aux_get_depth_of_visual(root_screen, visual_type.value.visual_id)
	colormap = LibXCB.xcb_generate_id(conn)
	cm_cookie = LibXCB.xcb_create_colormap_checked(conn, LibXCB::XCB_COLORMAP_ALLOC_NONE, colormap, root_screen.value.root, visual_type.value.visual_id)
	error = LibXCB.xcb_request_check(conn, cm_cookie)
else
	visual_type = get_visualtype(root_screen)
end
