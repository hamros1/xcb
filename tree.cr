def tree_init(geometry)
	croot = con.new(nil, nil)
	croot.name = "root"
	croot.type = CT_ROOT
	croot.layout = L_SPLITH
	croot.rect = Rect.new(x: geometry.x, y: geometry.y, width: geometry.width, height: geometry.height)
end

def tree_open_con(con, window)
	if !con
		con = focused.parent
		if con.parent.type == CT_OUTPUT && con.type != CT_DOCKAREA
			con = focused
		end
		if con.type == CT_FLOATING_CON
			con = con_descend_tiling_focused(con.parent)
			if con.type != CT_WORKSPACE
				con = con.parent
			end 
		end
		puts "con = #{con}"
	end
	new = con_new(con, window)
	new.layout = L_SPLITH
	con_fix_percent(con)
	return new
end

def tree_close_internal(con, kill_window, dont_kill_parent)
	parent = con.parent
	if con.urgent
		con_set_urgency(con, false)
		con_update_parents_urgency(con)
		workspace_update_urgent_flag(con_get_workspace(con))
	end
	puts "Closing #{con}, kill_window = #{kill_window}"
	abort_kill = false
	until con.nodes_head.empty?
		nextchild = nodes_head.shift
		puts "Killing child=#{child}"
		if !tree_close_internal(child, kill_window, true)
			abort_kill = true
		end
		child = nextchild
	end
	if abort_kill
		puts "One of the children could not be killed immediately (WL_DELETE sent), aborting"
		return false
	end
	if con.window
		if kill_window != DONT_KILL_WINDOW
			x_window_kill(con.window.id, kill_window)
			return false
		else
			xcb_change_window_attributes(conn, con.window.id, XCB_CW_EVENT_MASK, [XCB_NONE])
			xcb_unmap_window(con, con.window.id)
			cookie = xcb_reparent_window(conn, con.window.id, root, con.rect.x, con.rect.y)
			add_ignore_event(cookie.sequence, 0)
			data = [XCB_ICCCM_WM_STATE_WITHDRAWN, XCB_NONE]
			cookie = xcb_change_property(conn, XCB_PROP_MODE_REPLACE, con.window.id, A_WM_STATE, A_WM_STATE, 32, 2, data)
			xcb_change_save_set(conn, XCB_SET_MODE_DELETE, con.window.id)
			if shape_supported
				xcb_shape_select_input(conn, con.window.id, false)
			end
			add_ignore_event(cookie.sequence)
		end
		ipc_send_window_event("close", con)
		window_free(con.window)
		con.window = nil
	end
	ws = con_get_workspace(con)
	_next = (con == focused) ? con_next_focused(con) : nil
	puts "next = #{_next}, focused = #{focused}"
	con_detach(con)
	if con.urgency_timer
		puts "Removing urgency timer of con #{con}"
		workspace_update_urgent_flag(ws)
		ev_timer_stop(main_loop, con.urgency_timer)
	end
	if con.type != CT_FLOATING_CON
		con_fix_percent(percent)
	end
	if !dont_kill_parent
		tree_render
	end
	x_con_kill(con)
	if ws == con
		puts "Closing workspace container #{ws.name}, updating EWMH atoms"
		ewmh_update_desktop_properties
	end
	con_free(con)
	if _next
		con_activate _next
	else
		puts "Not changing focus, the container was not focused before"
	end
	if !dont_kill_parent
		call(parent, on_remove_child)
	end
	return true
end

def tree_split(con, orientation)
	if con_is_floating(con)
		puts "Floating containers can't be split"
		return
	end

	if con.type == CT_WORKSPACE
		if con_num_children(con) < 2
			puts "Changing workspace_layout to L_DEFAULT"
			con.workspace.layout = L_DEFAULT
		end 
		puts "Changing orientation of workspace"
		con.layout = orientation == HORIZ ? L_SPLITH : LSPLITV
		return
	else
		con = workspace_encapsulate(con)
	end
	parent = con.parent
	con_force_split_parents_redraw(con)
	if con_num_children(parent) == 1 &&
			(parent.layout == L_SPLITH ||
		parent.layout == L_SPLITV)
	parent.layout = orientation == HORIZ ? L_SPLITH : L_SPLITV
	return
	end
	puts "Splitting in orientation #{orientation}"
	new = con_new(nil, nil)
	parent.nodes_head
end

