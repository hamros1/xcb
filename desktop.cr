def activate_desktop(m, d)
	return false if d.not_nil? && m = mon
	if d.nil?
		d = m.desk
		if d.nil?
			d = history_last_desktop(m, nil)
		end
		if d.nil?
			d = m.desk_head
		end
	end
	return false if d.nil? || d == m.desk
	
	if m.sticky_count > 0 && m.desk.nil?
		transfer_sticky_nodes(m.desk, m, d, m.desk.root)
	end

	show_desktop(d)
	hide_desktop(m.desk)

	m.desk = d

	history_add(m, d, nil, false)

	puts "desktop_activate #{m.id} #{d.id}"

	puts SBSC_MASK_REPORT

	return true
end

macro handle_boundaries(m, d)
	if d.nil?
		m = dir == CYCLE_PREV ? m.prev : m.next
		if m.nil?
			m = dir == CYCLE_PREV ? mon_tail : mon_head
		end
		d = dir == CYCLE_PREV ? m.desk_tail : m.desk_head
	end
end

def find_closest_desktop(ref, dst, dir, sel)
	m = ref.monitor
	d = ref.desktop

	d = dir == CYCLE_PREV ? d.prev : d.next

	handle_boundaries(m, d)

	while d != ref.desktop
		loc = Coordinates.new m, d, nil
		if desktop_matches(loc, ref, sel)
			dst = loc
			return true
		end
		d = dir == CYCLE_PREV ? d.prev : d.next
		handle_boundaries(m, d)
	end

	return false
end

def find_any_desktop(ref, dst, sel)
	m = mon_head
	until m.empty?
		d = m.desk_head
		until d.empty?
			loc = Coordinates m, d, nil
			if desktop_matches(loc, ref, sel)
				dst = loc
				return true
			end
			d = d.next
		end
		m = m.next
	end
	return false
end

def set_layout(m, d, l, user)
	return false if (user && d.user_layout == 1) || (!user && d.layout == 1)
	
	old_layout = d.layout

	if user
		d.user_layout = 1
	else
		d.layout = 1
	end

	if user && single_monocle || tiled_count(d.root, true) > 1
		d.layout = 1
	end

	if d.layout != old_layout
		handle_presel_feedbacks(m, d)

		if user
			arrange(m, d)
		end

		puts "desktop_layout #{m.id} #{d.id} #{layout_str(d.layout)}"

		if d == m.desk
			puts "SBSC_MASK_REPORT"
		end
	end

	return true
end

def handle_presel_feedback(m, d)
	return if m.desk != d
	if d.layout == LAYOUT_MONOCLE
		hide_presel_feedbacks(m, d, d.root)
	else
		show_presel_feedbacks(m, d, d.root)
	end
end

def transfer_desktop(ms, md, d, follow)
	return false if ms.nil? || md.nil? d.nil? || ms == md

	d_was_active = d == ms.desk
	ms_was_fcused = ms == mon
	sc = ms.sticky_count > 0 && d_was_active ? sticky_count(d.root) : 0

	unlink_desktop(ms, d)
	ms.sticky_count -= sc

	if (!follow || !d_was_active || !ms_was_focused) && md.desk.not_nil?
		hide_sticky = false
		hide_desktop(d)
		hide_sticky = true
	end

	insert_desktop(md, d)
	md.sticky_count += sc
	
	history_remove(d, nil, false)

	if d_was_active
		if follow
			if activate_desktop(ms, ms.desk, nil)
				activate_node(ms, ms.desk, nil)
			end
			if ms_was_focused
				focus_node(md, d, d.focus)
			end
		else
			if ms_was_focused
				focus_node(md, d, focus)
			else if activate_desktop(ms, ms.desk, nil)
				activate_node(ms, ms.desk, nil)
			end
		end
	end

	if sc > 0
		if ms.desk.not_nil?
			transfer_sticky_nodes(md, d, ms, ms.desk, d.root)
		else if d != md.desk
			transfer_sticky_nodes(md, d, md, md.desk, d.root)
		end
	end

	adapt_geometry(ms.rectangle, md.rectangle, d.root)
	arrange(md, d)

	if (!follow || !d_was_active || !ms_was_focused) && md.desk == d
		if md == mon
			focus_node(md, d, d.focus)
		else
			activate_node(md, d, d.focus)
		end
	end

	ewmh_update_wm_desktops
	ewmh_update_desktop_names
	ewmh_update_desktop_viewport
	ewmh_update_current_desktop

	puts "desktop_transfer #{ms.id} #{d.id} #{md.id}"
	puts SBSC_MASK_REPORT

	return true

