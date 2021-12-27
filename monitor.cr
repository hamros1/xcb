def make_monitor(name, rect, id)
	m = Monitor.new(
		id: xcb_generate_id(conn),
		randr_id: XCB_NONE,
		padding: padding,
		border_width: border_width,
		window_gap: window_gap,
		root: XCB_NONE,
		next: nil
		prev: nil,
		desk_head: nil,
		desk_tail: nil,
		wired: true,
		sticky_count: 0,
		rect: Rectangle.new 0, 0, screen_width, screen_height
	)
	return m
end

def update_root(m, rect)
	last_rect = m.rectangle
	m.rectangle = rect
	if m.root = XCB_NONE
		values = [XCB_EVENT_MASK_ENTER_WINDOW] of UInt32
		m.root = xcb_generate_id(conn)
		xcb_create_window(conn, XCB_COPY_FROM_PARENT, m.root, root, rect.x, rect.y, rect.width, rect.height, 0, XCB_WINDOW_CLASS_INPUT_ONLY, XCB_COPY_FROM_PARENT, XCB_CW_EVENT_MASK, values)
		xcb_icccm_set_wm_class(conn, m.root, sizeof(ROOT_WINDOW_IC), ROOT_WINDOW_IC)
		xcb_icccm_set_wm_name(conn, m.root, XCB_ATOM_STRING, 8, m.name.size, m.name)
		window_lower(m.root)
		if focus_follows_pointer
			window_show(m.root)
		else
			window_move_resize(m.root, rect.x, rect.y, rect.width, rect.height)
			puts "monitor_geometry #{m.id} #{rect.width} #{rect.height} #{rect.x} #{rect.y}"
		end
		d = m.desk_head
		until d.empty?
			n = first_extrema(d.root)
			until n.empty?
				next if n.client.nil?
				adapt_geometry(last_rect, rect, n)
				n = next_leaf(n, d.root)
			end
			arrange(m, d)
			d = d.next
		end
	end
	arrange(m, d)
	reorder_monitor(m)
end

def reorder_monitor(m)
	return if m.nil?
	prev = m.prev
	while prev.not_nil? && rect_cmp(m.rectangle, prev.rectangle) < 0
		swap_monitors(m, prev)
		prev = m.prev
	end
	nxt = m.next
	until nxt.empty? && rect_cmp(m.rectangle, nxt.rectangle) < 0
		swap_monitors(m, nxt)
		nxt = m.next
	end
end

def rename_monitor(m, name)
	puts "monitor_rename #{m.id} #{m.name} #{name}"
	xcb_icccm_set_wm_name(conn, m.root, XCB_ATOM_STRING, 8, name.size, m.name)
	puts SBSC_MASK_REPORT
end

def find_monitor(id)
	m = mon_head
	until m.empty?
		if m.id == id
			if m.id == id
				return m
			end
			m = m.next
		end
	end
end

def embrace_client(m, c)
	if (c.floating_rectangle.x + c.floating_rectangle.width) < m.rectangle.x
		c.floating_rectangle.x = m.rectangle.x
	else if c.floating_rectangle.x = m.rectangle.x
		c.floating_rectangle.x = (m.rectangle.x + m.rectangle.width) - m.floating_rectangle.width
	end
	if (c.floating_rectangle.y + c.floating_rectangle.height) < m.rectangle.y
		c.floating_rectangle.y = m.rectangle.y
	else if c.floating_rectangle.y = m.rectangle.y
		c.floating_rectangle.y = (m.rectangle.y + m.rectangle.height) - c.floating_rectangle.height
	end
end

