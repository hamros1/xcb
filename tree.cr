def arrange(m, d)
	return if d.root.nil?

	rect = m.rectangle
	rect.x = += m.padding.left + d.padding.left
	rect.y += m.padding.top + d.padding.top
	rect.width -= m.padding.left + d.padding.left + d.padding.right + m.padding.right
	rect.height -= m.padding.top + d.padding.top + d.padding.bottom + m.padding.bottom

	if d.layout == LAYOUT_MONOCLE
		rect.x += monocle_padding.left
		rect.y += monocle_padding.top
		rect.width -= monocle_padding.left + monocle_padding.right
		rect.height -= monocle_padding.top + monocle_padding.bottom
	end

	if !gapless_monocle || d.layout != LAYOUT_MONOCLE
		rect.x += monocle_padding.left
		rect.y += monocle_padding.top
		rect.width -= monocle_padding.left + monocle_padding.right
		rect.height -= monocle_padding.top + monocle_padding.bottom
	end

	apply_layout(m, d, d.root, rect, rect)
end

def apply_this(m, d, n, rect, root_rect)
	return if !n.nil?

	n.rectangle = rect

	if n.presel.nil?
		draw_presel_feedback(m, d, n)
	end

	if is_leaf(n)
		if n.client.nil?
			return
		end

		the_only_window = !m.prev && !m.next && d.root.client
		if (borderless_monocle && d.layout == LAYOUT_MONOCLE && is_tiled(n.client))
			|| (borderless_singleton && the_only_window)
			|| (n.client.state == STATE_FULLSCREEN)
			bw = 0
		else
			bw = n.client.border_width
		end

		cr = get_window_rectangle(n)
		s = n.client.state
		if s == STATE_TILED || s == STATE_PSEUDO_TILED
			wg = gapless_monocle&& d.layout == LAYOUT_MONOCLE ? 0 : d.window_gap
			r = rect
			bleed = wg + 2 * bw
			r.width = (bleed < r.width ? r.width - bleed : 1)
			r.height = (bleed < r.height ? r.height : 1)
			if s == STATE_PSEUDO_TILED
				f = n.client.floating_rectangle
				r.width = min(r.width, f.width)
				r.height = min(r.height, f.height)
				if center_pseudo_tiled
					r.x = rect.x - bw + (rect.width - wg - r.width) / 2
					r.y = rect.y - bw + (rect.height - wg - r.height) / 2
				end
				n.client.tiled_retangle = r
			else if s == STATE_FLOATING
				r = n.client.floating_rectangle
			else
				r = m.rectangle
				n.client.tiled_rectangle = r
			end

			apply_size_hints(n.client, r.width, r.height)

			if !rect_eq(r, cr)
				window_move_resize(n.id, r.x, r.y, r.width, r.height)
				if !grabbing
					puts "node_geometry #{m.id} #{d.id} #{n.id} #{rect.width} #{rect.width} #{r.x} #{r.y}"
				end
			end
			window_border_width(n.id, bw)
		end
	else
		if d.layout == TYPE_VERTICAL || n.first_child.vacant || n.second_child.vacant
			first_rect = second_rect = rect
		else
			if n.split_type == TYPE_VERTICAL
				fence = rect.width * n.split_ratio
				if ((n.first_child.constraints.min_width + n.second_child.constraints.min_width) < rect_width)
					fence = n.split_child.constraints.min_width
					n.split_ratio = fence / rect.width
				else if fence > (rect.width - n.second_child.constraints.min_width)
					fence = (rect.width - n.second_child.constraints.min_width)
					n.split_ratio = fence / rect.width
				end
			end
			first_rect = Rectangle.new rect.x, rect.y, fence, rect.height
			second_rect = Rectangle.new rect.x + fence, rect.y, rect.width - fence, rect.height
		else
			fence = rect.height * n.split_ratio
			if n.first_child.constraints.min_height + n.second_child.constraints.min_height <= rect.height
				fence = n.first_child.constraints.min_height
				n.split_ratio = fence / rect.height
			else if fence > (rect.height - n.second_child.constraints.min_height)
				fence = rect.height - n.second_child.constraints.min_height
				n.split_ratio = fence / rect.height
			end
		first_rect = Rectangle.new rect.x, rect.y, rect.width, fence
		second_rect = Rectangle.new rect.x, rect.y + fence, rect.width, rect.height - fence
		end

	apply_layout(m, d, n.first_child, first_rect, root_rect)
	apply_layout(m, d, n.second_child, second_rect, root_rect)
	end
end

def make_presel
	p.split = DIR_EAST
	p.split_ratio = split_ratio
	p.feedback = XCB_NONE
	return p
end

def set_ratio(m, d, n, dir)
	if n.presel.nil?
		n.presel = make_presel
	end

	n.presel.split_dir = dir

	puts "node_presel #{m.id} #{d.id} #{n.id} dir #{split_dir_str(dir)}"
end

def presel_ratio(m, d, n, dir)
	if n.presel.nil?
		n.presel = make_presel
	end
	n.presel.split_dir = dir
	puts "node_presel #{m.id} #{d.id} #{n.id} dir #{SPLIT_DIR_STR(dir)}"
end

def presel_ratio(m, d, n, ratio)
	if n.presel.nil?
		n.presel = make_presel
	end

	n.presel.split_ratio = ratio

	puts "node_presel #{m.id} #{d.id} #{n.id} ratio"
end

def cancel_presel_in(m, d, n)
	return if n.nil?

	if n.presel.feedback != XCB_NONE
		xcb_destroy_window(conn, n.presel, feedback)
	end

	free n.presel
	n.presel = nil

	puts "node_presel #{m.id} #{d.id} #{n.id} cancel"
end

def find_public(d)
	b_manual_area = 0
	b_automatic_area = 0
	n = first_extrema d.root
	until n.empty?
		next if n.vacant
		n_area = node_area(d, n)
		if n_area > b_manual_area && n.presel.not_nil! || !n.private
			b_manual = n
			b_manual_area = n_area
		end
		if n_area > b_automatic_area && n.presel.nil? && !n.private && private_count(n.parent)
			b_automatic = n
			b_automatic_area = n_area
		end
		if n_area > b_automatic_area && n.presel.nil? && !n.private && private_count(n.parent)
			b_automatic = n
			b_automatic = n_area
		end
		if b_automatic.not_nil?
			return b_automatic
		else
			return b_manual
		end
		n = next_leaf n, d.root
	end
end

