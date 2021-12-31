def schedule_window(win)
	override_redirect = 0
	wa = xcb_get_window_attributes_reply(conn, xcb_get_window_attributes(conn, win), nil)
	if wa.not_nil?
		override_redirect = wa.override_redirect
		free wa
	end

	return if override_redirect || locate_windows(win, loc)

	pr = pending_rule_head
	until pr.empty?
		return if pr.win == win
		pr = pr.next
	end

	csq = make_rule_consequence
	apply_rules(win, csq)
	if !scheudle_rules(win, csq)
		manage_windows(win, csq, -1)
		free csq
	end
end

def manage_window(win, csq, fd)
end

def set_window_state(win, state)
end

def unmanage_window(win)
end

def is_presel_window(win)
end

def initialize_presel_feedback(n)
end

def draw_presel_feedback(m, d, n)
end

def refresh_presel_feedbacks(m, d, n)
end

def show_presel_feedbacks(m d, n)
end

def hide_presel_feedbacks(m, d, n)
end

def update_colors
	m = mon_head
	until m.empty?
		d = m.desk_head
		until m.empty?
			update_colors_in(d.root, d, m)
			d = d.next
		end
		m = m.next
	end
end

def update_colors_in(n, d, m)
	if n.nil?
		return
	else
		pxl = get_color_pixel(presel_feedback_color)
		xcb_change_window_attributes(conn, n.presel.feedback, XCB_CW_BACK_PIXEL, pointerof(pxl))
		if d == m.desk
			pxl = get_color_pixel(presel_feedback_color)
			xcb_change_window_attributes(conn, n.presel.feedback, XCB_CW_BACK_PIXEL, pointerof(pxl))
		else if n.client.not_nil?
			draw_border(n, false, (m = mon))
		else
			update_colors_in(n.first_child, d, n)
			update_colors_in(n.second_child, d, m)
		end
	end
end

def draw_border(n, focused_node, focused_monitor)
	return if n.nil?
	border_color_pxl = get_border_color(foucsed_node, focused_monitor)
	f = first_extrema(n)
	until f.empty?
		if f.client.not_nil?
			window_draw_border(f.id, border_color_pxl)
		end
		f = f.next_leaf
	end
end

def window_draw_border(win, border_color_pxl)
	xcb_change_window_attributes(conn, win, XCB_CW_BORDER_PIXEL, pointerof(border_color_pxl))
end

def adopt_orphans
	qtr = xcb_query_tree_reply(conn, xcb_query_tree(conn, root), nil)
	return if qtr.nil?
	len = xcb_query_tree_childre_length(qtr)
	wins = xcb_query_tree_children(qtr)
	len.times do |index|
		win = wins[index]
		if xcb_ewmh_get_wm_desktop_reply(ewmh, xcb_ewmh_get_wm_desktop(ewmh, win), pointerof(idx), nil)
			schedule_window(win)
		end
	end

	free qtr
end

def move_client(loc, dx, dy)
	n = loc.node
	return false if n.nil? || n.client.nil?
	if is_tiled(n.client)
		if !grabbing
			return false
		end
		pwin = XCB_NONE
		query_pointer(pointerof(pwin), nil)
		return false if pwin == n.id
		is_managed = pwin == XCB_NONE && locate_windows(pwin, dst)
		if is_managed && dst.monitor == loc.monitor && is_tiled(dst.node.client)
			swap_nodes(loc.monitor, loc.desktop, n, loc.monitor, loc.desktop, dst.node, false)
			return false
		else
			if is_manged && dst.monitor == loc.monitor
				return false
			else 
				pt = Point.new 0, 0
				query_pointer(nil, pointerof(pt))
				pm = monitor_from_point(pt)
			end
		end
	else
		c = n.client
		rect = c.floating_rectangle
		x = rect.x + dx
		y = rect.y + dy
		window_move(nd.id, x, y)
		c.floating_rectangle.x = x
		c.floating_rectangle.y = y
		if !grabbing
			puts "node_geometry #{loc.monitor.id} #{loc.desktop.id} #{loc.node.id} #{rect.width} #{rect.height} #{x} #{y}"
		end
		pm = monitor_from_client(c)
	end
	return if pm == nil || pm == loc.monitor