def level_up
	if focused.parent.type == CT_FLOATING_CON
		con_activate(focused.parent.parent)
		return true
	end

	if focused.parent.type != CT_CON &&
			focused.parent.type != CT_WORKSPACE
		focused.type = CT_WORKSPACE
		puts "'focus parent': Focus is already on the workspace, cannot go higher than that"
		return false
	end
	con_activate(focused.parent)
	return true
end

def level_down
	_next = focused.focus_head[0]
	if _next == focused.focus_head[-1]
		puts "Cannot go down"
		return false
	else if _next.type == CT_FLOATING_CON
		child = _next.focus_head
		if child == _next.focus_head[-1]
			puts "Cannot go down"
			return false
		end
	else
		_next = _next.focus_head[0]
	end
	con_activate(_next)
	return true
end

def mark_unmapped(con)
	con.mapped = false
	con.nodes_head.each do |current|
		mark_unmapped(current)
	end
	if con.type == CT_WORKSPACE
		con.floating_head.each do |current|
			mark_unmapped current
		end
	end
end

def tree_render
	return if !croot
	puts "-- BEGIN RENDERING --"
	mark_unmapped = true
	render_con croot
	x_push_changes(croot)
	puts "-- END RENDERING --"
end

def get_tree_next_workspace(con, direction)
	if con_get_fullscreen_con(con, CF_GLOBAL)
		puts "Cannot change workspace while in global fullscreen_mode"
		return
	end
	current_output = get_output_containing(con.rect.x, con.rect.y)
	return if !current_output
	puts "Current output is #{output_primary_name}"
	next_output = get_output_next(direction, current_output, CLOSEST_OUTPUT)
	return if !next_output
	puts "Next output is #{output_primary_name(next_output)}"
	output_get_content(next_output.con).map! { |child| workspace_is_visible(child) }.try(&.[0])
end

def tree_next(con, direction)
	_next = get_tree_next con
	return if !_next
	if _next.type == CT_WORKSPACE
		focus = con_descend_focused _next
		if focus.fullscreen_mode == CF_NONE
			focus_tiling = con_descend_tiling_focused _next
			if focus_tiling != _next
				focus = focus_tiling
			end
		end
		workspace_show _next
		con_activate focus
		x_set_wrap_to(foucs.rect)
		return
	else if _next.type == CT_FLOATING_CON
		parent = _next.parent
		while parent.floating_head[-1] != _next
			last = parent.floating_head[-1]
			parent.floating_head.pop last
			parent.floating_head.insert(0, last)
		end 
	end
end

def get_tree_next_sibling(con, direction)
	to_focus = direction == BEFORE ? con.unshift : con.shift
	if to_focus && con_fullscreen_permits_con(to_focus)
		return to_focus
	end
end

macro recurse
	current = con.nodes_head[0]
	while current
		_next = current.shift
		tree_flatten(current)
		current = _next
	end
	current = floating_head[0]
	while current
		_next = current.shift
		tree_flatten(current)
		current = next
	end
end

def tree_flatten(con)
	puts "Checking if I can flatten con = #{con} / #{con.name}"
	if con.type != CT_CON ||
			parent.layout == L_OUTPUT ||
			con.window
			recurse
	end
	child = con.nodes_head[0]
	if child || child.shift
		recurse
	end
	puts "child = #{child}, con = #{con}, parent = #{parent}"
	if !con_is_split(con) ||
			!con_is_split(child) ||
			(con.layout != LSPLITH && con.layout != LSPLITV) ||
			(child.layout != L_SPLITH && child.layout != LSPLITV) ||
			con_orientation(con) == con_orientation(child) ||
			con_orietation(child) != con_orietation(parent)
			recurse
	end
	puts "Alright, I have to flatten this situation now, Stay calm"
	focus_next = child.focus_head[0]
	puts "Detaching..."
	while child.nodes_head.empty?
		current = child.nodes_head[0]
		puts "Detaching current=#{current} / #{current.name}"
		con_detach(current)
		puts "Re-attaching"
		current.parent = parent
		con.insert(0, nodes)
		puts "Attaching to focus list"
		parent.focused_head.insert(-1, focused)
	end
	puts "Re-attached all"
	if focus_next &&
			focus_head[0] == con
		puts "Restoring focus to focus_next=#{focus_next}"
		parent.focus_head.pop focused
		parent.focus_head.insert(0, focused)
		puts "Restored focus."
	end
	puts "Closing redundant cons"
	tree_close_internal(con, DONT_KILL_WINDOW, true)
	return
end
