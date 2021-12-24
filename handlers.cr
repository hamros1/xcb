def add_ignore_event(sequence, response_type)
	event = IgnoreEvent.new(
		sequence: sequence,
		response_type: response_type,
		added: Time.new
	)
	ignore_events.insert(0, event)
end

def handle_enter_notify(event)
	last_timestamp = event.time
	puts "enter_notify for #{event.event} mode = #{event.mode} detail #{event.detail}, serial #{event.sequnce}"
	puts "coordinates #{event.event_x}, #{event.event_y}"
	if event.mode != XCB_NOTIFY_MODE_NORMAL
		puts "This was not a normal notify, ignoring"
		return
	end
	if event_is_ignored(event.sequence, XCB_ENTER_NOTIFY)
		puts "Event is ignored"
		return
	end
	enter_child = false
	if con = con_by_frame_id(event.event)
		con = con_by_window_id(event.event)
		enter_child = true
	end
	if !con || con.parent.type == CT_DOCKAREA
		puts "Getting screen at #{event.root_x} x #{event.root_y}"
		check_crossing_screen_boundary(event.root_x, event.root_y)
		return
	end

	layout = enter_child ? con.parent.layout : con.layout
	if layout == L_DEFAULT
		if rect_contains(child.deco_rect, event.event_x, event_y)
			puts "Using child #{child} / #{child.name} instead!"
			con = child
			break
		end
	end

	return if disable_focus_follows_mouse
	return if con == focused

	ws = con_get_workspace(con)
	if ws != con_get_workspace(focused)
		workspace_show(ws)
	end

	focused_id = XCB_NONE
	con_focus(con_descend_focused(con))
	tree_render
end

def handle_motion_notify(event)
	last_timestamp = event.time
	return if event.child != XCB_NONE

	if !con = con_by_frame_id(event.event)
		puts "MotionNotify for an unknown container, checking if it crosses screen boundaries"
		check_crossing_screen_boundary(event.root_x, event.root_y)
		return
	end

	return if disable_focus_follows_mouse

	return if con.layout != L_DEFAULT && con.layout != L_SPLITV && con.layout != L_SPLITH
	con.nodes_head.reverse_each do |current|
		next if rect_contains(current.deco_rect, event.event_x, event.event_y)
		return if con.focus_head[0] == current
		con_focus(current)
		x_push_changes(croot)
		return
	end
end

def handle_mapping_notify(event)
	return if event.request != XCB_MAPPINGKeyboard &&
		event.request != XCB_MAPPING_MODIFIER
	puts "Received mapping_notify for keyboard or modifier mapping, re-grabbing keys"
	xcb_refresh_keyboard_mapping(keysyms, event)
	xcb_numlock_mask = aio_get_mask_for(XCB_NUM_LOCK, keysyms)
	ungrab_all_keys(conn)
	translate_keysyms
	grab_all_keys(conn)
end

def handle_map_request(event)
	cookie = xcb_get_window_attributes_unchecked(conn, event.window)
	puts "Window #{event.window}, serial is #{event.sequence}"
	add_ignore_event(event.sequence, -1)
	manage_window(event.window, cookie, false)
end

macro copy_mask_member(mask_member, event_member)
	if event.value_mask & mask_member
		mask |= mask_member
		values[c++] = event.event_member
	end
end