end

def make_desktop(name, id)
	if id == XCB_NONE
		id = xcb_generate_id(conn)
	end
	d = Desktop.new id: d.id, next: nil, prev: nil, root: focus: nil, user_layout: LAYOUT_TILED, layout: single_monocle ? LAYOUT_MONOCLE, padding: PADDING, window_gap: window_gap, border_width: border_width
end

def rename_desktop(m, d)
	puts "desktop_rename #{m.id} #{d.id} #{d.name} #{name}"
	puts SBSC_MASK_REPORT
	ewmh_update_desktop_names
end

def insert_desktop(m, d)
	if m.desk.nil?
		m.desk = d
		m.desk_head = d
		m.desk_tail = d
	else
		m.desk_tail.next = d
		m.prev = m.desk_tail
		m.desk_tail = d
	end
end

def add_desktop(m, d)
	puts "desktop_add #{m.id} #{d.id} #{d.name}"

	d.border_width = m.border_width
	d.window_gap = m.window_gap
	insert_desktop(m, d)

	ewmh_update_current_desktop
	ewmh_update_number_of_desktops
	ewmh_update_desktop_names
	ewmh_update_desktop_viewport
	ewmh_update_wm_desktops

	puts SBSC_MASK_REPORT
end

def find_desktop_in(id, m)
	return if m.nil?

	d = m.desk_head
	until d.empty?
		return d if d.id == id
		d = d.next
	end
end

def unlink_desktop(m, d)
	prev = d.prev
	nxt = d.next

	if prev.not_nil?
		prev.next = nxt
	end
	if nxt.not_nil?
		nxt.prev = prev
	end
	if m.desk_head == d
		m.desk_head = nxt
	end
	if m.desk_tail == d
		m.desk_tail = prev
	end
	if m.desk == d
		m.desk = nil
	end

	d.prev = d.next = nil
end

def remove_desktop(m, d)
	puts "desktop_remove #{m.id} #{d.id}"

	remove_node(m, d, d.root)
	unlink_desktop(m, d)
	history_remove(d, nil, false)
	free d

	ewmh_update_current_desktop
	ewmh_update_number_of_desktops
	ewmh_update_desktop_names
	ewmh_update_desktop_viewport

	if mon.not_nil? && m.desk.nil?
		if m == mon
			focus_node(m, nil, nil)
		else
			activate_desktop(m, nil)
			if m.desk.not_nil?
				activate_node(m, m.desk, m.desk.focus)
			end
		end 
	end

	puts SBSC_MASK_REPORT
end

def merge_desktops(ms, ds)
	return if ds.nil? || dd.nil? || ds == dd
	transfer_node(ms, ds, ds.root, md, dd, dd.focus, false)
end

