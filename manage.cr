def match_depth(win, con)
	old_frame = XCB_NONE

	if con.depth != win.depth
		old_frame = con.frame.id
		con.depth = win.depth
		x_con_reframe con
	end

	old_frame
end

def remove_matches(con)
	until con.swallow_head.empty?
		first = con.swallowhead[0]
		con.swallowhead.pop(first)
	end
end

def manage_existing_windows(root)
	return if !reply = xcb_query_tree_reply(conn, xcb_query_tree(conn, root), 0)

	children = xcb_query_tree_children(reply)
	len = xcb_query_tree_children_length(reply)
	len.times do |i|
		cookies[i] = xcb_get_window_attributes(conn, children[i])
	end
	len.times do |i|
		manage_window(children[i], cookies[i], true)
	end
end

def restore_geometry
	puts "Restoring geometry"

	all_cons.each do |con|
		if con.window
			puts "Re-adding X11 border of #{con.border_width}"
			con.window_rect.width += (2 * con.border_width)
			con.window_rect.height += (2 * con.border_width)
			xcb_set_window_rect(conn, con.window.id, con.window_rect)

			puts "Placing window #{con.window.id} at #{window.rect.x} #{window.rect.y}"
			xcb_reparent_window(con, con.window.id, root, con.rect.x, con.rect.y)
		end
	end

	xcb_change_window_attributes(conn, root, XCB_EVENT_MASK, [XCB_EVENT_MASK_SUBSTRUCTURE_REDIRECT])
	xcb_aux_sync conn
end

def manage_window(window, cookie, needs_to_be_mapped)
	puts "window #{window}"
	d = [window]
	geomc = xcb_get_geometry(conn, d)

	if !attr = xcb_get_window_attributes_reply(conn, cookie, 0)
		puts "Could not get attributes"
		xcb_discard_reply(conn, geomc.sequence)
		return
	end

	if needs_to_be_mapped && attr.map_state != XCB_MAP_STATE_VIEWABLE
		puts "Could not get attributes"
		xcb_discard_reply(conn, geomc.sequence)
		return
	end

	if attr.override_redirect
		xcb_discard_reply(conn, geomc.sequence)
		return
	end

	if con_by_window_id(window)
		puts "Already managed (by #{con_by_window_id(window)})"
		xcb_discard_reply(conn, geomc.sequence)
		return
	end

	if !geom = xcb_get_geometry_reply(conn, geomc, 0)
		puts "Could not get geometry"
		return
	end

	values = [XCB_EVENT_MASK_PROPERTY_CHANGE | XCB_EVENT_MASK_STRUCTURE_NOTIFY].as(Array(UInt32))
	event_mask_cookie = xcb_change_window_attributes(conn, window, XCB_CW_EVENT_MASK, values)
	if xcb_request_check(conn, event_mask_cookie)
		puts "Could not change event mask, the window probably already disappeared"
		return
	end

	xcb_get_property(conn, false, window, NetWmWindowType, XCB_PROPERTY_TYPE_ANY, 0, max(UInt32))
	xcb_get_property(conn, false, window, NetWmStrutPartial, XCB_PROPERTY_TYPE_ANY, 0, max(UInt32))
	xcb_get_property(conn, false, window, NetWmState, XCB_PROPERTY_TYPE_ANY, 0, max(UInt32))
	xcb_get_property(conn, false, window, NetWmName, XCB_PROPERTY_TYPE_ANY, 0, 128)
	xcb_get_property(conn, false, window, NetWmClientLeader, XCB_PROPERTY_TYPE_ANY, 0, max(UInt32))
	xcb_get_property(conn, false, window, XCB_ATOM_WM_TRANSIENT_FOR, XCB_PROPERTY_TYPE_ANY, 0, max(UInt32))
	xcb_get_property(conn, false, window, XCB_ATOM_WM_NAME, XCB_PROPERTY_TYPE_ANY, 0, 128)
	xcb_get_property(conn, false, window, XCB_ATOM_WM_CLASS, XCB_PROPERTY_TYPE_ANY, 0, 128)
	xcb_get_property(conn, false, window, WmWindowRole, XCB_PROPERTY_TYPE_ANY, 0, 128)
	xcb_get_property(conn, false, window, NetStartupId, XCB_PROPERTY_TYPE_ANY, 0, 512)
	xcb_get_property(conn, false, window, MotifWmHints, XCB_PROPERTY_TYPE_ANY, 0, 128)
	xcb_get_property(conn, false, window, NetWmUserTime, XCB_PROPERTY_TYPE_ANY, 0, max(UInt32)
									xcb_get_property(conn, false, window, NetWmDesktop, XCB_PROPERTY_TYPE_ANY, 0, max(UInt32)
													xcb_get_property(conn, false, window, XCB_ATOM_WM_CLIENT_MACHINE, XCB_PROPERTY_TYPE_ANY, 0, max(UInt32)
															xcb_get_property(conn, false, window, NetWmIcon, XCB_PROPERTY_TYPE_ANY, 0, max(UInt32))
end
