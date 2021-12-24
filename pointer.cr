def pointer_init
	num_lock = modfield_from_keysym(XK_Num_Lock)
	caps_lock = modfield_from_keysym(XK_Caps_Lock)
	scroll_lock = modfield_from_keysym(XK_Scroll_Lock)
	if caps_lock == XCB_NO_SYMBOL
		caps_lock = XCB_MOD_MASK_LOCK
	end
	grabbing = false
	grabbed_node = nil
end

def window_grab_buttons(win)
	buttons.size.times do |i|
		if click_to_focus == XCB_BUTTON_INDEX_ANY || click_to_focus == buttons[i]
			window_grab_button(win, buttons[i], XCB_NONE)
		end
		if pointer_action[i] != ACTION_NONE
			window_grab_button(win, buttons[i], pointer_modifier)
		end
	end
end

macro grab(button, modifier)
	xcb_grab_button(conn, false, win, XCB_EVENT_MASK_BUTTON_PRESS, XCB_GRAB_MODE_SYNC, XCB_GRAB_MODE_ASYNC, XCB_NONE, XCB_NONE, b, m)
end

def window_grab_button(win, button, modifier)
	if num_lock != XCB_NO_SYMBOL && caps_lock != XCB_NO_SYMBOL && scroll_lock != XCB_NO_SYMBOL
		grab(button, modifier | num_lock | caps_lock | scroll_lock)
	end
	if num_lock != XCB_NO_SYMBOL && caps_lock != XCB_NO_SYMBOL
		grab(button, modifier | num_lock | caps_lock)
	end
	if caps_lock != XCB_NO_SYMBOL && scroll_lock != XCB_NO_SYMBOL
		grab(button, modifier | caps_lock | scroll_lock)
	end
	if num_lock != XCB_NO_SYMBOL && scroll_lock != XCB_NO_SYMBOL
		grab(button, modifier | num_lock | scroll_lock)
	end
	if num_lock != XCB_NO_SYMBOL
		grab(button, modifier | num_lock | caps_lock | scroll_lock)
	end
	if caps_lock != XCB_NO_SYMBOL
		grab(button, modifier | caps_lock)
	end
	if scroll_lock != XCB_NO_SYMBOL
		grab(button, modifier | scroll_lock)
	end
end

def grab_buttons
	m = mon_head
	while m
		d = m.desk_head
		while d 
			n = d.root
			while n
				window_grab_buttons n.id
				if n.presel
					widow_grab_buttons n.presel.feedback
				end
				n = n.shift
			end
			d = d.shift
		end
		m = m.shift
	end
end

def ungrab_buttons
	m = mon_head
	while m
		d = desk_head
		while d
			n = d.root
			while n
				xcb_ungrab_button(conn, XCB_BUTTON_INDEX_ANY, n.id, XCB_MOD_MASK_ANY)
				n = n.shift
			end
			d = d.shift
		end
		m = m.shift
	end
end

def modfield_from_keysym
	modfield = 0
	keycodes, mod_keycodes = Pointer(LibXCB::Keycode).null
	symbols = xcb_key_symbols_alloc(conn)
	if !keycodes = xcb_key_symbols_get_keycode(symbols, keycode) ||
			!reply = xcb_get_modifier_mapping_reply(conn, xcb_get_modifier_mapping(conn), nil) ||
			reply.keycodes_per_modifier < 1 ||
			!mod_keycodes = xcb_get_modifier_mapping_keycodes(reply)
		xcb_key_symbols_free(symbols)
		return modfield
	end
	num_mod = xcb_get_modifier_mapping_keycodes_length(reply) / reply.keycodes_per_modifier
	num_mod.times do |i|
		reply.keycodes_per_modifier.times do |j|
			mk = mod_keycodes[i * reply.keycodes_per_modifier + j]
			next if mk == XCB_NO_SYMBOL
			keycodes.each do |k|
				break if k == XCB_NO_SYMBOL
				if k == mk
					modfield |= (1 << i)
				end
			end
		end
	end
	xcb_key_symbols_free(symbols)
	return modfield
end

