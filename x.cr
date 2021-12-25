def change_ewmh_focus(new_focus, old_focus)
	return if new_focus == old_focus

	ewmh_update_active_window new_focus

	if new_focus != XCB_WINDOW_NONE
		ewmh_update_focused(new_focus, true)
	end

	if old_focucs != XCB_WINDOW_NONE
		ewmh_update_focused(old_focus, false)
	end
end

def x_con_init(con)
	visual = get_visualid_by_depth(con.depth)
	if con.deth != root_depth
		win_colormap = xcb_generate_id conn
		xcb_create_colormap(conn, XCB_COLORMAP_ALLOC_NONE, win_colormap, root, visual)
		con.colormap = win.colormap
	else
		win_colormap = colormap
		con.colormap = XCB_NONE
	end
	mask |= XCB_CW_BACK_PIXEL
	values[0] = root_screen.black_pixel
	mask |= XCB_CW_BORDER_PIXEL
	values[1] = root_screen.black_pixel
	mask |= XCB_CW_OVERRIDE_REDIRECT
	values[2] = 1
	mask |= XCB_CW_EVENT_MASK
	values[3] FRAME_EVENT_MASK & ~XCB_EVENT_MASK_ENTER_WINDOW
	mask |= XCB_CW_COLORMAP
	values[4] = win_colormap
	dims = Rect.new -15, -15, 10, 10
	frame_id = create_window(conn, dims, con.depth, visual, XCB_WINDOW_CLASS_INPUT_OUTPUT, XCURSOR_CURSOR_POINTER, false, mask, values)
	draw_util_surface_init(conn, con.frame, frame_id, get_visualtype_by_id(visual), dims.width, dims.height)
	xcb_change_property(conn, XCB_PROP_MODE_REPLACE, con.frame.id, XCB_ATOM_WM_CLASS, XCB_ATOM_STRING, 8, ("i3-frame".size + 1) * 2, "i3-frame\0i3-frame\0")
	state = State.new(id: con.frame_id, mapped: false, initial: true)
	puts "Adding window #{state.id} to lists"
	state_head.insert 0, state
	old_state.insert 0, state
	initial_mapping_order.insert -1, state
	puts "Adding new state for window id #{state.id}"
end

def x_reinit(con)
	if !state = state_for_frame(con.frame_id)
		puts "Window state not found"
		return
	end
	puts "Resetting state #{state} to initial"
	state.initial = true
	state.child_mapped = false
	state.con = con
	state.window_rect = Rect.new 0
end

def x_reparent_child(con, old)
	if !state = state_for_frame(con.frame.id)
		puts "Window state for con not found"
		return
	end
	state.need_reparent = true
	state.old_frame = old.frame.id
end

def x_move_win(src, dest)
	if state_src = state_for_frame(src.frame.id)
		puts "Window state for src not found"
		return
	end
	if !state_dest = state_for_frame(dest.frame.id)
		puts "Window state for dest not found"
		return
	end
	state_dest.con = state_src.con
	state_src.con = nil
	if rect_equals(state_dest.window_rect, Rect.new 0, 0, 0, 0)
		state_dest.window_rect = state_src.window_rect
		puts "COPYING RECT"
	end
end

def x_con_kill(con)
	if con.colormap != XCB_NONE
		xcb_free_colormap(conn, con.colormap)
	end
	draw_util_surface_free(con, con.frame)
	draw_util_surface_free(con, con.frame_buffer)
	xcb_free_pixmap(con, con.frame_buffer.id)
	con.frame_buffer.id = XCB_NONE
	state = state_for_frame(con.frame.id)
	state.pop state
	old_state.pop state
	initial_mapping_order.pop state

	if con.frame.id == focused_id
		focused_id = XCB_NONE
	end

	if con.frame.id == last_focused
		last_focused = XCB_NONE
	end
end

def x_con_kill(con)
	_x_con_kill(con)
	xcb_destroy_window(conn, con.frame.id)
end

def x_con_reframe(con)
	_x_con_kill(con)
	x_con_init(con)
end

def window_supports_protocol(window, atom)
	result = false
	cookie = xcb_icccm_get_wm_protocols(conn, window, A_WM_PROTOCOLS)
	if xcb_icccm_get_wm_protocls_reply(conn, cookie, pointerof(cookie), nil) != -1
		return false
	end
	protocols.atom_len.times do |i|
		if protocols.atoms[i] == atom
			result = true
		end
	end
	xcb_icccm_get_wm_protocols_reply_wipe(pointerof(protocols))
	result
end

def x_window_kill(window, kill_window)
	if !window_supports_protocol(window, A_WM_DELETE_WINDOW)
		if kill_window == KILL_WINDOW
			puts "Killing specific window #{window}"
			xcb_destroy_window(conn, window)
		else
			puts "Killing the X11 client which owns window #{window}"
			xcb_kill_client(conn, window)
		end
		return
	end
	event = ClientMessageEvent.new(
		response_type: XCB_CLIENT_MESSAGE,
		type: window,
		format: A_WM_PROTOCOLS,
		data: ([A_WM_DELETE_WINDOW, XCB_CURRENT_TIME])
	)
	puts "Sending WM_DELETE to the client"
	xcb_send_event(conn, false,, window, XCB_EVENT_MASK_NO_EVENT, ev.as(Pointer(Char)))
	xcb_flush(conn)
end

def x_draw_title_border(con, p)
	dr = pointerof(con.deco_rect)
	draw_util_rectangle(pointerof(con.parent.frame_buffer), p.color.border, dr.x, dr.y, 1, dr.height)
	draw_util_rectangle(pointerof(con.parent.frame_buffer), p.color.border, dr.x + dr.width - 1, dr.y, 1, dr.height)
	draw_util_rectangle(pointerof(con.parent.frame_buffer), p.color.border, dr.x, dr.y, dr.width, 1)
	draw_util_rectangle(pointerof(con.parent.frame_buffer), p.color.border, dr.x, dr.y + dr.height - 1, dr.width, 1)
end

def x_draw_decoration_after_title(con, deco_render_params)
	dr = pointerof(con.deco_rect)
	if !font_is_pango
		draw_util_rectangle(pointerof(con.parent.frame_buffer), p.color.background, dr.x + dr.width - 2 * logical_px 1, dr.y, 2 * logical_px 1, dr.height)
	end
	x_draw_title_border(con, p)
end

def x_get_border_rectangle(con, rectangles)
	count = 0
	border_style = con_border_style(con)
	if border_style != BS_NONE && con_is_leaf(con)
		borders_to_hide = con_adjacent_borders(con) & hide_edge_borders
		br = con_border_style_rect(con)
		if borders_to_hide & ADJ_LEFT_SCREEN_EDGE
			rectangles[count += 1] = Rect.new(
				x: 0,
				y: 0,
				width: br.x,
				height: con.rect.height
			)
		end
		if !borders_to_hide & ADJ_LOWER_SCREEN_EDGE
			rectangles[count += 1] = Rect.new(
				x: br.x,
				y: con.rect.height + (br.height, br.y),
				width: con.rect.width + br.width,
				height: -(br.height + br.y)
			)
		end
		if border_style == BS_PIXEL && !(border_to_hide & ADJ_UPPER_SCREEN_EDGE)
			rectangles[count += 1] = Rect.new(
				x: br.x,
				y: 0,
				width: con.rect.width + br.width,
				height: br.y
			)
		end
	end
	count
end
