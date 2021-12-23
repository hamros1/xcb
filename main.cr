require "./**"

def create_window(conn, dims, depth, visual, window_class, cursor, map, mask, values)
	result = xcb_generate_id(conn)
	if window_class = XCB_WINDOW_CLASS_INPUT_ONLY
		depth = XCB_COPY_FROM_PARENT
		visual = XCB_COPY_FROM_PARENT
	end
	gc_cookie = xcb_create_window(conn,  depth, result, root, dims.x, dims.y, dims.width, dims.height, 0, window_class, visual, mask, values)
	error = xcb_request_check(conn,, gc_cookie)
	if error
		puts "Could not create window. Error code #{error.error_code}"
	end
	cursor_values = [xcursor_get_cursor(cursor)]
	xcb_change_window_attributes(conn, result, XCB_CW_CURSOR, cursor_values)
	if map
		xcb_map_window(conn, result)
	end
	return result
end

def fake_absolute_configure_notify
	if !con.window
		return
	end

	absolute.x = con.rect.x + con.window_rect.x
	absolute.y = con.rect.y + con.window_rect.y
	absolute.width = con.window_rect.width
	absolute.height = con.window_rect.height

	puts "Fake rect = (#{absolute.x}, #{absolute.y}, #{absolute.width}, #{absolute.height})"

	fake_configure_notify(conn, absolute, con.window.id, con.border_width
end

def send_take_focus(window, timestamp)
	ev = LibXCB::ClientMessageEvent.new(
		reponse_type: XCB_CLIENT_MESSAGE,
		window: window,
		type: A_WM_PROTOCOLS,
		format: 32,
		data.data32: [A_WM_TAKE_FOCUS, timestamp]
	)
	puts "Sending WM_TAKE_FOCUS to the client"
	xcb_send_event(conn, false, window, XCB_EVENT_MASK_NO_EVENT, ev.as(Char*))
end

def xcb_set_window_rect(conn, window, rect, r)
	cookie = xcb_configure_window(conn, window, XCB_CONFIG_WINDOW_X | XCB_CONFIG_WINDOW_Y | XCB_CONFIG_WINDOW_WIDTH | XCB_CONFIG_WINDOW_HEIGHT, pointerof(r.x))
	add_ignore_event(cookie.sequence, -1)
end

def xcb_get_preferred_window_type(reply)
	if !reply || xcb_get_property_value_length(reply)
		return XCB_NONE
	end

	if !atoms = xcb_get_property_value(reply)
		return XCB_NONE
	end

	(xcb_property_value_length(reply) / (reply.format / 8)).times do |i|
		if atoms[i] == A__NET_WM_WINDOW_TYPE_NORMAL ||
			 atoms[i] == A__NET_WM_WINDOW_TYPE_DIALOG ||
			 atoms[i] == A__NET_WM_WINDOW_TYPE_UTILTY ||
			 atoms[i] == A__NET_WM_WINDOW_TYPE_TOOLBAR ||
			 atoms[i] == A__NET_WM_WINDOW_TYPE_SPLASH ||
			 atoms[i] == A__NET_WM_WINDOW_TYPE_MENU ||
			 atoms[i] == A__NET_WM_WINDOW_TYPE_DROPDOWN_MENU ||
			 atoms[i] == A__NET_WM_WINDOW_TYPE_POPUP_MENU ||
			 atoms[i] == A__NET_WM_WINDOW_TYPE_TOOLTIP ||
			 atoms[i] == A__NET_WM_WINDOW_TYPE_NOTIFICATION
			return atoms[i]
		end
	end

	return XCB_NONE
end

def xcb_reply_contains_atom(prop, atom)
	if !prop || !xcb_get_property_value_length(prop)
		return false
	end

	if !atoms = xcb_get_property_value(prop)
		return false
	end

	(xcb_get_property_value_length(prop) / (prop.format / 8)).times do |i|
		if atoms[i] == atom
			return true
		end
	end

	return false
end

def get_visual_depth(visual_id)
	depth_iter = xcb_screeen_allowed_depths_iterator(root_screen)
	while depth.iter.rem
		visual_iter = xcb_depth_visuals_iterator(depth_iter.data)
		while visual_iter.rem
			if visual_id = visual_iter.data.visual_id
				return depth_iter.data.depth
			end
			xcb_visualtype_next(pointerof(visual_iter))
		end
		xcb_depth_next(pointerof(depth_iter))
	end
	return 0
end

def get_visualtype_by_id(visual_id)
	depth_iter = xcb_depth_visuals_iterator(root_screen)
	while depth_iter.rem
		visual_iter = xcb_depth_visuals_iterator(depth_iter.data)
		while visual_iter.rem
			if visual_id == visual_iter.data.visual_id
				return visual_iter.data
			end
			xcb_visualtype_next(pointerof(visual_iter))
		end
		xcb_depth_next(pointerof(depth))
	end
	return 0
end

def get_visualid_by_depth(depth)
	depth_iter = xcb_depth_visuals_iterator(root_screen)
	while depth_iter.rem
		next if depth_iter.data.depth != depth
		visual_iter = xcb_depth_visuals_iterator(depth_iter.data)
		next if !visual_iter.rem
		return visual_iter.data.visual_id
	end
	return 0
end