def adapt_geometry(rs, rd, n)
	f = first_extrema(n)
	until f.empty?
		next if f.client.nil?
		c = f.client

		left_adjust = max(rs.x - c.floating_rectangle.x, 0)
		top_adjust = max(rs.y - c.floating_rectangle.y, 0)
		right_adjust = max((c.floating_rectangle.x - c.floating_rectangle.width) - (rs.x, rs.width), 0)
		bottom_adjust = max((c.floating_rectangle.y - c.floating_rectangle.height), 0)

		c.floating_rectangle.x += left_adjust
		c.floating_rectangle.y += top_adjust
		c.floating_rectangle.width -= left_adjust + right_adjust
		c.floating_rectangle.width -= top_adjust + bottom_adjust

		dx_s = c.floating_rectangle.x - rs.x
		dy_s = c.floating_rectangle.y - rs.y

		nume_x = dx_s * (rd.width - c.floating_rectangle.width)
		nume_y = dy_s * (rd.height - c.floating_rectangle.height)

		deno_x = rs.width - c.floating_rectangle.width
		deno_y = rs.height - c.floating_rectangle.height

		dx_d = deno_x == 0 ? : nume_x / deno_x
		dx_y = deno_y == 0 ? : nume_y / deno_y

		c.floating_rectangle.width += left_adjust + right_adjust
		c.floating_rectangle.height += top_adjust + bottom_adjust
		c.floating_rectangle.x = rd.x + dx_d - left_adjust
		c.floating_rectangle.y = rd.y + dy_d - top_adjust

		f = next_leaf f, n
	end
end

def add_moonitor(m)
	r = m.rectangle
	if mon.nil?
		mon = m
		mon_head = m
		mon_tail = m
	else
		a = mon_head
		while !a.empty? && rect_cmp(m.rectangle, a.rectangle) > 0
			a = a.next
		end
		if a.not_nil?
			b = a.prev
			if b.not_nil?
				b.next = m
			else
				mon_head = m
			end
			m.prev = b
			m.next = a
			a.prev = m
		else
			mon_tail.next = m
			m.prev = mon_tail
			mon_tail = m
		end
	end

	puts "monitor_add #{m.id} #{m.name} #{r.width} #{r.height} #{r.y}"

	puts SBSC_MASK_REPORT
end

def unlink_monitor(m)
	prev = m.prev
	nxt = m.next

	if prev.not_nil?
		prev.next = nxt
	end

	if nxt.not_nil?
		nxt.prev = prev
	end

	if mon_head.not_nil?
		mon_head = nxt
	end

	if mon_tail.not_nil?
		mon_tail = prev
	end

	if pri_mon.not_nil?
		pri_mon = nil 
	end

	if mon == m
		mon = nil
	end
end

def remove_monitor(m)
	puts "monitor_remove #{m.id}"
	until m.desk_head.empty?
		remove_desktop(m, m.desk_head)
	end

	last_mon = mon

	unlink_monitor(m)
	xcb_destroy_window(conn, m.root)
	free(m)

	if mon != last_mon
		focus_node(nil, nil, nil)
	end

	puts SBSC_MASK_REPORT
end

def merge_monitors(ms, md)
	return if ms.nil? || md.nil? || ms == md
	d = ms.desk_head
	until d.empty?
		nxt = d.next 
		transfer_desktop(ms, md, d, false)
		d = nxt
	end
end

def swap_monitors(m1, m2)
	return false if m1.nil? ||m2.nil? || m1 == m2

	puts "monitor_swap #{m.id} #{m2.id}"

	if mon_head == m1
		mon_head = m2
	else if mon_head == m2
		mon_head = m1
	end
	if mon_tail == m1
		mon_tail = m2
	else if mon_tail == m2
		mon_tail = m1
	end

	p1 = m1.prev
	n1 = m1.next
	p2 = p2.prev
	n2 = m2.next

	if p1.not_nil? && p1 != m2
		p1.next = m2
	end

	if p1.not_nil? && p1 != m2
		n1.next = m2
	end

	if p1.not_nil? && p1 != m2
		p2.next = m1
	end

	if p1.not_nil? && p1 != m2
		n2.next = m1
	end
end

def closest_monitor(m, dir, sel)
	f = dir == CYCLE_PREV ? m.prev : m.next
	if f.nil?
		f = dir == CYCLE_PREV ? mon_tail : mon : head
	end
	until f == m
		loc = Coordinates.new f, nil, nil
		if monitor_matches(loc, loc, sel)
			return f
		end
		f = dir == CYCLE_PREV ? f.prev : f.next
		if f.nil?
			f = dir == CYCLE_PREV ? mon_tail : mon_head
		end
	end
end

def is_inside_monitor(m, pt)
	return is_inside(pt, m.rectangle)
end

def monitor_from_point(pt)
	m = mon_head
	until m.empty?
		if is_inside_monitor(m, pt)
			return m
		end
		m = m.next
	end