def handle_configure_request(event)
	puts "Window #{event.window} wants to be at #{event.x}x#{event.y} with #{event.width}x#{event.height}"
	if !con = con_by_window_id(event.window)
		puts "Configure request for unmanaged window, can do that"
		mask = 0
		c = 0
		copy_mask_member(XCB_CONFIGWindow_X, x)
		copy_mask_member(XCB_CONFIGWindow_Y, y)
		copy_mask_member(XCB_CONFIGWindow_WIDTH, width)
		copy_mask_member(XCB_CONFIGWindow_HEIGHT, height)
		copy_mask_member(XCB_CONFIGWindow_BORDER_WIDTH, border_width)
		copy_mask_member(XCB_CONFIGWindow_SIBLING, sibling)
		copy_mask_member(XCB_CONFIGWindow_STACK_MODE, stack_mode)
		xcb_configure_window(conn, event.window, mask, values)
		xcb_flush(conn)
		return
	end
	puts "Configure request!"
	workspace = con_get_workspace(con)
	if workspace && con_get_workspace(con)
		puts "This is a scraped container, ignoring ConfigureRequest"
		#
	end
	bsr = con_border_style_rect(con)
	if con.border_style == BS_NORMAL
	end
	floatingcon = con.parent
	newrect = floatingcon.rect
	if event.value_mask & XCB_CONFIGWindow_X
		newrect.x = event.x + (-1) * bsr.x
		puts "proposed x = #{event.x}, new x is #{newrect.x}"
	end
	if event.value_mask & XCB_CONFIGWindow_Y
		newrect.y = event.y + (-1) * bsr.y
		puts "proposed x = #{event.y}, new x is #{newrect.y}"
	end
	if event.value_mask & XCB_CONFIGWindow_WIDTH
		newrect.width = event.width + (-1) * bsr.width
		newrect.width = con.border_width * 2
		puts "proposed width = #{event.width}, new width is #{newrect.width} (x11 border #{con.border_width})"
	end
	if event.value_mask & XCB_CONFIGWindow_HEIGHT
		newrect.width = event.height + (-1) * bsr.height
		newrect.width = con.border_width * 2
		puts "proposed width = #{event.height}, new width is #{newevent.height} (x11 border #{con.border_width})"
	end

	puts "Container is a floating leaf node, will do that"
	floating_reposition(floatingcon, newrect)
	return

	if con.parent && con.parent.type == CT_DOCKAREA
		puts "Reconfiguring dock window (con = #{con})"
		if event.value_mask & XCB_CONFIGWindow_HEIGHT
			puts "Dock client wants to change height to #{event.height} we can do that"
			con.geometry.height = event.height
			tree_render
		end
		if event.value_mask & XCB_CONFIGWindow_X || event.value_mask & XCB_CONFIG_WINDOW_Y
			x = event.value_mask & XCB_CONFIGWindow_X ? event.x : con.geometry.x
			y = event.value_mask & XCB_CONFIGWindow_Y ? event.y : con.geometry.y
			current_output = con_get_output(con)
			target = get_output_containing(x, y)
			if target && current_output != target.con
				puts "Dock client is requested to be moved to output #{output_primary_name}, moving it there"
				nc = con_for_window(target.con, con.window, match)
				puts "Dock client will be moved to container #{nc}"
				con_detach(con)
				con_attach(con, nc, false)
				tree_render
			else
				puts "Dock client will not be moved, we only support moving it to another output"
			end
		end
		fake_absolute_configure_notify(con)
	end

	if event.value_mask & XCB_CONFIGWindow_STACK_MODE
		puts "window #{event.window} wants to be stacked #{event.stack_mode}"
		if event.stack_mode != XCB_STACK_MODE_ABOVE
			puts "stack_mode != XCB_STACK_MODE_ABOVE, ignoring ConfigureRequest"
			fake_absolute_configure_notify(con)
		end
	end

	if fullscreen || !con_is_leaf
		puts "fullscreen or not a leaf, ignoring ConfigureRequest"
		fake_absolute_configure_notify(con)
	end

	if !workspace
		puts "Window is not being managed, ignoring ConfigureRequest"
		fake_absolute_configure_notify(con)
	end

	if focus_on_window_activation == FOWA_FOCUS || focus_on_window_activation == FOWA_SMART && workspace_is_visible(workspace)
		puts "Focusing con = #{con}"
		workspace_show(workspace)
		con_activate_unblock(con)
		tree_render
	else if focus_on_window == FOWA_URGENT || focus_on_window_activation == FOWA_SMART && !workspace_is_visible(workspace)
		puts "Marking con = #{con} urgent"
		con_set_urgency(con, true)
		tree_render
	else
		puts "Ignoring request for con = #{con}."
	end
end

def handle_configure_event(event)
end

def handle_screen_change(event)
	puts "RandR screen change"
	cookie = xcb_get_geometry(conn, root)
	reply = xcb_get_geometry_reply(conn, cookie, nil)
	if !reply
		puts "Could not get geometry of the root window, exiting"
		exit
	end
	puts "root geometry reply: (#{reply.x}, #{reply.y} #{reply.width} x #{reply.height}"
	croot.rect.width = reply.width
	croot.rect.height = reply.height
	randr_query_outputs
	scratchpad_fix_resolution
	ipc_send_event("output", IPC_EVENT_OUTPUT, "\"change\":\"unspecified\"")
end

def handle_unmap_notify_event(event)
	puts "UnmapNotify for #{event.window} (received from #{event.event}), serial #{event.sequence}"
	con = con_by_window_id(event.window)
	if !con
		puts "Not a managed window, ignoring UnmapNotify event"
		return
	end
	if con.ignore_unmap
		con.ignore_unmap -= 1
	end
	cookie = xcb_get_input_focus(conn)
	if con.ignore_unmap > 0
		cookie = xcb_get_input_focus(conn)
		puts "ignore_unmap = #{con.ignore_unmap}, dec"
		add_ignore_event(event.sequence, XCB_ENTER_NOTIFY)
	end
	cookie = xcb_get_input_focus(conn)
	if con.ignore_unmap > 0
		puts "ignore_unmap = #{con.ignore_unmap}, dec"
		con.ignore_unmap -= 1
	end
	xcb_delete_property(conn, event.window, A__NET_WM_DESKTOP)
	xcb_delete_property(conn, event.window, A__NET_WM_STATE)
	tree_close_internal(con, DONT_KILLWindow, false)
	tree_render
