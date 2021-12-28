def handle_event(ev)
	resp_type = XCB_EVENT_RESPONSE_TYPE(ev)
	case resp_type
	when XCB_MAP_REQUEST
		map_request(ev)
		break
	when XCB_DESTROY_NOTIFY
		destroy_notify(ev)
		break
	when XCB_UNMAP_NOTIFY
		unmap_notify(ev)
		break
	when XCB_CLIENT_MESSAGE
		client_message(ev)
		break
	when XCB_CONFIGURE_REQUEST
		configure_request(ev)
		break
	when XCB_PROPERTY_NOTIFY
		property_notify(ev)
		break
	when XCB_ENTER_NOTIFY
		enter_notify(ev)
		break
	when XCB_MOTION_NOTIFY
		motion_notify(ev)
		break
	when XCB_BUTTON_PRESS
		button_press(ev)
		break
	when XCB_FOCUS_IN
		focus_in(ev)
		break
	when XCB_MAPPING_NOTIFY
		mapping_notify(ev)
		break
	when 0
		process_error(ev)
		break
	else
		if randr && resp_type == randr_base + XCB_RANDR_SCREEN_CHANGE_NOTIFY
			update_monitors
		end
		break
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

		xcb_configure_window(conn, e.window, mask, values)
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
	if state == ewmh.NET_WM_STATE_FULLSCREEN
		if !(action == XCB_EWMH_STATE_ADD && (ignore_ewmh_fullscreen & STATE_TRANSITION_ENTER))
		else if !(action == XCB_EWMH_WM_STATE_REMOVE && (ignore_ewmh_fullscreen & STATE_TRANSITION_EXIT))
			if n.client.state == STATE_FULLSCREEN
				set_state(m, d, n, n.client.last_state)
			end
		else if !(action == XCB_EWMH_WM_STATE_TOGGLE)
			next_state = is_fullscreen(n.client) ? n.client.state.last_name : STATE_FULLSCREEN
			if !(next_state == STATE_FULLSCREEN && (ignore_ewmh_fullscreen & STATE_TRANSITION_ENTER) ||
				 next_state != STATE_FULLSCREEN && ignore_ewmh_fullscreen & STATE_TRANSITION_EXIT)
				set_state(m, d, n, next_state)
			end
		end
		arrange(m, d)
	else if state == ewmh.NET_WM_STATE_BELOW
		if action == XCB_EWMH_WM_STATE_ADD
			state_layer(m, d, n, LAYER_BELOW)
		else if action == XCB_EWMH_WM_STATE_REMOVE
			if n.client.layer == LAYER_BELOW
				set_layer(m, d, n, n.client.last_layer)
			else if action == XCB_EWMH_WM_STATE_TOGGLE
				set_layer(m, d, n, n.client.layer == LAYER_BELOW ? n.client.last_layer : LAYER_BELOW)
			end 
		end
	else if state == ewmh.NET_WM_STATE_ABOVE
		if action == XCB_EWMH_WM_STATE_ADD
			set_layer(m, d, n, LAYER_ABOVE)
		else if action == XCB_EWMH_WM_STATE_REMOVE
			set_layer(m, d, n, LAYER_ABOVE)
		else if action == XCB_EWMH_WM_STATE_TOGGLE
			set_layer(m, d, n, n.client.layer == LAYER_ABOVE ? n.client.last_layer : LAYER_ABOVE)
		end
	else if state == ewmh.NET_WM_STATE_HIDDEN
		if action == XCB_EWMH_WM_STATE_ADD
			set_hidden(m, d, n, true)
		else if action == XCB_EWMH_WM_STATE_REMOVE
			set_hidden(m, d, n, false)
		else if action == XCB_EWMH_WM_STATE_TOGGLE
			set_hidden(m, d, n, !n.hidden)
		end
	else if state == ewmh.NET_WM_STATE_STICKY
		if action == XCB_EWMH_WM_STATE_ADD
			set_sticky(m, d, n, true)
		else if action == XCB_EWMH_WM_STATE_REMOVE
			set_sticky(m, d, n, false)
		else if action == XCB_EWMH_WM_STATE_TOGGLE
			set_sticky(m, d, n, !n.sticky)
		end
	else if state == ewmh.NET_WM_STATE_DEMANDS_ATTENTION
		if action == XCB_EWMH_WM_STATE_ADD
			set_urgent(m, d, n, true)
		else if action == XCB_EWMH_WM_STATE_REMOVE
			set_urgent(m, d, n, false)
		else if action == XCB_EWMH_WM_STATE_TOGGLE
			set_urgent(m, d, n, !n.clint.urgent)
		end
	else if state == ewmh.NET_WM_STATE_MODAL
		if action == XCB_EWMH_WM_STATE_ADD
			n.client.wm_flags |= WM_FLAG_MODAL
		else if action == XCB_EWMH_WM_STATE_REMOVE
			n.client.wm_flags &= ~WM_FLAG_MODAL
		else if action == XCB_EWMH_WM_STATE_TOGGLE
			n.client.wm_flags ^= WM_FLAG_MODAL
		end
	else if state == ewmh.NET_WM_STATE_MAXIMIZED_VERT
		if action == XCB_EWMH_WM_STATE_ADD
			n.client.wm_flags |= WM_FLAG_MAXIMIZED_VERT
		else if action == XCB_EWMH_WM_STATE_REMOVE
			n.client.wm_flags &= ~WM_FLAG_MAXIMIZED_VERT
		else if action == XCB_EWMH_WM_STATE_TOGGLE
			n.client.wm_flags ^= WM_FLAG_MAXIMIZED_VERT
		end
	else if state == ewmh.NET_WM_STATE_MAXIMIZED_HORZ
		if action == XCB_EWMH_WM_STATE_ADD
			n.client.wm_flags |= WM_FLAG_MAXIMIZED_HORZ
		else if action == XCB_EWMH_WM_STATE_REMOVE
			n.client.wm_flags &= ~WM_FLAG_MAXIMIZED_HORZ
		else if action == XCB_EWMH_WM_STATE_TOGGLE
			n.client.wm_flags ^= WM_FLAG_MAXIMIZED_HORZ
		end
	else if state == ewmh.NET_WM_STATE_SHADED
		if action == XCB_EWMH_WM_STATE_ADD
			n.client.wm_flags |= WM_FLAG_SHADED
		else if action == XCB_EWMH_WM_STATE_REMOVE
			n.client.wm_flags &= ~WM_FLAG_SHADED
		else if action == XCB_EWMH_WM_STATE_TOGGLE
			n.client.wm_flags ^= WM_FLAG_SHADED
		end
	else if state == ewmh.NET_WM_STATE_SKIP_TASKBAR
		if action == XCB_EWMH_WM_STATE_ADD
			n.client.wm_flags |= WM_FLAG_SKIP_TASKBAR
		else if action == XCB_EWMH_WM_STATE_REMOVE
			n.client.wm_flags &= ~WM_FLAG_SKIP_TASKBAR
		else if action == XCB_EWMH_WM_STATE_TOGGLE
			n.client.wm_flags ^= WM_FLAG_SKIP_TASKBAR
		end
	else if state == ewmh.NET_WM_STATE_SKIP_PAGER
		if action == XCB_EWMH_WM_STATE_ADD
			n.client.wm_flags |= WM_FLAG_SKIP_PAGER
		else if action == XCB_EWMH_WM_STATE_REMOVE
			n.client.wm_flags &= ~WM_FLAG_SKIP_PAGER
		else if action == XCB_EWMH_WM_STATE_TOGGLE
			n.client.wm_flags ^= WM_FLAG_SKIP_PAGER
		end
	end
end

def mapping_notify(ev)
	return if !mapping_events_count

	e = ev

	return if e.request == XCB_MAPPING_POINTER

	if mapping_events_count > 0
		mapping_events_count -= 1
	end

	ungrab_buttons
	grab_buttons
end

def process_error(ev)
	e = ev
	return if e.error_code == ERROR_CODE_BAD_WINDOW
	puts "Failed request #{xcb_event_get_request_label(e.major_opcode}, #{xcb_event_get_request_label(e.error_code)}: #{e.bad_value}"
end