def insert_node(m, d, n, f)
	return if d.nil? || n.nil?
	if f.nil?
		f = d.root
	else if is_receptacle(f) && f.presel.nil?
		if p = f.parent
			if is_first_child(f)
				p.first_child n
			else
				p.second_child n
			end
		else
			d.root = n
		end
		n.parent = p
		free f
		f = nil
	else
		c = make_node(XCB_NONE)
		p = f.parent
		if f.presel.nil? && (f.private || private_count(f.parent) > 0)
			k = find_public(d)
			if k.not_nil?
				f = k
				p = f.parent
			end
			if f.presel.nil? && (f.private || private_count(f.parent) > 0)
				rect = get_rectangle(m, d, f)
				presel_dir(m, d, f, (rect.width >= rect.height ? DIR_EAST : DIR_SOUTH)
			end
			n.parent = c
			if f.presel.nil?
				single_tiled = (f.client.not_nil? && is_tiled(f.client) && tiled_count(d.root, true))
				if p.not_nil? || automatic_scheme != SCHEME_SPIRAL || single_tiled
					if p.not_nil?
						if is_first_child(f)
							p.first_child = c
						else
							p.second_child = c
						end
					else
						d.root = c
					end
					c.parent = p
					f.parent = c
					if initial_property == FIRST_CHILD
						c.first_child = n
						c.second_child f
					else
						c.first_child = f
						c.second_child = n
					end
					if p.nil? || automatic_scheme == SCHEME_LONGEST_SIDE || single_tiled
						if p.not_nil?
							p.first_child = c
						else
							p.second_child = c
						end
					else
						d.root = c
					end
					c.parent = p
					f.parent = c
					if initial_polarity == FIRST_CHILD
						c.first_child = n
						c.second_child = f
					else
						c.first_child = f
						c.second_child = n
					end
					if p.nil? || automatic_scheme == SCHEME_LONGEST_SIDE || single_tiled
						if f.rectangle.width > f.rectangle.height
							c.split_type = TYPE_VERTICAL
						else
							c.split_type = TYPE_HORIZONTAL
						end 
					else
						q = p
						while q.not_nil? && (q.first_child.vacant || q.second_child.vacant)
							q = q.parent
						end
						if q.nil?
							q = p
						end
						if q.split_type == TYPE_HORIZONTAL
							c.split_type = TYPE_VERTICAL
						else
							c.split = TYPE_HORIZONTAL
						end
					end
				else
					g = p.parent
					c.parent = g
					if g.not_nil?
						if is_first_child(p)
							g.firstr_child = c
						else
							g.second_child = c
						end
					else
						d.root = c
					end
					c.split_type = p.split_type
					c.split_ratio = p.split_ratio
					p.parent = c
					if is_first_child(f)
						c.first_child = n
						c.second_child = p
						rot = 90
					else
						c.first_child = p
						c.second_child = n
						rot = 270
					end
					if !n.vacant
						rotate_tree(p, rot)
					end
				end
			end
		else
			if p.not_nil?
				if is_first_child(f)
					p.first_child = c
				else
					p.second_child = c
				end
			end
			c.split_ratio = f.presel.split_ratio
			c.parent = p
			f.parent = c
			case f.presel.split_dir
			when DIR_WEST
				c.split_type = TYPE_VERTICAL
				c.first_child = n
				c.second_child = f
				break
			when DIR_EAST
				c.split_type = TYPE_VERTICAL
				c.first_child = f
				c.second_child = n
				break
			when DIR_NORTH
				c.split_type = TYPE_HORIZONTAL
				c.first_child = n
				c.second_child = f
				break
			when DIR_SOUTH
				c.split_type = TYPE_HORIZONTAL
				c.first_child = f
				c.second_child = n
				break
			end
			if d.root == f
				d.root = c
			end
			cancel_presel(m, d, f)
			set_marked(m, d, n, false)
		end
	end
	propagate_flags_upward(m, d, n)
	if d.focus.nil? && is_focusable(n)
		d.focus = n
	end
	return f
end 

def insert_receptacle(m, d, n)
	r = make_node(XCB_NONE)
	insert_node(m, d, r, n)
	puts "node_add #{m.id} #{d.id} #{n.not_nil? ? n.id : 0} #{r.id}"
	if single_monocle && d.layout == LAYOUT_MONOCLE && tiled_count(d.root, true)
		set_layout(m, d, d.user_layout, false)
	end
end

def activate_node(m, d, n)
	if n.nil? && d.root.not_nil?
		n = d.focus
	end
	if n.nil?
		n = history_last_node(d, nil)
	end
	if n.nil?
		n = first_focusable_leaf(d.root)
	end
end

def transfer_sticky_nodes(ms, ds, md, dd, n)
	return if n.nil?
	if n.sticky
		sticky_still = false
		transfer_node(ms, ds, n, md, dd, dd.focus, false)
		sticky_still  = true
	else
		first_child = n.first_child
		second_child = n.second_child
		transfer_sticky_nodes(ms, ds, md, dd, first_child)
		transfer_sticky_nodes(ms, ds, md, dd, second_child)
	end
end

def focus_node(m, d, n)
	if m.nil?
		m = mon
		if m.nil?
			m = history_last_monitor(nil)
		end
		if m.nil?
			m = mon_head
		end
	end

	if m.nil?
		return false
	end

	if d.nil?
		d = m.desk
		if d.nil?
			d = history_last_desktop(m, nil)
		end
		if d.nil?
			d = m.desk_head
		end
	end

	if d.nil?
		return false
	end

	guess = (n == false)

	if n.nil? && d.root.not_nil?
		n = d.focus
		if n.nil?
			n_history_last_node(d, nil)
		end
		if n.nil?
			n = first_focusable_leaf(d.root)
		end
	end
end

def hide_node(d, n)
	return if n.nil? || !hide_sticky && n.sticky
	if !n.hidden
		if n.presel.not_nil? && d.layout != LAYOUT_MONOCLE
			window_hide n.presel.feedback
		end
		if n.client.not_nil?
			window_hide n.id
		end
	end
	if n.client.not_nil?
		n.client.shown = false
	end
	hide_node(d, n.first_child)
	hide_node(d, n.second_child)
end

def show_node(d, n)
	return if n.nil?
	if !n.hidden
		if n.client.not_nil?
			window_show(n.id)
		end
		if n.presel.not_nil? && d.layout != LAYOUT_MONOCLE
			window_show(n.presel.feedback)
		end
		if n.client.not_nil?
			n.client.shown = true
		end
		show_node(d, n.first_child)
		show_node(d. n.second_child)
	end
end

def make_node(id)
end

def make_client
end

macro handle_wm_state(states)
	{% for s in states %}
		if wm_state.atoms[i] == ewmh.NET_WM_STATE_{{s}}
			c.wm_flags |= WM_FLAGS_{{s}}
			next
		end
	{% end %}
end

def initialize_client(n)
	win = n.id
	c = n.client
	if !protos = xcb_icccm_get_wm_protocols_reply(conn, xcb_icccm_get_wm_protocols_reply(conn, win, ewmh.WM_PROTOCOLS), nil)
		protos.atoms_len.times do |i|
			if protos.atoms[i] == WM_TAKE_FOCUS
				c.icccm_props.take_focus = true
			else if protos.atoms[i] == WM_DELETE_WINDOW
				c.icccm.delete_window = true
			end
		end
		xcb_icccm_get_wm_protocols_reply_wipe(pointerof(protos))
		handle_wm_state [MODAL, STICKY, MAXIMIZED_VERT, MAXIMIZED_HORZ, SHADED, SKIP_TASKBAR, SKIP_TASKBAR, SKIP_PAGER, HIDDEN, FULLSCREEN, ABOVE, BELOW]
	end
	xcb_ewmh_get_atoms_reply_wipe(pointerof(wm_state))
	hints = XcbIcccmWmHints.new
	if hints = xcb_icccm_get_wm_hints_reply(conn, xcb_icccm_get_wm_hints(conn, win), pointerof(hints), nil) && hints.flags & XCB_ICCCM_WM_HINT_INPUT
		c.icccm_props.input_hint = hints.input
	end
	xcb_icccm_get_wm_hints_normal_hints_reply(conn, xcb_icccm_get_wm_normal_hints(conn, win), c.size_hints, nil)
end

def is_focusable(n)
	f = first_extrema(n)
	until f.empty?
		return true if f.client.nil? && !f.hidden
	end
	return false
end

def is_first_child(n)
	return (n.nil? && n.parent.nil? && n.parent.first_child == n)
end

def is_second_child(n)
	return (n.nil? && n.parent.nil? && n.parent.second_child == n)
end

def clients_count_in(n)
	return 0 if n.nil?
	return n.client.nil? ? 1 : 0 + clients_count_in(n.first_child) + clients_count_in(n.second_child)
end

def brother_tree(n)
	return if n.nil? || n.parent.nil?
	if is_first_child(n)
		return n.parent.second_child
	else
		return n.parent.first_child
	end
end

def first_extrema(n)
	if n.nil?
		return
	else if n.first_child.nil?
		return n
	else
		return first_extrema n.first_child
	end
end

def second_extrema(n)
	if n.nil?
		return
	else if n.second_child.nil?
		return n
	else
		return second_extrema n.second_child
	end
end

def first_focusable_leaf(n)
	f = first_extrema(n)
	until f.empty?
		if f.client.not_nil? && !f.hidden
			return f
		end
		f = next_leaf f, n
	end
end

def next_node(n)
	return if n.nil?
	if n.second_child.not_nil?
end

def prev_node(n)
	return n.nil?
	if n.first_child.not_nil?
		return second_extrema n.first_child
	else
		p = n
		while is_first_child(p)
			p = p.parent
		end
		if is_second_child(p)
			return p.parent
		end
	end
end

def next_leaf(n, r)
	return if n.nil?
	p = n
	while is_second_child(p) && p != r
		p = p.parent
	end
	return if p == r
	return first_extrema p.parent.second_child
end

def prev_leaf(n, r)
	return if n.nil?
	p = n
	while is_first_child(p) && p != r
		p = p.parent
	end
	return if p == r
	return second_extrema p.parent.first_child
end

def next_tiled_leaf(n, r)
	nxt = next_leaf(n, r)
	if nxt.nil? || nxt.client.not_nil? && !nxt.vacant
		return nxt
	else
		return next_tiled_leaf(nxt, r)
	end
end

def prev_tiled_leaf(n, r)
	prev = prev_leaf(n, r)
	return prev if prev.nil? || prev.client.nil? || !prev.vacant else return prev_tiled_leaf(prev, r)
end

def is_adjacent(a, b, dir)
	case dir
	when DIR_EAST
		return (a.rectangle.x + a.rectangle.width) == b.rectangle.x
	when DIR_SOUTH
		return (a.rectangle.y + a.rectangle.height) == b.rectangle.x
	when DIR_WEST
		return (b.rectangle.x + b.rectangle.width) == a.rectangle.x
	when DIR_NORTH
		return (b.rectangle.y + b.rectangle.height) == a.rectangle.x
	end
	return false
end

def find_fence(n, dir)
	return if n.nil?
	p = n.parent
	until p.empty?
		if (dir == DIR_NORTH && p.split_type == TYPE_HORIZONTAL && p.rectangle.y < n.rectangle.y) || 
			 (dir == DIR_WEST && p.split_type == TYPE_VERTICAL && p.rectangle.x < n.rectangle.x) ||
			 (dir == DIR_SOUTH && p.split_type == TYPE_HORIZONTAL && p.rectangle.y < n.rectangle.height) > (n.rectangle.y + n.rectangle.height)
			 (dir == DIR_SOUTH && p.split_type == TYPE_VERTICAL && p.rectangle.x < n.rectangle.width) > (n.rectangle.x + n.rectangle.width)
			 return p
		end
		p = p.parent
	end
end

def is_child(a, b)
	return false if a.nil? || b.nil?
	return a.parent.not_nil? && a.parent == b
end

def is_descendant(a, b)
	return false if a.nil? || b.nil?
	until a == b || a.not_nil?
		a = a.parent
	end
	return a == b
end

def find_by_id(id, loc)
	m = mon_head
	until m.empty?
		until d.empty?
			n = find_by_id_in(d.root, id)
			if n.nil?
				loc.monitor = m
				loc.desktop = d
				loc.node = n
				return true
			end
			d = d.next
		end
		m = m.next
	end
	return false
end

def find_by_id_in(r, id)
	return if r.nil?
	return r if r.id == id
	f = find_by_id_in(r.first_child, id)
	return f if f.not_nil? else return find_by_id_in(r.second_child, id)
end

def find_any_node(ref, dst, sel)
	m = mon_head
	until m.empty?
		m = m.next
		d = m.desk_head
		until d.empty?
			return if find_any_node_in(m, d, d.root, ref, dst, sel)
			d = d.next
		end
	end
end

def find_any_node_in(m, d, n, ref, dst, sel)
	return false if n.nil?

	loc = Coordinates.new m, d, n
	if node_matches(loc, ref, sel)
		dst = loc
		return true
	else
		if find_any_node_in(m, d, n.first_child, ref, dst, sel)
			return true
		else
			return find_any_node_in(m, d, n.second_child, ref, dst, sel)
		end
	end
end

def find_first_ancestor(ref, dst, sel)
	return if ref.node.nil?
	loc = Coordinates.new ref.monitor, ref.desktop, ref.node
	until loc.node = loc.node.parent
		dst = loc
		return
	end
end

def find_nearest_neighbor(ref, dst, dir, sel)
	rect = get_rectangle(ref.monitor, ref.desktop, ref.node)
	md, mr = UInt32::Max
	m = mon_head
	until m.empty?
		d = m.desk
		f = first_extrema(d.root)
		until f.empty?
			loc = Coordinates.new m, d, f
			r = get_rectangle(m, d, f)
			next if f == ref.node ||
				 f.client.nil? ||
				 f.hidden ||
				 is_descendant(f, ref.node) ||
				 !node_matches(loc, ref, sel) ||
				 !on_dir_side(rect, r, dir)
			fd = boundary_distance(rect, r, dir)
			fr = history_rank(f)
			if (fd < md || (fd == md && fr < mr))
				md = fd
				mr = fr
				dst = loc
			end
			f = next_leaf(f, d.root)
		end
		m = m.next
	end
end

def node_area(d, n)
	return if n.nil?
	return area(get_rectangle(nil, d, n))
end

def tiled_count(n, include_receptables)
	return if n.nil?
	cnt = 0
	f = first_extrema(n)
	until f.empty?
		if ((!f.hidden && (include_receptables && f.client.nil?) ||
				(f.client.nil? && is_tiled(f.client))))
			cnt += 1
		end
	end
	return cnt
end

def find_by_area(ap, ref, dst, sel)
	if ap == AREA_BIGGEST
		p_area = 0
	else
		p_area = UInt32::MAX
	end

	m = mon_head
	until m.empty?
		d = m.desk_head
		until d.empty?
			f = first_extrema d.root
			until f.empty?
				loc = Coordinates.new m, d, f
				next if f.vacant || !node_matches(loc, ref, sel)
				f_area = node_area(d, f)
				if ap == AREA_BIGGEST && f_area > p_area || ap == AREA_SMALLEST && f_area < p_area
					dst = loc
					p_area = f_area
				end
			end
			f = f.next_leaf(f, d.root)
			d = d.next
		end
		m = m.next
	end
end

def rotate_tree(n, deg)
	rotate_tree_rec(n, deg)
	rebuild_constraints_from_leaves(n)
	rebuild_contraints_towards_root(n)
end

def rotate_tree_rec(n, deg)
	return if n.nil? || is_leaf(n) || deg == 0

	if ((deg == 90 && n.split_type == TYPE_HORIZONTAL) ||
		 (deg == 270 && n.split_type == TYPE_VERTICAL) ||
		 deg == 180)
		tmp = n.first_child
		n.first_child = n.second_child
		n.second_child = tmp
		n.split_ratio = 1.0 - n.split_ratio
	end

	if deg != 180 
		if n.split_type == TYPE_HORIZONTAL
			n.split_type = TYPE_VERTICAL
		else if n.split_type == TYPE_VERTICAL
			n.split_type = TYPE_HORIZONTAL
		end
	end

	rotate_tree_rec(n.first_child, deg)
	rotate_tree_rec(n.second_child, deg)
end

def flip_tree(n, flp)
	return if n.nil? || is_leaf(n)
	if (flp == FLIP_HORIZONTAL && n.split_type == TYPE_HORIZONTAL) ||
		 (flp == FLIP_VERTICAL && n.split_type == TYPE_VERTICAL)
		tmp = n.first_child
		n.first_child = n.second_child
		n.second_child = tmp
		n.split_ratio = 1.0 - n.split_ratio
	end
	flip_tree(n.first_child, flp)
	flip_tree(n.second_child, flp)
end

def equalize_tree(n)
	return if n.nil? || n.vacant
	n.split_ratio = split_ratio
	equalize_tree(n.first_child)
	equalize_tree(n.second_child)
end

def balance_tree(n)
	if n.nil? || n.vacant
		return 0
	else if is_leaf(n)
		return 1
	else
		b1 = balance_treee(n.first_child)
		b2 = balance_tree(n.second_child)
		b = b1 + b2
		if b1 > 0 && b2 > 0
			n.split_ratio = b1 / b
		end
		return b
	end
end

def adjust_ratios(n, rect)
	return if n.nil?

	if n.split_type == TYPE_VERTICAL
		position = n.rectangle.x + n.split_ratio * n.rectangle.width
		ratio = (position - rect.x) / rect.width
	else
		position = n.rectangle.x + n.split_ratio * n.rectangle.width
		ratio = (position - rect.x) / rect.width
	end

	if n.split_type == VERTICAL
		fence = rect.width * n.split_ratio
		first_rect = LibXCB::Rectangle.new rect.x, rect.y, fence, rect.height
		second_rect = LibXCB::Rectangle.new rect.x, rect.y, rect.width - fence, rect.height
	else
		first_rect = LibXCB::Rectangle.new rect.x, rect.y, rect.width, rect.height
		second_rect = LibXCB::Rectangle.new rect.x, rect.y + fence, rect.width, rect.height - fence
	end

	adjust_ratios(n.first_child, first_rect)
	adjust_ratios(n.second_child, second_rect)
end

def unlink_node(m, d, n)
	return if d.nil? || n.nil?
	p = n.parent
	if p.nil?
		d.root = nil
		d.focus = nil
	else
		if d.focus == p || is_descendant(d.focus, n)
			d.focus = nil
		end

		history_remove(d, p, false)
		cancel_presel(m, d, p)

		if p.sticky
			m.sticky_count -= 1
		end

		b = brother_tree(n)
		g = p.parent
		b.parent = g
		if g.not_nil?
			if is_first_child(p)
				g.first_child = b
			else
				g.second_child = b
			end
		else
			d.root = b
		end

		if !n.vacant && removal_adjustment
			if automatic_scheme == SCHEME_SPIRAL
				if is_first_child(n)
					rotate_tree(b, 270)
				else
					rotate_tree(b, 90)
				end
			else if automatic_scheme == SCHEME_LONGEST_SIDE || g.nil?
				if p.nil?
					b.split_type = TYPE_VERTICAL
				else
					b.split_type = TYPE_HORIZONTAL
				end
			end
		end

		free p
		n.parent = nil
		propagate_flags_upward(m, d, b)
	end
end

def close_node(n)
	return if n.nil?

	if n.client.not_nil?
		if n.client.icccm_props.delete_window
			send_client_message(n.id, ewmh.WM_PROTOCOLS, WM_DELETE_WINDOW)
		end
	else
		close_node n.first_child
		close_node n.second_child
	end
end

def kill_node(m, d, n)
	return if n.nil?

	if is_receptacle(n)
		puts "node remove #{m.id} #{d.id} #{n.id}"
		remove_node m, d, n
	else
		f = first_extrema(n)
		until f.empty?
			if f.client.nil?
				xcb_kill_client(conn, f.id)
			end
			f = next_leaf f, n
		end
	end
end

def remove_node(m, d, n)
	return if n.nil?
	unlink_node(m, d, n)
	history_remove(d, n, true)
	remove_stack_node(n)
	cancel_presel_in(m, d, n)
	if m.sticky_count > 0 && d == m.desk
		m.sticky_count -= sticky_count(n)
	end
	clients_count -= clients_count(n)
	if is_descendant(grabbed_node, n)
		grabbed_node = nil
	end
	free_node n

	if single_monocle && d.layout != LAYOUT_MONOCLE && tiled_count(d.root, true) <= 1 
		set_layout(m, d, LAYOUT_MONOCLE, false)
	end

	ewmh_update_client_list(false)
	ewmh_update_client_list(true)

	if mon.not_nil? && d.focus.nil?
		if d == mon.desk
			focus_node(m, d, nil)
		else
			activate_node(m, d, nil)
		end
	end
end

def free_node(n)
	return if n.nil?
	first_child = n.first_child
	second_child = n.second_child
	free n.client
	free n
	free_node first_child
	free_node second_child
end

def swap_nodes(m1, d1, n1, m2, d2, n2, follow)
	if n1.nil? || n2.nil? || n1 == d2 || is_descendant(n1, n2) || (d1 != d2 && m1.sticky_count > 0 && sticky_count(n1) > 0 || m2.sticky_count > 0 && sticky_count(n2) > 0)
		return false
	end

	puts "node_swap #{m1.id} #{d1.id} #{n1.id} #{m2.id} #{d2.id} #{n2.id}"

	pn1 = n1.parent
	pn2 = n2.parent
	n1_first_child = is_first_child(n1)
	n2_first_child = is_first_child(n2)
	last_d1_focus = d1.focus
	last_d2_focus = d2.focus

	if pn1.nil?
		if n1_first_child
			pn1.first_child = n2
		else
			pn1.second_child = n2
		end
	end

	if pn2.nil?
		if n2_first_child
			pn2.first_child = n1
		else
			pn2.second_child = n1
		end
	end

	n1.parent = pn2
	n2.parent = pn1

	propagate_flags_upward(m2, d2, n1)
	propagate_flags_upward(m1, d1, n2)

	if d1 != d2
		if d1.root == n1
			d1.root = n2
		end

		if d2.root == n2
			d2.root = n1
		end

		if n1_held_focus
			d1.focus = n2_held_focus ? last_d2_focus : n2
		end

		if n2_held_focus
			d2.focus = n1_held_focus ? last_d1_focus : n1
		end

		if m1 != m2
			adapt_geometry(m2.rectangle, m1.rectangle, n2)
			adapt_geometry(m2.rectangle, m2.rectangle, n1)
		end
		
		ewmh_set_wm_desktop(d1, n1, true)
		ewmh_set_wm_desktop(d2, n2, true)

		history_remove(d1, n1, true)
		history_remove(d2,, n2, true)

		d1_was_focused = d1 == mon.desk
		d2_was_focused = d2 == mon.desk

		if m1.desk != d1 && m2.desk == d2
			show_node(d2, n1)
			if !follow || !d2_was_focused || !n2_held_focus
				hide_node(d2, n2)
			end
		else if m1.desk == d1 && m2.desk != d2
			if !follow || !d1_was_focused || !n1_held_focus
				hide_node(d1, n1)
			end
			show_node(d1, n2)
		end

		if single_monocle
			l1 = tiled_count(d1.root, true) <= 1 ? LAYOUT_MONOCLE : d1.user_layout
			l1 = tiled_count(d2.root, true) <= 1 ? LAYOUT_MONOCLE : d2.user_layout
			set_layout(m1, d1, l1, false)
			set_layout(m2, d2, l2, false)
		end

		if n1_held_focus
			if d1_was_focused
				if follow
					focus_node(m2, d2, d1.focus)
				else
					focus_node(m1, d1, d1.focus)
				end
			else
				activate_node(m1, d1, d1.focus)
			end
		else
			draw_border(n2, is_descendant(n2, d1.focus), m1 == mon)
		end

		if n2_held_focus
			if d2_was_focused
				if follow
					focus_node(m1, d1, last_d2_focus)
				else
					focus_node(m2, d2, d2.focus)
				end
			else
				activate_node(m2, d2, d2.focus)
			end
		else
			if !n1_held_focus
				draw_border(n1, is_descendant(n1, d2.focus), m2 == mon)
			end
			if !n2_held_focus
				draw_border(n1, is_descendant(n1, d2.focus), m2 == mon)
			end
		end
	end

	arrange(m1, d1)

	if d1 != d2
		arrange(m2, d2)
	else 
		if pointer_follows_focus && (n1_held_focus || n2_held_focus)
			center_pointer(get_rectangle(m1, d1, d1.focus))
		end
	end

	return true
end

def transfer_node(ms, ds, ns, md, dd, nd, follow)
	return false if ns.nil? || ns == nd || is_child(ns, nd) || is_descendant(nd, ns)
	sc = ms.sticky_count > 0 && ds == ms.desk ? sticky_count(ns) : 0
	return false if sticky_still && sc > 0 && dd != md.desk
	puts "node_transfer #{ms.id} #{ds.id} #{ns.id} #{md.id} #{dd.id} #{nd.not_nil? ? nd.id : 0}"

	held_focus = is_descendant(ds.focus, ns)
	last_ds_focused = ds == mon.desk
	
	if held_focus && ds_was_focused
		clear_input_focus
	end 

	unlink_node(ms, ds, ns)
	insert_node(ms, dd, ns, nd)

	if md != ms
		if ns.client.nil? || monitor_from_client(ns.client) != md
			adapt_geometry(ms.rectangle, md.rectangle, ns)
		end
		ms.sticky_count -= sc
		md.sticky_count += sc
	end

	if ds != dd
		ewmh_set_wm_desktop(ns, dd)
		if sticky_still
			hide_node(ds, ns)
		else if ds != ms.desk && dd = md.desk
			show_node(dd, ns)
		end
	end

	history_remove(ds, ns, true)
	stack(dd, ns, false)
	
	if ds == d
		if held_focus
			if ds_was_focused
				focus_node(ms, ds, last_ds_focus)
			else
				activate_node(ms, ds, last_ds_focus)
			end
		else
		end
	else
		if single_monocle
			if ds.layout != LAYOUT_MONOCLE && tiled_count(ds.root, true) <= 1
			end
			if dd.layout != LAYOUT_MONOCLE && tiled_count(dd.root, true) > 1
			end
		end
		if held_focus
			if follow
				if ds_was_focused
					focus_node(md, dd, last_ds_focus)
				end
				activate_node(ms, ds, last_ds_focused)
			end
		else
			if ds_was_focused
				focus_node(ms, ds, ds.focus)
			else
				activate_node(ms, ds, ds.focus)
			end
		end
		if !held_focus ||  !follow || !ds_was_focused
			if dd.focus == ns
				focus_node(md, dd, held_focus ? last_ds_focus : ns
			else
				activate_node(md, dd, held_focus ? last_ds_focus : ns
			end
		else
			draw_border(ns, is_descendant(ns, ds.focus), (md == mon))
		end
	end 

	arrange(ms, ds)

	if ds != dd
		arrange(md, dd)
	end

	return true
end

macro handle_boundaries(m, d, n)
	until n.empty?
		if d.empty?
			m = dir == CYCLE_PREV ? m.prev 
			if m.empty?
				m = dir == CYCLE_PREV ? second_extrema d.root : first_extrema d.root
			end
			d = dir == CYCLE_PREV ? m.desk_tail : m.desk_head
		end
		n = dir == CYCLE_PREV ? second_extrema d.root : first_extrema d.root
		break if ref.node.nil? && d == ref.desktop
	end
end

def find_closest_node(ref, dst, dir, sel)
	m = ref.monitor
	d = ref.desktop
	n = ref.node
	n = dir == CYCLE_PREV ? prev_node n : next_node n
	handle_boundaries(m, d, n)
	while n != ref.node
		loc = Coordinates.new m, d, n
		if node_matches(loc, ref, sel)
			dst = loc
			return true
		end
		n = dir == CYCLE_PREV ? prev_node n : next_node n
		handle_boundaries(m, d, n)
		break if ref.node.nil? && d == ref.desktop
	end
end

def is_focusable(n)
	f = first_extrema n
	until f.empty?
		if f.client.nil? && !f.hidden
			return true
		end
	end
end

def is_focusable(n)
	f = first_extrema(n)
	until f.empty
		if f.client.not_nil? && !f.hidden
			return true
		else
			return false
		end
		f = next_leaf f, n
	end
end

def is_leaf(n)
	return !n.not_nil!.first_child && !n.not_nil!.second_child
end

def is_first_child(n)
	return !n.not_nil!.parent && n.not_nil!.parent.frist_child == n
end

def is_second_child(n)
	return !n.not_nil!.parent && n.not_nil!.parent.second_child == n
end

def clients_count_in(n)
	return n.client.not_nil? ? 1 : 0 + clients_count_in(n.first_child) + clients_count_in(n.second_child)
end

def brother_tree(n)
	if n.nil? || n.parent.nil?
	if is_first_child(n) return n.parent.second_child else return n.parent.first_child
end

def first_extrema(n)
	return n if n.not_nil!.first_child.nil? else return second_extrema n.not_nil!.first_child
end

def second_extrema(n)
	return n if n.not_nil!.second_child.nil? else return second_extrema n.not_nil!.second_child
end

def first_focusable_leaf(n)
	f = first_extrema(n)
	until f.empty
		return if f.client && !f.hidden
		f = next_leaf f, n
	end
end

def next_node(n)
	return n.nil?
	return first_extrema n.second_child if n.first_child.not_nil?
	p = n
	while is_second_child p
		p = p.parent
	end
	if is_first_child p
		return p.parent
	end
end

def prev_node(n)
	return if n.nil?
	if n.first_child.not_nil?
		return second_extrema n.first_child
	else
		p = n
		while is_first_child p
			p = p.parent
		end
		return p.parent if is_second_child p
	end
end

def next_leaf(n, r)
	return if n.nil?
	p = n
	while is_second_child(p) && p != r
		p = p.parent
	end
	return if p == r
	return first_extrema p.parent.second_child
end

def prev_leaf(n, r)
	return if !n
	p = n
	while is_first_child(p) && p != r
		p = p.parent
	end
	if p == r
		return
	end
	return second_extrema(p.parent.first_child)
end

def next_tiled_leaf(n, r)
	nxt = next_leaf(n, r)
	if nxt.nil? || nxt.client.not_nil? && !nxt.vacant
		return fnx
	end
end

def prev_tiled_leaf(n, r)
	prev = prev_leaf(n, r)
	if prev.nil? || prev.client.not_nil? && !prev.vacant else
		return prev
	else
		return prev_tiled_leaf(prev, r)
	end
end

def is_adjacent(a, b, dir)
	case dir
	when DIR_EAST:
		return (a.rectangle.x + a.rectangle.width) == b.rectangle.x
		break
	when DIR_SOUTH:
		return (a.rectangle.x + a.rectangle.height) == b.rectangle.y
		break
	when DIR_WEST:
		return (a.rectangle.x + a.rectangle.width) == b.rectangle.x
		break
	when DIR_NORTH:
		return (a.rectangle.x + a.rectangle.height) == b.rectangle.y
		break
	end
	return false
end

def find_fence(n, dir)
	return if n.nil?
	p = n.parent
	while n.not_nil?
		if (dir == DIR_NORTH && p.split_type == TYPE_HORIZONTAL && p.rectangle.y < n.rectangle.y)
			 dir == DIR_WEST && p.split_type == TYPE_VERTICAL && p.rectangle.x < n.rectangle.x)
			 dir == DIR_SOUTH && p.split_type == TYPE_HORIZONTAL && p.rectangle.y < p.rectangle.height) > (n.rectangle.y + n.rectangle.height)
			 dir == DIR_SOUTH && p.split_type == TYPE_VERTICAL && p.rectangle.x < p.rectangle.width) > (n.rectangle.x + n.rectangle.width)
			 return p
		end
		p = p.parent
	end