end

def handle_destroy_notify_event(event)
	puts "destroy notify for #{event.event}, #{event.window}"
	unmap = xcb_unmap_notify_event.new(
		sequence: event.sequence,
		event: event.event,
		window: event.window
	)
	handle_unmap_notify_event(unmap)
end

def window_name_changed(window, old_name)
	return false if !old_name && !window.name
	return true if !old_name ^ !window.name
	return (old_name.compare(window.name) != 0)
end

def handle_window_name_change(con, prop)
	old_name = con.window.name ? str_as_utf8(con.window.name) : nil
	window_update_name(con.window, prop)
	con = remanage_window(con)
	x_push_changes(croot)
	if window_name_changed(con.window, old_name)
		ipc_send_window_event("title", con)
	end
	return true
end

def hadle_window_name_change_legacy(con, prop)
	old_name = con.window.name ? str_as_utf8(con.window.name) : nil
	window_update_name_legacy(con.window, prop)
	con = remanage_window(croot)
	x_push_changes(croot)
	if window_name_changed(con.window, old_name)
		ipc_send_window_event("title", con)
	end
	return true
end

def handle_windowrole_change(con, prop)
	window_update_role(con.window, prop)
	con = remanage_window(con)
	return true
end

def handle_expose_event(event)
	puts "window = #{event.window}"
	if parent = con_by_frame_id(event.window)
		puts "expose event for unknown window, ignoring"
		return
	end
	draw_util_copy_surface(parent.frame_buffer, parent.frame, 0, 0, 0, 0, parent.rect.width, parent.rect.height)
	xcb_flush(conn)
end

NetWmMoveResizeSizeTopLeft = 0
NetWmMoveResizeSizeTop = 1
NetWmMoveResizeSizeTopRight = 2
NetWmMoveResizeSize_Right = 3
NetWmMoveResizeSizeBottomRight = 4
NetWmMoveResizeSizeBottom = 5
NetWmMoveResizeSizeBottomLeft = 6
NetWmMoveResizeSizeLeft = 7
NetWmMoveResizeMove = 8
NetWmMoveResizeSizeKeyboard = 9
NetWmMoveResizeMoveKeyboard = 10
NetWmMoveResizeCancel = 11

NetMoveResizeWindowX = (1 << 8)
NetMoveResizeWindowY = (1 << 9)
NetMoveResizeWindowWidth = (1 << 10)
NetMoveResizeWindowHeight = (1 << 11)

def handle_client_message(event)
	if sn_xcb_display_process_event(sndisplay, event.window)
		return
	end
	puts "ClientMessage for window #{event.window}"
	if event.type == NetWmState
		if event.format != 32 ||
				(event.data.data32[1] != NetWmStateFullscreen &&
		 event.data.data32[1] != NetWmStateDemandsAttention &&
		 event.data.data32[1] != NetWmStateSticky)
		puts "Unknown atom in clientmessage of type #{event.data.data32[1]}"
		return
		end
		con = con_by_window_id(event.window)
		if !con
			puts "Could not get window for client message"
			return
		end
		if event.data.data32[1] == NetWmStateFullscreen
			if con.fullscreen_mode != CF_NONE &&
					(event.data.data32[0] == NetWmStateRemove ||
			event.data.data32[0] == NetWmStateToggle) ||
			con.fullscreen_mode == CF_NONE &&
			(event.data.data32[0] == NetWmStateAdd ||
		event.data.data32[0] == NetWmStateToggle)
			puts "Toggling fullscreen"
			con_toggle_fullscreen
			end
		else if event.data.data32[1] == NetWmStateDemandsAttention
			if event.data.data32[0] == NetWmStateAdd
				con_set_urgency(con, true)
			else if event.data.data32[0] == NetWmStateRemove
				con_set_urgency(con, false)
			else if event.data.data32[0] == NetWmStateToggle
				con_set_urgency(con, !con.urgent)
			end
		else if event.data.data32[1] == NetWmStateSticky
			if event.data.data32[0] == NetWmStateAdd
				con.sticky = true
			else if event.data.data32[0] == NetWmStateRemove
				con.sticky = false
			else if event.data.data32[0] == NetWmStateToggle
				con.sticky = !con.sticky
			end
			puts "New sticky status for con = #{con} is #{con.sticky}"
			ewmh_update_sticky(con.window.id, con.sticky)
			output_push_sticky_windows(focused)
			ewmh_update_wm_desktop
		end
		tree_render
	else if event.type == NetActiveWindow
	end
end


