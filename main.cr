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