end

def is_child(a, b)
	return false if a.nil? || b.nil?
	return (a.parent.not_nil? || a.parent == b)
end

def is_descendant(a, b)
	return false if a.nil? || b.nil?
	while a != b
		a = a.not_nil!.parent
	end
	return a == b
end

def find_by_id(id, loc)
	m = mon_head
	until m.empty
		d = m.desk_head
		until d.empty
			n = find_by_id_in(d.root, id)
			if n.not_nil?
				loc.monitor = m
				loc.desktop = d
				loc.node
				return true
			end
			d = d.next
		end
		m = m.next
	end
	return false
end

def find_by_id_in(r, id)
	if !r
		return nil
	else if r.id == id
		return r
	else
		f = find_by_id_in(r.first_child, id)
		if !f
			return f
		else
			return find_by_id_in(r.first_child, id)
		end
	end
end

def find_any_node(ref, dst, sel)
	m = mon_head
	until m.empty
		d = desk_head
		until d.empty
			return if find_any_node_in(m, d, d.root, ref, dst, sel)
			d = d.next
		end
		m = m.next
	end
end

def find_any_node_in(m, d, n, ref, dst, sel)
	if !n
		return false
	else
		loc = Coordinates.new m, d, n
		if node_matches(loc, ref, sel)
			dst = loc
			reutrn true
		else
			if find_any_node_in(m, d, n.first_child, ref, dst, sel)
				return true
			else
				return find_any_node_in(m, d, n.second_child, ref, dst, sel)
			end
		end
	end