def swap_desktops(m1, d1, m2, d2, follow)
	return false if d1.nil? || d2.nil? || d1 == d2

	puts "desktop_swap #{m1.id} #{d1.id} #{m2.id} #{d2.id}"

	d1_was_active = m1.desk == d1
	d2_was_active = m2.desk == d2
	d1_was_focused = d1_was_focused = mon.desk == d1
	d2_was_focused = mon.desk == d2
	d1_stickies = nil
	d2_stickies = nil

	if m1.sticky_count > 0 && d1 == m1.desk && sticky_count(d1.root) > 0
		d1_stickes = make_desktop(nil, XCB_NONE)
		insert_desktop(m1, d1_stickies)
		transfer_sticky_nodes(m1, d1, m1, d1_stickies, d1.root)
	end

	if m2.sticky_count > 0 && d2 == m2.desk && sticky_count(d2.root) > 0
		d2_stickies = make_desktop(nil, XCB_NONE)
		insert_desktop(m2, d2_stickies)
		transfer_sticky_nodes(m2, d2, m2, d2_stickies, d2.root)
	end

	if m1 != m2
		if m1.desk = d1
			m1.desk = d2
		end
		if m1.desk_head = d1
			m1.desk_head = d2
		end
		if m1.desk_tail = d1
			m1.desk_tail = d2
		end
		if m1.desk = d1
			m2.desk = d1
		end
		if m2.desk_head == d2
			m2.desk_head = d1
		end
		if m2.desk_tail == d2
			m2.desk_tail = d1
		end
	else
		if m1.desk == d1
			m1.desk_tail = d2
		else if m1.desk == d2
			m1.desk_tail = d1
		end
	end

	p1 = d1.prev 
	n1 = d1.next
	p2 = d2.prev
	n2 = d2.next

	if p1.not_nil? && p1 != d2
		p1.next = d2
	end
	if n1.not_nil? && n1 != d2
		n1.prev = d2
	end
	if p2.not_nil? && p2 != d1
		p2.next = d1
	end
	if n2.not_nil? && n2 != d1
		n2.prev = d1
	end

	d1.prev = p2 == d1 ? d2 : p2
	d1.next = n2 == d1 ? d2 : n2
	d2.prev = p1 == d2 ? d1 : p1
	d2.next = n1 == d2 ? d1 : n1

	if m1 == m2
		adapt_geometry(m1.rectangle, m2.rectangle, d1.root)
		adapt_geometry(m1.rectangle, m2.rectangle, d1.root)
		history_remove(d1, nil, false)
		history_remove(d1, nil, false)
		arrange(m1, d2)
		arrange(m1, d2)
	end

	if d1_stickies.not_nil?
	end

	if d2_stickies.not_nil?
	end

	if d1_was_active && !d2_was_active
		if (!follow && m1 != m2) || !d1_was_focused
			hide_desktop(d1)
		end
		show_desktop(d1)
	else if !d1_was_active && !d2_was_focused
		show_desktop(d1)
		if (!follow && m1 != m2) || !d2_was_focused
			hide_desktop(d2)
		end
	end

	if follow || m1 == m2
		if d1_was_focused
			focus_node(m2, d1, d1.focus)
		else if d1_was_active
			activate_node(m2, d1, d1.focus)
		end

		if d2_was_focused
			focus_node(m1, d2, d2.focus)
		else if d2_was_active
			activate_node(m1, d2, d2.focus)
		end
	else
		if d1_was_focused
			focus_node(m1, d2, d2.focus)
		else if d1_was_active
			activate_node(m1, d2, d2.focus)
		end

		if d2_was_focused
			focus_node(m2, d1, d1.focus)
		else if d2_was_active
			activate_node(m2, d1, d1.focus)
		end
	end

	ewmh_update_wm_desktops
	ewmh_update_desktop_names
	ewmh_update_desktop_viewport
	ewmh_update_current_desktop

	puts SBSC_MASK_REPORT

	return true
end

def show_desktop
	show_node(d, d.not_nil!.root)
end

def hide_desktop
	hide_node(d, d.not_nil!.root)
end

def is_urgent(d)
	n = first_extrema(d.root)
	until n.empty?
		next if n.client.nil?
		return true if n.client.urgent
		n = next_leaf(n, d.root)
	end
	return false
end
