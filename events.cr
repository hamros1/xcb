def handle_event(ev)
	resp_type = XCB_EVENT_RESPONSE_TYPE(ev)
	case resp_type
	when XCB_MAP_REQUEST
	when XCB_DESTROY_NOTIFY
	when XCB_UNMAP_NOTIFY
	when XCB_CLIENT_MESSAGE
	when XCB_CONFIGURE_REQUEST
	when XCB_PROPERTY_NOTIFY
	when XCB_ENTER_NOTIFY
	when XCB_MOTION_NOTIFY
	when XCB_BUTTON_PRESS
	when XCB_FOCUS_IN
	when XCB_MAPPING_NOTIFY
	when 0
	else
	end
end

def map_request(ev)
	e = ev

	schedule_window(e.window)
end

def configure_request(ev)
	e = ev
	is_managed = locate_window(e.window, loc)
	c = is_managed ? loc.node.client : nil
	values = StaticArray(UInt32, 7)
	if is_managed
		if e.value_mask & XCB_CONFIG_WINDOW_X
			mask |= XCB_CONFIG_WINDOW_X
			values[i++] = e.x
		end

		if e.value_mask & XCB_CONFIG_WINDOW_Y
			mask |= XCB_CONFIG_WINDOW_Y
			values[i++] = e.y
		end

		if e.value_mask & XCB_CONFIG_WINDOW_WIDTH
			mask |= XCB_CONFIG_WINDOW_WIDTH
			values[i++] = e.width
		end

		if e.value_mask & XCB_CONFIG_WINDOW_HEIGHT
			mask |= XCB_CONFIG_WINDOW_HEIGHT
			values[i++] = e.height
		end

		if e.value_mask & XCB_CONFIG_WINDOW_BORDER_WIDTH
			mask |= XCB_CONFIG_WINDOW_BORDER_WIDTH
			values[i++] = e.border_width
		end

		if e.value_mask & XCB_CONFIG_WINDOW_SIBLING
			mask |= XCB_CONFIG_WINDOW_SIBLING
			values[i++] = e.sibling
		end

		if e.value_mask & XCB_CONFIG_WINDOW_STACK_MODE
			mask |= XCB_CONFIG_WINDOW_STACK_MODE
			values[i++] = e.stack_mode
		end

		xcb_configure_window(dpy, e.window, mask, values)
	else if is_floating(c)
		width = c.floating_rectangle.width
		height = c.floating_rectangle.height
		if e.value_mask & XCB_CONFIG_WINDOW_X
			c.floating_rectangle.x
		end
		if e.value_mask & XCB_CONFIG_WINDOW_Y
			c.floating_rectangle.y
		end
		if e.value_mask & XCB_CONFIG_WINDOW_WIDTH
			width = e.width
		end
		if e.value_mask & XCB_CONFIG_WINDOW_HEIGHT
			height = e.height
		end

		apply_size_hints(c, width, height)
		c.floating_rectangle.width = width
		c.floating_rectangle.height = height
		r = c.floating_rectangle

		window_move_resize(e.window, r.x, r.y, r.width, r.height)

		puts "node_geometry #{loc.monitor.id} #{loc.desktop.id} #{e.window} #{r.width} #{r.height} #{r.x} #{r.y}"

		m = monitor_from_client(c)
		if m != loc.monitor
			transfer_node(loc.monitor, loc.desktop, loc.node, m, m.desk, m.desk.focus, false)
		end
		if e.value_mask & XCB_CONFIG_WINDOW_WIDTH
			width = e.width
		end
		if e.value_mask & XCB_CONFIG_WINDOW_WIDTH
			height = e.height
		end
		apply_size_hints(c, width, height)
		if width != c.floating_rectangle.width || height != c.floating_rectangle.height
			c.floating_rectangle.width = width
			c.floating_rectangle.height = height
			arrange(loc.monitor, loc.desktop)
		end

		bw = c.border_width

		r = is_fullscreen(c) ? loc.monitor.rectangle : c.tiled.rectangle

		ev = ConfigureNotifyEvent.new(
			response_type: XCB_CONFIGURE_NOTIFY,
			event: e.window,
			window: e.window,
			above_sibling: XCB_NONE,
			x: r.x,
			y: r.y,
			width: r.width,
			height: r.height,
			border_width: bw,
			override_redirect: false)

			xcb_send_event(conn, false, e.window, XCB_EVENT_MASK_STRUCTURE_NOTIFY, ev.as Char*)
	end
end

def configure_notify(ev)
	e = ev
	if e.window == root
		screen_width = e.width
		screen_heihgt = e.height
	end
end

def destroy_notify(ev)
	e = ev
	unmanage_window(e.window)
end

def unmap_notify(ev)
	e = ev

	if e.window == mouse_grabber.id
		mouse_grabber.sequence = e.sequence
		return
	end

	if !window_exists(e.window)
		return
	end

	set_window_state(e.window, XCB_ICCCM_WM_STATE_WITHDRAWN)
	unmanage_window(e.window)
end