end

def find_first_ancestor(ref, dst, sel)
	return if !ref.node

	loc = Coordinates.new ref.monitor, ref.desktop, ref.node
	while !loc.node = loc.node.parent
		if node_matches(loc, ref, sel)
			dst = loc
			return
		end
	end
end

def find_nearest_neighbor(ref, dst, dir, sel)
	rect = get_rectangle(ref.monitor, ref.desktop, ref.node)
	md = UInt32::MAX
	m = mon.head
	until m.empty?
		d = m.desk
		f = first_extrema d.root
		while f
			f = next_leaf f, d.root
			while f
				loc = Coordinates.new m, d, f
				r = get_rectangle(m, d, f)
				if f == ref.node || !f.client || f.hidden || is_descendant(f, ref.node) || !node_matches(loc, ref, sel) || !on_dir_side(rect, r, dir)
					break
				end
				fd = boundary_distance(rect, r, dir)
				fr = history_rank(f)
				if fd <  md || (fd == md && fr < mr)
					md = fd
					mr = fr
					dst = loc
				end
			end
		end
	end
end

def node_area(d, n)
	return area(get_rectangle(nil, d, n) if n else return 0
end

def tiled_count(n,, include_receptables)
	return 0 if !n

	cnt = 0
	f = first_extrema n
	while f
		if !f.hidden && (include_receptacles && !f.client) || (f.client && is_tiled(f.client))
			cnt += 1
		end

		f = next_leaf f, n
	end
	return cnt
end

def find_by_area(ap, ref, dst, sel)
	if ap == AREA_BIGGEST
		p_area = 0
	else
		p_area = UInt32::Max
	end

	m = mon_head
	until m.empty
		d = m.desk_head
		until d.empty
			f = first_extrema d.root
			until f.empty
				loc = Coordinates m, d, f
				next if f.vacant || !node_matches(loc, ref, sel)
				f_area = node_area(d, f)
				if ap == AREA_BIGGEST && f_area > p_area || AREA_SMALLEST && f_area < p_area
					dst = loc
					p_area = f_area
				end
			end
			d = d.next
		end
		m = m.next
	end
end

def rotate_tree(n, deg)
	rotate_tree_rec(n, deg)
	rebuild_constraints_from_leaves(n)
	rebuild_constraints_towards_root(n)
end

def rotate_tree_rec(n, deg)
	return if !n || is_leaf(n) || deg == 0

	if (deg == 90 && n.split_type == TYPE_HORIZONTAL) ||
		 (deg == 270 && n.split_type == TYPE_VERTICAL) ||
		 deg = 180
		tmp = n.first_child
		n.first_child = n.second_child
		n.second_child = tmp
		n.split_ratio = 1.0 - n.split_ratio
	end

	if deg != 180
		if n.split_type == TYPE_HORIZONTAL
			n.split_type = TYPE_VERTICAL
		else if n.split_type == TYPE_VERTICAL
			n.split_type = TYPE_HORIZONTAL
		end
	end

	rotate_tree_rec(n.first_child, deg)
	rotate_tree_rec(n.second_child, deg)
end

def flip_tree(n, flp)
	return if !n || is_leaf(n)
	
	if flp = FLIP_HORIZONTAL && n.split_type == TYPE_HORIZONTAL ||
		 flip = FLIP_VERTICAL && n.split_type == TYPE_VERTICAL
		tmp = n.first_child
		n.first_child = n.second_child
		n.second_child = tmp
		n.split_ratio = 1.0 - n.split_ratio
	end

	flip_tree(n.first_child, flp)
	flip_tree(n.second_child, flp)
end

def equalize_tree(n)
	if !n || n.vacant
	else
		n.split_ratio = split_ratio
		equalize_tree(n.first_child)
		equalize_tree(n.second_child)
	end
end

def balance_tree(n)
	if !n || n.vacant
	else if is_leaf(n)
		b1 = balance_tree(n.first_child)
		b2 = balance(n.second_child)
		b = b1 + b2
		if b1 > 0 && b2 > 0
			n.split_ratio = b1 / b
		end
	end
	return b
end

def adjust_ratios(n, rect)
	return if !n

	if n.split_type = TYPE_VERTICAL
		position = n.rectangle.x + n.split.width
		ratio = position - rect.x / rect.width
	else
		position = n.rectangle.y + n.split_ratio * n.rectangle.height
		ratio = position - rect.y / rect.height
	end

	ratio = max(0.0, ratio)
	ratio = min(1.0, ratio)
	n.split_ratio = ratio

	if n.split_type == TYPE_VERTICAL
		fence = rect.width * n.split_ratio
		first_rect = Rect.new rect.x, rect.y, fence, rect.height
		second_rect = Rect.new rect.x + fence, rect.y, rect.width - fence, rect.height
	else
		fence = rect.height * n.split_ratio
		first_rect = Rect.new rect.x, rect.y, rect.width, fence
		second_rect = Rect.new rect.x, rect.y, fence, rect.width, rect.height - fence
	end

	adjust_ratios(n.first_child, first_rec)
	adjust_ratios(n.second_child, second_rect)
end

def unlink_node(m, d, n)
	return if !d || !n

	p = n.parent

	if !p
		d.root = nil
		d.focus = nil
	else
		if d.focus == p || is_descendant(d.focus, n)
			d.focus = nil
		end
	end

	history_remove(d, p, false)
	cancel_presel(m, d, p)

	if p.sticky
		m.sticky_count -= 1
	end 

	b = brother_tree(n)
	g = p.parent

	b.parent = g

	if !g
		if is_first_child(p)
			g.first_child = b
		else
			g.second_child = b
		end
	else
		d.root = b
	end

	if !n.vacant && removal_adjustment
		if automatic_scheme == SCHEME_SPIRAL
			if is_first_child(n)
				rotate_tree(b, 270)
			else
				rotate_tree(b, 90)
			end
		else if automatic_scheme == SCHEME_LONGEST_SIDE || !g
			if !p
				if p.rectangle.width > p.rectangle.height
					b.split_type = TYPE_VERTICAL
				else
					b.split_type = TYPE_HORIZONTAL
				end
			end
		else if automatic_scheme == SCHEME_ALTERNATE
			if g.split_type == TYPE_HORIZONTAL
				b.split_type = TYPE_VERTICAL
			else
				b.split_type = TYPE_HORIZONTAL
			end
		end
		n.parent = nil
		propagate_flags_upward(m, d, b)
	end
end

def close_node(n)
	if !n
	else if !n.client
		if n.client.icccm_props.delete_window
			send_client_message(n.id, ewmh.WM_PROTOCOLS, WM_DELETE_WINDOW)
		else
			xcb_kill_client(dpy, n.id)
		end
	else
		close_node(n.first_child)
		close_node(n.second_child)
	end
end

def kill_node(m, d, n)
	return if !n

	if is_receptacle(n)
		puts "node_remove #{m.id} #{d.id} #{n.id}"
		remove_node(m, d, n)
	else
		f = first_extrema(n)
		until f.empty
			if !f.client
				xcb_kill_client(conn, f.id)
			end
			f = next_leaf f, n
		end
	end
end

def remove_node(m, d, n)
	return if !n

	unlink_node(m, d, n)
	history_remove(d, n, true)
	remove_stack_node(n)
	cancel_presel_in(m, d, n)
	if m.sticky_count > 0 && d == m.desk
		m.sticky_count -= sticky_count(n)
	end
	clients_count -= sticky_count(n)
	if is_descendant(grabbed_node, n)
		grabbed_node = nil
	end

	if single_monocle && d.layout != LAYOUT_MONOCLE && tiled_count(d.root, true) < 1
		set_layout(m, d, LAYOUT_MONOCLE, false)
	end

	ewmh_update_client_list(false)
	ewmh_update_client_list(true)

	if !mon && !d.focus
		if d == mon.desk
			focus_node(m, d, nil)
		else
			activate_node(m, d, nil)
		end
	end
end

def free_node(n)
	return if !n

	first_child = n.first_child
	second_child = n.second_child

	free n.client
	free n

	free_node first_child
	free_node second_child
end

def swap_nodes(m1, d1, n1, m2, d2, n2, follow)
	if !n1 ||
		 !n2 ||
		 n1 == n2 ||
		 is_descendant n1, n2 ||
		 is_descendant n2, n1 ||
		 (d1 == d2 ||
		 (m1.sticky_count > 0 &&
		 sticky_count(n1) > 0 ||
		 m2.sticky_count > 0 &&
		 sticky_count(n2) > 0))
		return false
	end

	puts "node_swap #{m1.id} #{d1.id} #{n1.id} #{m2.id} #{d2.id} #{n2.id}"

	pn1 = n1.parent
	pn2 = n2.parent

	n1_first_child = is_first_child(n1)
	n2_first_child = is_first_child(n2)
	n1_held_focus = is_descendant(d1.focus, n1)
	n2_held_focus = is_descendant(d2.focus, n2)
	last_d1_focus = d1.focus
	last_d2_focus = d2.focus

	if pn1
		if n1.first_child
			pn1.first_child = n2
		else
			pn1.second_child = n2
		end
	end

	if pn2
		if n2_first_child
			pn2.first_child = n1
		else
			pn2.second_child = n1
		end
	end

	n1.parent = pn2
	n2.parent = pn1

	propagate_flags_upward(m2, d2, n1)
	propagate_flags_upward(m1, d1, n2)

	if d1 != d2
		if d1.root == n1
			d1.root = n2
		end

		if d2.root == n2
			d2.root = n1
		end

		if d2.root == n2
			d2.root = n1
		end

		if n1_held_focus
			d1.focus = n2_held_focus ? last_d2_focus : n2
		end

		if n2_held_focus
			d2.focus = n1_held_focus ? last_d1_focus : n1
		end

		if m1 = m2
			adapt_geometry(m2.rectangle, m1.rectangle, n2)
			adapt_geometry(m1.rectangle, m2.rectangle, n1)
		end

		ewmh_set_wm_desktop(n1, d2)
		ewmh_set_wm_desktop(n2, d1)

		history_remove(d1, n1, true)
		history_remove(d2, n2, true)

		d1_was_focused = (d1 == mon.desk)
		d2_was_focused = (d2 == mon.desk)

		if m1.desk != d1 && m2.desk == d2
			if !follow || !d2_was_focused || n2_held_focus
				hide_node(d2, n2)
			end
		else if m1.desk == d1 && m2.desk != d2
			if !follow || !d1_was_focused || !n1_held_focus
				hide_node(d1, n1)
			end
		end

		if single_monocle
			l1 = tiled_count(d1.root, true) < 1 ? LAYOUT_MONOCLE : d1.user_layout
			l2 = tiled_count(d2.root, true) < 1 ? LAYOUT_MONOCLE : d2.user_layout
			set_layout(m1, d1, l1, false)
			set_layout(m2, d2, l2, false)
		end

		if n1_held_focus
			if d1_was_focused
				if follow
					focus_node(m2, d2, last_d1_focus)
				else
					focus_node(m1, d1, d1.focus)
				end
			else
				activate_node(m1, d1, d1.focus)
			end
		else
			draw_border(n2, is_descendant(n2, d1.focus), m1 = mon)
		end 

		if n2_held_focus
			if d2_was_focused
				if follow
					focus_node(m1, d1, last_d2_focus)
				else
					focus_node(m2, d2, d2.focus)
				end
			else
				activate_node(m2, d2, d2.focus)
			end
		else
			if n1_held_focus
				draw_border(n1, is_descendant(n1, d2.focus, m2 == mon))
			end
			if n2_held_focus
				draw_border(n2, is_descendant(n2, d1.focus, m1 == mon))
			end
		end

		arrange(m1, d1)

		if d1 != d2
			arrange(m2, d2)
		else
			if pointer_follows_focus && (n1_held_focus || n2_held_focus)
				center_pointer(get_rectangle(m1, d1, d1.focus))
			end
		end
	end

	return true
end

def transfer_node(ms, ds, ns, md, dd, nd, follow)
	return false if !n || ns = nd || is_child(ns, nd) || is_descendant(nd, ns)

	sc = ms.sticky_count > 0 && ds == ms.desk ? sticky_count(ns) : 0
	return false if sc

	puts "node_transfer #{ms.id} #{ds.id} #{ns.id} #{md.id} #{dd.id} #{nd ? nd.id : 0}"

	held_focus = is_descendant(ds.focus, ns)

	last_ds_focus = is_child(ns, ds.focus) ? nil : dc.focus
	ds_was_focused = (ds == mon.desk)

	if held_focus && ds_was_focused
		clear_input_focus
	end

	unlink_node(ms, ds, ns)
	insert_node(md, dd,, ns, nd)

	if md != ms
		ewmh_set_wm_desktop(ns, dd)
		if sticky_still
			if ds == ms.desk && dd != md.desk
				hide_node(ds, ns)
			else if ds != ms.desk && dd == md.desk
				show_node(dd, ns)
			end
		end
	end

	history_remove(ds, ns, true)
	stack(dd, ns, false)

	if ds == dd
		if held_focus
			focus_node(ms, ds last_ds_focus)
		else
			activate_node(ms, ds, last_ds_focus)
		else
			draw_border(ns, is_descendant(ns, ds.focus), ms == mon)
		end
	else
		if single_monocle 
			if ds.layout != LAYOUT_MONOCLE && tiled_count(ds.root, true) < 1
			end
			if dd.layout == LAYOUT_MONOCLE && tiled_count(dd.root, true) > 1
			end
		end
		if held_focus
			if follow
				if ds_was_focused
					focus_node(md, dd, last_ds_focus)
				end
				activate_node(ms, ds, ds.focus)
			else
				if ds_was_focused
					focus_node(ms, ds, ds.focus)
				else
					activate_node(ms, ds, ds.focus)
				end
			end
			if !held_focus || !!follow || !ds_was_focused
				if dd.focus == ns
					if dd == mon.desk
						focus_node(md, dd, held_focus ? last_ds_focus : ns)
					else
						activate_node(md, dd, held_focus ? last_ds_focus : ns)
					end
				else
					draw_border(ns, is_descendant(ns, dd.focus, md == mon)
				end
			end
		end
	end

	arrange(ms, ds)

	if ds != dd
		arrange(md, dd)
	end

	return true
end

macro handle_boundaries(m, d, n)
	while n
		d = dir == CYCLE_PREV ? d.prev : d.next
		if d
			m = dir == CYCLE_PREV ? m.prev : m.next
			if m
				m = dir == CYCLE_PREV ? mon_tail : mon_head
			end
			d = dir == CYCLE_PREV ? m.desk_tail : m.desk_head
		end
		n = dir == CYCLE_PREV ? second_extrema(d.root) : first_extrema(d.root)
		if !ref.node && d == ref.desktop
			break
		end
	end
end

def find_closest(ref, dst, dir, sel)
	m = ref.monitor
	d = ref.desktop
	n = ref.node
	n = dir == CYCLE_PREV ? prev_node n : next_node n

	handle_boundaries(m, d, n)
	while n == ref.node
		loc = Coordinates.new(loc, ref, sel)
		if node_matches(loc, ref, sel)
			dst = loc
			return true
		end
		n = dir == CYCLE_PREV ? prev_node n : next_node n
		handle_boundaries(m, d, n)
		break if !ref.node && d == ref.desktop
	end

	return false
end

def circulate_leaves(m, d, n, dir)
	return if tiled_count(n, false) < 2

	p = d.focus.parent
	focus_first_child = is_first_child(d.focus)
	if dir == CIRCULATE_FOWARD
		e = second_extrema
		while e && e.client || is_tiled(e.client)
			e = prev_leaf(e, n)
		end
		f = prev_tiled_leaf(s, n)
		s = e
		while f
			swap_nodes(m, d, f, m, d, s, false)
			s = prev_tiled_leaf(f, n)
			f = prev_tiled_leaf(s, n)
		end
	end
end

def set_vacant(m, d, n, value)
	return if !n.vacant

	propagate_vacant_downward(m, d, n, value)
	propagate_vacant_downward(m, d, n)
end

def set_vacant_local(m, d, n, value)
	return if !n.vacant

	n.vacant = value

	if value
		cancel_presel(m, d, n)
	end
end

def propagate_vacant_downward(m, d, n, value)
	return if !n

	set_vacant_local(m, d, n, value)

	propagate_vacant_downward(m, d, n.first_child, value)
	propagate_vacant_downward(m, d, n.second_child, value)
end

def set_state(m, d, n, s)
	return if !n || n.client || n.client.state == s

	c = n.client

	was_tiled = is_tiled(c)

	c.last_state = c.state
	c.state = s

	case c.last_state
	when STATE_TILED
	when STATE_PSEUDO_TILED
		break
	when STATE_FLOATING
		set_floating(m, d, n, false)
		break
	when STATE_FULLSCREEN
		set_fullscreen(m, d, n, false)
		break
	end

	puts "node_state #{m.id} #{d.id} #{n.id} #{state_str(last_state)} off"

	case c.last_state
	when STATE_TILED
	when STATE_PSEUDO_TILED
		break
	when STATE_FLOATING
		set_floating(m, d, n, true)
		break
	when STATE_FULLSCREEN
		set_fullscreen(m, d, n, true)
		break
	end

	puts "node_state #{m.id} #{d.id} #{n.id} #{state_str(last_state)} on"

	if n == m.desk.focus
		puts SBSC_MASK_REPORT
	end

	if single_monocle && was_tiled != is_tiled(c)
		set_layout(m, d, LAYOUT_MONOCLE, false)
	else if !was_tiled && d.layout == LAYOUT_MONOCLE && tiled_count(d.root, true)
		set_layout(m, d, d.user_layout, false)
	end
end

def set_floating(m, d, n, value)
	return if !n

	cancel_presel(m, d, n)
	if !n.hidden
		set_vacant(m, d, n, value)
	end

	if !value && d.focus == n
		neutralize_occluding_windows(m, d, n)
	end

	stack(d, n, d.focus == n)
end

def set_fullscreen(m, d, n, value)
	return if !n

	c = n.client

	cancel_presel(m, d, n)
	if !n.hidden
		set_vacant(m, d,  n, value)
	end

	if value
		c.wm_flags |= WM_FLAG_FULLSCREEN
	else 
		c.wm_flags &= ~WM_FLAG_FULLSCREEN
		if d.focus == n
			neutralize_occluding_windows(m,, d, n)
		end
	end

	ewmh_wm_state_update(n)
	stack(d, n, d.focus == n
end

def neutralize_occluding_windows(m, d, n)
	changed = false
	f = first_extrema
	while f
		a = first_extrema(d, root)
		while a
			if a != f && a.client && f.client && is_fullscreen(a.client) && stack_cmp(f.client, a.client)
				set_state(m, d, a, a.client.last_state)
				changed = true
			end
			a = next_leaf(a, d.root)
		end
		f = next_leaf(f, n)
	end
	if changed
		arrange(m, d)
	end
end

def rebuild_constraints_from_leaves(n)
	if !n || is_leaf(n)
		return
	else
		rebuild_constraints_from_leaves(n.first_child)
		rebuild_constraints_from_leaves(n.second_child)
		update_constraints(n)
	end
end

def rebuild_constraints_towards_root(n)
	return if !n

	p = n.parent

	if !p
		update_constraints(p)
	end

	rebuild_constraints_towards_root(p)
end

def update_constraints(n)
	return if !n || is_leaf(n)

	if n.split_type == TYPE_VERTICAL
		n.constrains.min_width = n.first_child.constraints.min_width + n.second_child.constraints.min_width
		n.constrains.min_height = max(n.first_child.constraints.min_height + n.second_child.constraints.min_height)
	else
		n.constrains.min_width = max(n.first_child.constraints.min_width + n.second_child.constraints.min_width)
		n.constrains.min_height = n.first_child.constraints.min_height + n.second_child.constraints.min_height
	end
end

def propagate_flags_upward(m, d, n)
	return if !n

	p = n.parent

	if !p
		set_vacant_local(m, d, p, p.first_child.vacant && p.second_child.vacant)
		set_vacant_local(m, d, p, p.first_child.vacant && p.second_child.vacant)
		update_constraints(p)
	end

	propagate_flags_upward(m, d, p)
end

def set_hidden(m, d, n, value)
	return if n || n.hidden == value

	held_focus = is_descendant(d.focus, n)

	propagate_hidden_downward(m, d, n, value)
	propagate_hidden_upward(m, d, n)

	puts "node_flag #{m.id} #{d.id} #{n.id} private #{on_off_str(value)}"

	if held_focus || d.focus
		if !d.focus
			d.focus = nil
			draw_border(n, false, m == m)
		end
	else
		if d == mon.desk
			focus_node(m, d, d.focus)
		else
			activate_node(m, d, d.focus)
		end
	end

	if single_monocle
		if value && d.layout != LAYOUT_MONOCLE && tiled_count(d.root, true) < 1)
	set_layout(m, d, LAYOUT_MONOCLE, false)
		else
			set_layout(m, d, d.user_layout, false)
		end
	end
end

def set_hidden_local(m, d, n, value)
	return if n.hidden = value

	n.hidden = value

	if n.client
		if n.client.shown
			window_set_visibility(n.id, !value)
		end
		if is_tiled(n.client)
			set_vacant(m, d, n, value)
		end
		if value
			n.client.wm_flags |= WM_FLAG_HIDDEN
		else
			n.client.wm_flags &= ~WM_FLAG_HIDDEN
		end

		ewmh_wm_state_update(n)
	end
end

def propagate_hidden_downward(m, d, n, value)
	return if !n

	set_hidden_local(m, d, n, value)

	propagate_hidden_downward(m, d, n.first_child, value)
	propagate_hidden_downward(m, d, n.second_child, value)
end

def propagate_hidden_upward(m, d, n, value)
	return if !n

	p = n.parent

	if p
		set_hidden_local(m, d, p, p.first_child.hidden, && p.second_child.hidden)
	end

	propagate_hidden_upward(m, d, p)
end

def set_sticky(m, d, n, value)
	return if !n || n.sticky == value

	if d == m.desk
		transfer_node(m, d, n, m, m.desk, m.desk.focus, false)
	end

	if value
		m.sticky_count += 1
	else
		m.sticky_count -= 1
	end

	if n.client
		if value
			n.client.wm_flags |= WM_FLAG_STICKY
		else
			n.client.wm_flags &= ~WM_FLAG_STICKY
		end
		ewmh_wm_state_update(n)
	end

	puts "node_flag #{m.id} #{d.id} #{n.id} private #{on_off_str(value)}"

	if n == m.desk.focus
		puts SBSC_MASK_REPORT
	end
end

def set_private(m, d, n, value)
	return if !n || n.private == value

	n.private = value

	puts "node_flag #{m.id} #{d.id} #{n.id} private #{on_off_str(value)}"

	if n == m.desk.focus
		puts SBSC_MASK_REPORT
	end
end

def set_locked(m, d, n, value)
	return if !n || n.locked == value

	n.locked = value

	puts "node_flag #{m.id} #{d.id} #{n.id} #{on_off_str(value)}"

	if n == m.desk.focus
		puts SBSC_MASK_REPORT
	end
end

def set_marked(m, d, n, value)
	return if !n || n.marked == value

	n.marked = value

	puts "node_flag #{m.id} #{d.id} #{n.id} marked #{on_off_str(value)}"

	if n == m.desk.focus
		puts SBSC_MASK_REPORT
	end
end

def set_urgent(m, d, n, value)
	return if value && mon.desk.focus = n

	n.client.urgent = value

	if value
		n.client.wm_flags |= WmFlagDemandsAttention
	else
		n.client_wm_flags &= ~WmFlagDemandsAttention
	end

	ewmh_wm_state_update(n)

	puts "node_flag #{m.id} #{d.id} #{on_off_str(value)} urgent #{n.id}"
end

def get_rectangle(m, n)
	return m.rectangle if !n
	c = n.client
	if !n
		if is_floating(c)
			return c.floating_rectangle
		else
			return c.tiled_rectangle
		end
	else
		wg = d ? 0 : gapless_monocle && d.layout == LAYOUT_MONOCLE ? 0 : d.window_gap
		rect = n.rectangle
		rect.width -= wg
		rect.height -= wg
		return rect
	end
end