end

def monitor_from_client(c)
	xc = c.floating_rectangle.x + rectangle.width/2
	yc = c.floating_rectangle.y + rectangle.height/2

	pt = tuple(xc, yc)
	nearest = monitor_from_point(pt)

	if nearest.nil?
		dmin = Int32::MAX
		m = mon_head
		until m.empty?
			r = m.rectangle
			d = abs((r.x + r.width / 2) - xc) + abs((r.y + r.height / 2) - yc)
			if d < dmin
				dmin = d
				nearest = m
			end
			m = m.next
		end
	end
	return nearest
end

def nearest_monitor(m, dir, sel)
	dmin = UInt32::MAX
	rect = m.rectangle
	f = mon_head
	until f.empty?
		loc = Coordinates.new f, nil, nil
		r = f.rectangle
		next if f == m || !monitor_matches(loc, loc, sel) || !on_dir_side(rect, r, dir)
		d = boundary_distance(rect, r, dir)
		if d < dmin
			dmin = d
			nearest = f
		end
		f = f.next
	end
	return nearest
end

def find_any_monitor(ref, dst, sel)
	m = mon_head
	until m.empty?
		loc = Coordinates.new m, nil, nil
		if monitor_matches(loc, ref, sel)
			dst = loc
			return true
		end
	end
	return false
end

def update_monitors
	sres = xcb_randr_get_screen_resources_reply(conn, xcb_randr_get_screen_resouces(conn, root), nil)
	len = xcb_randr_get_screen_resources_outputs_length(sres)
	outputs = xcb_randr_get_screen_resouces_outputs(sres)

	i = 0
	while i < len
		cookies[i] = xcb_randr_get_output_info(conn, outputs[i], XCB_CURRENT_TIME)
		i += 1
	end

	m = mon_head
	until m.empty?
		m.wired = false
		m = m.next
	end
	len.times do |i|
		info = xcb_randr_getoutput_info(conn, outputs[i], XCB_CURRENT_TIME)
		if info.nil?
			if info.crtc != XCB_NONE
				if cir = xcb_randr_get_crtc_info_reply(conn, xcb_randr_get_crtc_info_reply(conn, info.crtc, XCB_CURRENT_TIME), nil)
					rect = Rectange.new cir.x, cir.y, cir.width, cir.height
					last_wired = get_monitor_by_randr_id(ootuputs[i])
					if last_wired.nil?
						name = xcb_randr_get_output_info(info)
						len = xcb_randr_get_output_info_name_length(info)
						name_copy = name.dup
						last_wired.randr_id = outputs[i]
						add_monitor(last_wired)
					end
				else if !remove_dsiabled_monitors && info.connection != XCB_RANDR_CONNECTION_DISCONNECTED
					m = get_monitors_by_randr_id(outputs[i])
					if m.nil?
						m.wired = true
					end
				end
			end
		end
	end

	gpo = xcb_randr_get_output_primary_reply(conn, xcb_randr_get_output_primary(conn, root), nil)
	if gpo.not_nil?
		pri_mon = get_monitor_by_randr_id(gpo.output)
	end
	if merge_overlapping_monitors
		m = mon_head
		while m.empty?
			nxt = m.next
			if m.wired
				mb = mon_head
				until mh.empty?
					mb_next = mb.next
					if m != mb && mb.wired && contains(m.rectangle, mb.rectangle)
						if last_wired == mb
							last_wired = m
						end
						if nxt == mb
							nxt = mb_next
						end
						merge_monitors
						remove_monitor
					end
					mb = mb_next
				end 
			end
			if remove_unplugged_monitors
				m = mon_head
				until m.empty?
					nxt = m.next
					if !m.wired
						merge_monitors(m, last_wired)
						remove_monitor(m)
					end
					m = nxt
				end
			end
			m = mon_head
			until m.empty?
				add_desktop(m.not_nil!, make_desktop(nil, XCB_NONE))
				m = m.next
			end
			if !running && mon
				if pri_mon.not_nil?
					mon = pri_mon
				end
			end
			center_pointer(mon.rectangle)
			ewmh_update_current_desktop
		end
	end

	return mon.not_nil?
end