def get_handle(n, pos, pac)
	rh = HANDLE_BOTTOM_RIGHT
	rect = get_rectangle(nil, nil,, n)
	if pac == ACTION_RESIZE_SIDE
		w = rect.width
		h = rect.height
		ratio = w / h
		x = pos.x - rect.x
		y = pos.y - rect.y
		diag_a = ratio * y
		diag_b = w - diag_a
		if x < diag_a
			if x < diag_b
				rh = HANDLE_LEFT
			else
				rh = HANDLE_BOTTOM
			end
		else
			if x < diag_b
				rh = HANDLE_TOP
			else
				rh = HANDLE_RIGHT
			end
		end
	else if pac == ACTION_RESIZE_CORNER
		mid_x = rect.x + (rect.width / 2)
		mid_y = rect.y + (rect.height / 2)
		if pos.x > mid_x
			if pos.y > mid_y
				rh = HANDLE_BOTTOM_RIGHT
			else
				rh = HANDLE_TOP_RIGHT
			end
		else
			if pos.y > mid_y
				HANDLE_BOTTOM_LEFT
			else
				rh = HANDLE_TOP_LEFT
			end
		end
	end
	rh
end

def grab_pointer(pac)
	win = XCB_NONE
	pos = query_pointer(win)
	if loc = locate_window(win)
		if pac == ACTION_FOCUS
			m = monitor_from_point(pos)
			if m && m != mon && (win == XCB_NONE || win.root)
				focus_node(m, m.desk, m.desk.focus)
				return true
			end
		end
		return false
	end
	if pac == ACTION_FOCUS
		if loc.node != mon.desk.focus
			focus_node(loc.monitor, loc.desktop, loc.node)
			return true
		else if focus_follows_pointer
			stack(loc.desktop, loc.node, true)
		end
		return false
	end 
	return true if loc.node.client.state == STATE_FULLSCREEN
	if !reply || reply.status != XCB_GRAB_STATUS_SUCCESS
		return true
	end

	if pac == ACTION_MOVE
		puts "pointer_action #{loc.monitor.id} #{loc.desktop.id} #{loc.node.id} move begin"
	else if pac == ACTION_RESIZE_CORNER
		puts "pointer_aciton #{loc.monitor.id} #{loc.desktop.id} #{loc.node.id} resize_corner begin"
	else if pac == ACTION_RESIZE_SIDE
		puts "pointer_action #{loc.monitor.id} #{loc.desktopid} #{loc.node.id} resize_side begin"
	end
	track_pointer(loc, pac, pos)
	return true
end

def track_pointer(loc : Coordinates, pac : PointerAction, pos : LibXCB::XcbPoint)
	n = loc.node
	rh = get_handle(loc.node, pos, pac)
	last_motion_x = pos.x
	last_motion_y = pos.y
	last_motion_time = 0
	grabbing = true
	grabbed_node = n
	loop do
		while !ev = xcb_wait_for_event(conn) xcb_flush(conn) end
			resp_type = XCB_EVENT_RESPONSE_TYPE(ev)
			if resp_type = XCB_MOTION_NOTIFY
				e = evt
				dtime = e.time - last_motion_time
				next if dtime < pointer_motion_interval
				last_motion_time = e.time
				dx = e.root_x - last_motion_x
				dy = e.root_y - last_motion_y
				if pac == ACTION_MOVE
				else
					if honor_size_hints
						resize_client(loc, rh, e.root_x, e.root_y, false)
					else
						resize_client(loc, rh, dx, dy, true)
					end
				end
			else if resp_type == BUTTON_RELEASE
				grabbing = false
			else
				handle_event(evt)
			end
			break if grabbing && !grabbed_node
		end
		xcb_ungrab_pointer(conn, XCB_CURRENT_TIME)
		if !grabbed_node
			grabbing = false
			return
		end
		if pac == ACTION_MOVE
			puts "pointer action move end #{loc.monitor.id} #{loc.desktop.id} #{n.id} move end"
		else if pac == ACTION_RESIZE_CORNER
			puts "pointer action #{loc.monitor.id} #{loc.desktop.id} #{n.id} resize"
		else if pac == ACTION_RESIZE_SIDE
			puts "pointer action #{loc.monitor.id} #{loc.desktop.id} #{n.id} resize end"
		end
		r = get_rectangle(nil, nil, n)
		put "node_geometry #{loc.monitor.id} #{loc.desktop.id} #{loc.node.id} #{r.width} #{r.height} #{r.x} #{r.y}"
		if (pac == ACTION_MOVE && is_tiled(n.client)) || (pac == ACTION_RESIZE_CORNER || pac == ACTION_RESIZE_SIDE && n.client.state == STATE_TILED)
			f = loc.desktop.root[0]
			while f
				next if f == n || !f.client || is_tiled(f.client)
				r = f.client.tiled_rectangle
				puts "node_geometry #{loc.monitor.id} #{loc.desktop.id} #{f.id} #{r.width} #{r.height} #{r.x} #{r.y}"
				f = f.shift
			end
		end
	end