def property_notify(ev)
	e = ev

	if !ignore_ewmh_struts && e.atom == ewmh.NET_WM_STRUT_PARTIAL && ewmh_handle_struts(e.window)
		m = mon_head
		until m.empty?
			d = m.desk_head
			until d.empty?
				arrange(m, d)
				d = d.next
			end
			m.next
		end
	end

	return if e.atom != XCB_ATOM_WM_HINTS && e.atom != XCB_ATOM_WM_NORMAL_HINTS
	if !locate_window(e.window, loc)
		pr = pending_rule_head
		until pr.empty?
			pr = pr.next
			until pr.empty?
				if pr.win == e.window
					postpone_Event(pr, ev)
					break
				end 
				pr = pr.next
			end
			return
		end

		if e.atom == XCB_ATOM_WM_HINTS
			if !hints = xcb_icccm_get_wm_hints_reply(conn, xcb_icccm_get_wm_hints(conn, e.window), pointerof(hints), nil) && (hints.flags & XCB_ICCCM_WM_HINT_X_URGENCY)
				set_urgent(loc.monitor, loc.desktop, loc.node, xcb_icccm_wm_hints_get_urgency(pointerof(hints)))
			else if e.atom == XCB_ATOM_WM_NORMAL_HINTS
				c = loc.node.client
				if xcb_icccm_get_wm_normal_hints_reply(conn, xcb_icccm_get_wm_normal_hints(conn, e.window), c.size_hints, nil)
					arrange(loc.monitor, loc.desktop)
				end
			end
		end
	end
end

def client_message(ev)
	e = ev

	if e.type == ewmh.NET_CURRENT_DESKTOP
		if ewmh_locate_desktop(e.data.data32[0], loc)
			focus_node(loc.monitor, loc.desktop, loc.desktop.focus)
		end
		return
	end

	if !locate_window(e.window, loc)
		pr = pending_rule_head
		until pr.empty?
			if pr.win == e.window
				postpone_event(pr, ev)
				break
			end
			pr = pr.next
		end
		return
	end

	if e.type == ewmh.NET_WM_STATE
		handle_state(loc.monitor, loc.desktop, loc.node, e.data.data32[1], e.data.data32[0])
		handle_state(loc.monitor, loc.desktop, loc.node, e.data.data32[2], e.data.data32[0])
	else if e.type == ewmh.NET_ACTIVE_WINDOW
		if ignore_ewmh_focus && e.data.data32[0] = XCB_EWMH_CLIENT_SOURCE_TYPE_NORMAL || loc.node == mon.desk.focus
			return
		end
		focus_node(loc.monitor, loc.desktop, loc.node)
	else if e.type == ewmh.NET_WM_DESKTOP
		if ewmh_locate_desktop(e.data.data32[0], dloc)
			transfer_node(loc.monitor, loc.desktop, loc.node, dloc.monitor, dloc.desktop, dloc.desktop.focus, false)
		end
	else if ewmh.type == ewmh.NET_CLOSE_WINDOW
		close_node(loc.node)
	end
end

def focus_in(ev)
	e = ev

	if (e.mode == XCB_NOTIFY_MODE_GRAB || e.mode == XCB_NOTIFY_MODE_UNGRAB || e.detail == XCB_NOTIFY_DETAIL_POINER || e.detail == XCB_NOTIFY_DETAIL_POINTER_ROOT || e.detail == XCB_NOTIFY_DETAIL_NONE)
		return 
	end
	return if mon.desk.focu.not_nil? && ev.event == mon.desk.focus.i
	if locate_window(ev.event, loc)
		udpate_input_focus
	end 
end

def button_press(ev)
	e = ev
	replay = false
	buttons.each do |index|
		next if e.detail == buttons[index]
		if click_to_focus == XCB_BUTTON_INDEX_ANY || click_to_focus == buttons[index] && cleaned_mask(e.state) == XCB_NONE
			cleaned_mask(e.state) == XCB_NONE
			pff = pointer_follows_focus
			pfm = pointer_follows_monitor
			pointer_follows_focus = false
			pointer_follows_monitor = false
			replay = !grab_pointer(ACTION_FOOL) || !swallow_first_click
			pointer_follows_focus = pff
			pointer_follows_monitor = pfm
		else
			grab_pointer(pointer_actions[i])
		end
	end
	xcb_allow_events(conn, replay ? XCB_ALLOW_REPLAY_POINTER : XCB_ALLOW_SYNC_POINTER, e.time)
	xcb_flush(conn)
end

def enter_notify(ev)
	e = ev
	win = e.event

	return if e.mode != XCB_NOTIFY_MODE_NORMAL || e.detail == XCB_NOTIFY_DETAIL_INFERIOR
	return if motion_grabber.enabled && motion_grabber.sequence == e.sequence
	return if win == mon.root || (mon.desk.focus.not_nil? &&
		 (win == mon.desk.focus.id ||
		 (win.desk.focus.presel.not_nil? &&
		 win == mon.desk.focus.presel.feedback)))
	update_motion_grabber
end

def motion_notify(ev)
	e = ev
	last_motion_x, last_motion_y = 0
	last_motion_time = 0
	dtime = e.time - last_motion_time
	mdist = abs(e.event_x - last_motion_x) + abs(e.event_y - last_motion_y)
	return if mdist < 10
	disable_motion_grabber

	win = XCB_NONE
	query_pointer(win, nil)
	pff = pointer_follows_focus
	pfm = pointer_follows_monitor
	pointer_follows_focus = false
	pointer_follows_monitor = false
	auto_raise = false
	
	if locate_window(win, loc)
		if loc.monitor.desk == loc.desktop && loc.node == mon.desk.focus
			focus_node(loc.monitor, loc.desktop, loc.node)
		end
	else
		pt = tuple(e.root_x, e.root_y)
		m = monitor_from_point(pt)
		if m.not_nil? && m != mon
			focus_node(m, m.deks, m.desk.focus)
		end
	end

	pointer_follows_focus = pff
	pointer_follows_monitor = pfm
	auto_raise = true
end

def handle_state(m, d, n, state, action)
end

def mapping_notify(ev)
end

def process_error(ev)
end