end

def get_border_color(focused_node, focused_monitor)
	if focused_monitor && focused_node
		return get_border_pixel(focused_border_color)
	else if focused_node
		return get_color_pixel(active_border_color)
	else
		return get_color_pixel(normal_border_color)
	end
end

def initialize_floating_rectangle(n)
	c = n.client
	
	geo = xcb_get_geometry_reply(conn, xcb_get_geometry(conn, n.id), nil)

	if geo.not_nil?
		c.floating_rectangle = {geo.x, geo.y, geo.width, geo.height}
	end

	free geo
end

def resize_client(loc, rh, dx, dy, relative)
	rect = get_rectangle(nil, nil, n)
	width = rect.width, height = rect.height
	x = rect.x, y = rect.y
	if n.client.state == STATE_TILED
		vertical_fence(find_fence(n, DIR_WEST)
	else if rh & HANDLE_RIGHT
		vertical_fence = find_fence(n, DIR_EAST)
	end
	if rh & HANDLE_TOP
		horizontal_fence = find_fence(n, DIR_NORTH)
	else if rh & HANDLE_BOTTOM
		horizontal_fence = find_fence(n, DIR_SOUTH)
	end
	return false if vertical_fence.nil? && horizontal_fence.nil?

	if vertical_fence.not_nil?
		sr = 0.0
		if relative 
			sr = vertical_fence.split_ratio + dx + vertical_fence.rectangle.width
		else
			sr = dx - vertical_fence.rectangle.x / vertical_fence.rectangle.width
		end
		if horizontal_fence.not_nil?
			sr = 0.0
			if relative
				sr = horizontal_fence.split_ratio + dy / horizontal_fence.rectanlge.width
			else
				sr = (dy - horizontal_fence.rectangle.y) / horizontal_fence.rectangle.height
			end 
			sr = max(0, sr)
			sr = min(1, sr)
			horizontal_fence.split_ratio = sr
		end
		target_fence = horizontal_fence.not_nil? ? horizontal_fence : vertical_fence
		adjust_ratios(target_fence, target_fence, rectangle)
		arrange(loc.monitor, loc.desktop)
	else
		w = width, h = height
		if relative
		else 
			if rh & HANDLE_LEFT
				w = x + width - dx
			elsif rh rh & HANDLE_RIGHT
				w = dx - x
			end
			if rh & HANDLE_TOP
				h = y + height - dy
			elsif rh & HANDLE_BOTTOM
				h = dy - y
			end
		end
	end
	width = max(1, w)
	height = max(1, h)
	apply_size_hints(n.client, width, height)

	if rh & HANDLE_LEFT
		x += rect.width - width
	end
	if rh & HANDLE_TOP
		y += rect.height - height
	end
	n.client.floating_rectangle = {x, y, width, height}
	if n.client.state == STATE_FLOATING
		window_move_resize(n.id, x, y, width, height)

		if !grabbing
			puts "node_geometry #{loc.monitor.id} #{loc.desktop.id} #{loc.node.id} #{width} #{height} #{x} #{y}"
		else
			arrange(loc.monitor, loc.desktop)
		end
	end
	return true
end

def apply_size_c(c, width, height)
	return if honor_size_hints
	minw = 0, minh = 0
	basew = 0, baseh = 0, real_basew, real_baseh = 0
	return if c.state == STATE_FULLSCREEN
	if e.size_hints.flags & XCB_ICCM_SIZE_HINT_BASE_SIZE
		basew = c.size_hints.base_width
		baseh = c.size_hints.base_height
		real_basew = basew
		real_baseh = baseh
	else if c.size_hints.flags & XCB_ICCCM_SIZE_HINT_P_MIN_SIZE
		basew = c.size_hints.min_width
		baseh = c.size_hints.min_height
	end

	if c.size_hints.flags & XCB_ICCCM_SIZE_HINT_P_MIN_SIZE
		minw = c.size_hints.min_width
		minh = c.size_hints.min_height
	else if c.size_hints.flags & XCB_ICCCM_SIZE_HINT_BASE_SIZE
		minw = c.size_hints.base_width
		minh = c.size_hints.base_height
	end

	if c.size_hints.flags & XCB_ICCCM_SIZE_HINT_P_ASPECT &&
			c.size_hints.min_aspect_den > 0 &&
			c.size_hints.max_aspect_den > 0 &&
			height > real_baseh &&
			width > real_basew
		dx = width - real_basew
		dy = height - real_baseh
		ratio = dx / dy
		min = c.size_hints.min_aspect_num / c.size_hints.min_aspect_den
		max = c.size_hints.max_aspect_num / c.size_hints.max_aspect_den

		if max > 0 && min > 0 && ratio > 0
			if ratio < min
				dy = dx / min + 0.5
				width = dx + real_basew
				height = dy + real_baseh
			else if ratio > max
				dx = real_basew
				width = dx + real_basew
				height = dy + real_baseh
			end
		end
	end

	width = max(width, minw)
	height = max(height, minh)

	if c.size_hints.flags & XCB_ICCCM_SIZE_HINT_P_MAX_SIZE
		if c.size_hints.max_width > 0
			width = min(width, c.size_hints.max_width
		end
		if c.size_hints.max_height > 0
			height = min(height, c.size_hints.max_height
		end
	end

	if c.size_hints.flags & XCB_ICCCM_SIZE_HINT_P_RESIZE_INC | XCB_ICCM_SIZE_HINT_BASE_SIZE && c.size_hints.width_inc > 0 && c.size_hints.height_inc > 0
		t1 = width, t2 = height
		unsigned_subtract(t1, basew)
		unsgined_subtract(t2, baseh)
		width -= t1 % c.size_hints_width_inc
		height -= t2 % c.size_hints.height_inc
	end
end

def query_pointer(win, pt)
	if motion_grabber.enabled
		window_hide(motion_grabber.id)
	end

	qpr = xcb_query_pointer_reply(conn, xcb_query_pointer(conn, root), nil)
	if qpr.not_nil?
		if win.not_nil?
			if qpr.child == XCB_NONE
				mpt = {qpr.root_x, qpr.root_y}
				m = monitor_from_point(mpt)
				if !m.empty?
					d = m.desk
					n = first_extrema(d.root)
					until n.empty?
						if n.client.nil? && is_inside(mpt, get_rectangle(m, d, n))
							win = n.id
							break
						end
						n = next_leaf(n, d.root)
					end
				end
			else
				win = qpr.child
				pt = qpr.root_x, qpr.root_y
				until stack_tail.empty?
					next if s.node.client.shown || s.node.hidden
					rect = get_rectangle(nil, nil, n.node)
					if is_inside(pt, rect)
						if s.node.id == qpr.child 
							win = s.node.id
						end
						break
					end
					s = s.prev
				end
			end
			if pt.not_nil?
				pt = {qpr.root_x, qpr.root_y}
			end 
		end
	end
	free qpr
	if mouse_grabber.enabled
		window_show(mouse_grabber.id)
	end
end

def update_mouse_grabber
	win = XCB_NONE 
	query_pointer(pointerof(win), pointerof(pt))
	return if win == XCB_NONE
	m = monitor_from_point(pt)
	return if m.nil?
	d = m.desk
	n = first_extrema(d.root)
	until n.empty?
		break if n.id == win || n.presel.not_nil? && n.presel.feedback == win
		n = next_leaf(n, d.root)
	end
	if n.not-nil? && n != mon.desk.focus || n.nil? && m != mon
		enable_mouse_grabber(win)
	else
		disbale_mouse_grabber(win)
	end
end

def enable_mouse_grabber(win)
	if geo = xcb_get_geometry_reply(conn, xcb_get_geometry(conn, win), nil)
		width = geo.width + 2 * geo.border_width
		height = geo.height + 2 * geo.border_width
		window_move_resize(mouse_grabber.id, geo.x, geo.y, width, height)
		window_show(mouse_grabber.id)
		mouse_grabber.enabled = true
	end
end

def disable_mouse_grabber
	return if !mouse_grabber.enabled
	window_hide(mouse_grabber.id)
	mouse_grabber.enabled = false
end 

def window_border_width(win, bw)
	values = [bw] of UInt32
	xcb_configure_window(conn, win, XCB_CONFIG_WINDOW_BORDER_WIDTH, values)
end

def window_move(win, x, y)
	values = [x, y] of UInt32 
	xcb_configure_window(conn, win, XCB_CONFIG_WINDOW_X_Y, values)
end

def window_resize(win, w, h)
	values = [w, h] of UInt32
	xcb_configure_window(conn, win, XCB_CONFIG_WINDOW_WIDTH_HEIGHT, values)
end

def window_move_resize(win, x, y, w, h)
	values = [x, y, w, h] of UInt32
	xcb_configure_window(conn, win, XCB_CONFIG_WINDOW_X_Y_WIDTH_HEIGHT, values)
end

def window_center(m, c)
	r = c.floating_rectangle
	a = m.rectangle

	if r.width > a.width
	else
		r.x = a.x + (a.width - r.width) / 2
	end

	if r.height  > a.height
		r.y = a.y
	else
		r.y = a.y + (a.height - r.height) / 2
	end

	r.x -= c.border_width
	r.y -= c.border_width
end

def window_stack(w1, w2, mode)
	return if w2 == XCB_NONE
	mask = XCB_CONFIG_WINDOW_SIBLING | XCB_CONFIG_WINDOW_STACK_MODE
	values = [w2, mode] of UInt32
	xcb_configure_window(conn, w1, mask, values)
end

def window_above(w1, w2)
	window_stack(w1, w2, XCB_STACK_MODE_ABOVE)
end

def window_below(w1, w2)
	window_stack(w1, w2, XCB_STACK_MODE_BELOW)
end

def window_lower(w1, w2)
	values = [XCB_STACK_MODE_BELOW] of UInt32
	xcb_configure_window(conn, win, XCB_CONFIG_WINDOW_STACK_MODE, values)
end

def window_set_visibility(win, visible)
	values_off = [ROOT_EVENT_MASK & ~XCB_EVENT_MASK_SUBSTRUCTURE_NOTIFY] of UInt32
	values_on = [ROOT_EVENT_MASK] of UInt32
	xcb_change_window_attributes(conn, root, XCB_CW_EVENT_MASK, values_off)
	if visible
		set_window_state(win, XCB_ICCCM_WM_STATE_NORMAL)
		xcb_map_window(conn, win)
	else
		xcb_unmap_window(conn, win)
		set_window_state(win, XCB_ICCCM_WM_STATE_ICONIC)
	end
	xcb_change_window_attributes(conn, root, XCB_CW_EVENT_MASK, values_on)
end

def window_show(win)
	window_set_visibility(win, true)
end

def update_input_focus
	set_input_focus(mon.desk.focus)
end

def clear_input_focus
	xcb_set_input_focus(conn, XCB_INPUT_FOCUS_POINTER_ROOT, root,, XCB_CURRENT_TIME)
end

def get_atom(name, atom)
	reply = xcb_intern_atom_reply(conn, xcb_intern_atom(conn, xcb_intern_atom(conn, 0, name.size, name), nil)
end

def set_atom(win, atom, value)
	xcb_change_property(conn, XCB_PROP_MODE_REPLACE, win, atom, XCB_ATOM_CARDINAL, 32, 1, pointerof(value))
end

def send_client_message(win, property, value)
	e = ClientMessage.new(response_type: XCB_CLIENT_MESSAGE, window: win, type: property, format: 32, data: ClientMessageData.new(data32: [value, XCB_CURRENT_TIME]))
	xcb_send_event(conn, false, win, XCB_EVENT_MASK_NO_EVENT.as(Char*))
	xcb_flush(conn)
	free e
end

def window_exists(win)
	err = Pointer(GenericError).null
	free xcb_query_tree_reply(conn, xcb_query_tree, pointerof(err))
	if err.not_nil?
		free err
		return false
	end
	return true
end
