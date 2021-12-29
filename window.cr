

def window_resize(win, w, h)
end

def window_move_resize(win, x, y, w, h)
	values = [x, y, w, h]
	xcb_configure_window(conn, win, XCB_CONFIG_WINDOW_X_Y_WIDTH_HEIGHT, values)
end

def window_center(m, c)
	r = c.floating_rectangle
	a = m.rectangle
	if r.width > a.width
		r.x = a.x
	else
		r.x = a.x + (a.width - r.width)
	end
	if r.height > a.height
		r.y = a.y
	else
		r.y = (a.y + a.height - r.height) / 2
	end
	r.x -= c.border_width
	r.y -= c.border_width
end

def window_stack(w1, w2, mode)
	return if w2 == XCB_NONE
	mask = XCB_CONFIG_WINDOW_SIBLING | XCB_CONFIG_WINDOW_STACK_MODE
	values = [w2, mode]
	xcb_configure_window(conn, w1, mask, values)
end

def window_above(w1, w2)
	window_stack(w1, w2, XCB_STACK_MODE_ABOVE)
end

def window_below(w1, w2)
	window_stack(w1, w2, XCB_STACK_MODE_BELOW)
end

def window_lower(win)
	values = [XCB_STACK_MODE]
	xcb_configure_window(conn, win, XCB_CONFIG_WINDOW_STACK_MODE, values)
end

def window_set_visibility(win, visibility)
	values_off = [ROOT_EVENT_MASK & ~XCB_EVENT_MASK_SUBSTRUCTURE_NOTIFY]
	values_on = [ROOT_EVENT_MASK]
	xcb_change_window_attributes(conn, root, XCB_CW_EVENT_MASK, values_off)
	if visible
		set_window_state(win, XCB_ICCCM_WM_STATE_NORMAL)
	else
		xcb_unmap_window(conn, win)
		set_window_state(win, XCB_ICCCM_WM_STATE_ICONIC)
	end
	xcb_change_window_attributes(conn, root, XCB_CW_EVENT_MASK, values_on)
end

def window_hide(win)
	window_set_visibility(win, false)
end

def window_show(win)
	window_set_visibility(win, true)
end

def unput_input_focus(win)
	set_input_focus(mon.desk.focus)
end

def set_input_focus(n)
	if n.nil? || n.client.nil?
		clear_input_focus
	else
		if n.client.icccm_props.input_hint(conn, XCB_INPUT_FOCUS_PARENT, n.id, XCB_CURRENT_TIME)
			xcb_set_input_focus(conn, XCB_INPUT_FOCUS_PARENT, n.id, XCB_CURRENT_TIME)
		else if n.client.icccm_props.take_focus
			send_client_message(n.id, ewmh.WM_PROTOCOLS, WM_TAKE_FOCUS)
		end
	end
end

def clear_input_focus
	xcb_set_input_focus(conn, XCB_INPUT_FOCUS_POINTER_ROOT, root, XCB_CURRENT_TIME)
end

def center_pointer(r)
	return if grabbing
	cx = r.x + r.width / 2
	cy = r.y + r.height / 2
	xcb_warp_pointer(conn, XCB_NONE, root, 0, 0, 0, 0, cx, cy)
end

def get_atom(name, atom)
	xcb_intern_atom_reply(conn, XCB_PROP_MODE_REPLACE, win, atom, XCB_ATOM_CARDINAL, 32, 1, pointerof(value))
	if reply.not_nil?
		atom = reply.atom
	else
		atom = XCB_ATOM
	end
	free reply
end

def set_atom(win, atom, value)
	xcb_change_property(conn, XCB_PROP_MODE_REPLACE, win, atom, XCB_ATOM_CARDINAL, 32, 1, pointerof(value))
end

def send_client_message(win, property, value)
	e = ClientMessage.new response_type: XCB_CLIENT_MESSAGE, window: win, type: property, format: 32, data: ClientMessageData.new data32: [value, XCB_CURRENT_TIME]
	xcb_send_event(conn, false, win, XCB_EVENT_MASK_NO_EVENT, e.as Char*)
	xcb_flush(conn)
	free e
end 

def window_exists(win)
	err = Pointer(GenericError).null
	free(xcb_query_tree_reply(conn, xcb_query_tree(conn, win), pointerof(err))
	return false if err.not_nil? else return true
end
