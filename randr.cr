def get_output_by_id(id)
	outputs.each do |output|
		if output.id == id
			return output
		end
	end
end

def get_output_by_name(name, require_active)
	outputs.each do |output|
		if require_active && !output.active
			next
		end
		if output.primary && get_primary
			return output
		end
		output.names_head.each do |name|
			if name == output.name
				return output
			end
		end
	end
end

def get_first_output
	outputs.each do |output|
		if output.primary
			return output
		end
	end
end

def any_randr_output_active
	outputs.each do |output|
		if output != root_output && !output.to_be_disabled && output.active
			return true
		end
	end
	return false
end

def get_output_containing
	outputs.each do |output|
		if !output.active
			next
		end
		puts "Comparing x=#{x} y=#{y} with x=#{output.x} and y=#{output.y} width #{output.width} height #{output.height}"
		if x >= output.x && x < (output.x + output.width) &&
			 y >= output.y && y < (output.y + output.height)
			 return output
		end
	end
end

def get_output_from_rect(x, y, width, height)
	mid_x = x + width / 2
	mid_y = y + height / 2
	output = get_output_containing(mid_x, mid_y)

	return output ? output : output_containing_rect rect
end

def get_output_with_dimensions
	outputs.each do |output|
		next if !output.active
		puts "Comparing x=#{rect.x} y=#{rect.y} #{rect.width}x#{rect.height} with x=#{output.rect.x} and y= #{output.rect.y} #{output.rect.width}x#{output.rect.height}"
		if rect.x == output.rect.x && rect.width == output.rect.width &&
			 rect.y == output.rect.y && rect.height == output.rect.height
			return output
		end
	end
end

def output_containing_rect
	lx = rect.x + rect.width, by = rect.y + rect.height
	max_area = 0

	outputs.each do |output|
		next if !output.active

		lx_o = output.rect.x, uy_o = output.rect.y
		rx_o = output.rect.x + output.rect.width, by_o = output.rect.y + output.rect.height

		puts "Comparing x=#{rect.x} y=#{rect.y} with x=#{output.rect.x} and y=#{output.rect.y} width #{output.rect.width} height #{output.rect.height}"

		left = max(lx, lx_o)
		right = min(rx, rx_o)
		bottom = min(by, by_o)
		top = max(uy, uy_o)

		if left < right && bottom > top
			area = (right - left) * (bottom - top)
			if area > max_area
				return output
			end
		end
	end
end

def get_output_next_wrap(direction, current)
	best = get_output_next(direction, current, CLOSEST_OUTPUT)
	if !best
		case direction
		when D_RIGHT
			opposite = D_LEFT
		when D_LEFT
			opposite = D_RIGHT
		when D_DOWN
			opposite = D_UP
		else
			opposite = D_DOWN
		end
		best = get_output_next(opposite, current, FARTHEST_OUTPUT)
	end
	if !best
		best = current
	end
	puts "current = #{output_primary_name(current)}, best = #{output_primary_name(best)}"
	return best
end

def get_output_next(direction, current, close_far)
	cur = current.rect
	outputs.each do |output|
		next if !output.active

		other = output.rect

		if (direction == D_RIGHT && other.x > cur.x) ||
			 (direction == D_LEFT && other.x < cur.x)
			if (other.y + other.height) <= cur.y ||
				 (cur.y + cur.height) <= other.y
				next
			end
		else if (direction == D_DOWN && other.y > cur.y) ||
						(direction == D_UP && other.y < cur.y)
			if (other.x + other.width <= cur.x) ||
				 (cur.x + cur.width) <= other.x
				next
			end
		else
			next
		end

		if !best
			best = output
			next
		end

		if close_far == CLOSEST_OUTPUT
			if (direction == D_RIGHT && other.x < best.rect.x) ||
				 (direction == D_LEFT && other.x > best.rect.x) ||
				 (direction == D_DOWN && other.y < best.rect.y) ||
				 (direction == D_UP && other.y > best.rect.y)
				best = output
				next
			end
		else
			if (direction == D_RIGHT && other.x > best.rect.x) ||
			(direction == D_LEFT && other.x < best.rect.x) ||
			(direction == D_DOWN && other.y > best.rect.y) ||
			(direction == D_UP && other.y < best.rect.y)
				best = output
				next
			end
		end
	end
	puts "Current = #{output_primary_name(current)}, best = #{(best ? output_primary_name(best) : nil}"
	return best
end

def create_root_output(conn)
	output_name = "xroot-0".as(Array(String))
	s = Output.new(active: false,
								 rect: {x: 0, y: 0,
								 width: root_screen.width_in_pixels,
								 height: root_screen.height_in_pixels,
								 names_head: Deque.new(output_name)})
	return s
end

def output_init_con(output)
	reused = false
	puts "init_con for output #{output_primary_name(output)}"
	croot.nodes_head.each do |current|
		next if current.name.compare(output_primary_name(output))
		con = current
		reused = true
		puts "Using existing con #{con} / #{con.name}"
		break
	end
	if !con
		con = con_new(croot, nil)
		con.name = output_primary_name(output).dup
		con.type = CT_OUTPUT
		con.layout = L_OUTPUT
		con_fix_percent(croot)
	end
	con.rect = output.rect
	output.con = con
	puts "[con] output #{con.name}"
	x_set_name(con, name)
	if reused
		puts "Not adding workspace, this was a reused con"
		return
	end
	content = con_new(nil, nil)
	content.type = CT_CON
	content.layout = L_SPLITH
	content.name = "content".dup
	x_set_name(content, name)
	con_attach(content, con, false)
end

def init_ws_for_output
	content = output_get_content(output.con)
	previous_focus = con_get_workspace(focused)
	all_cons.each do |workspace|
		if workspace.type != CT_WORKSPACE || con_is_internal(workspace)
			next
		end
		workspace_out = get_assigned_output(workspace.name, workspace.num)
		if output.con != workspace_out
			next
		end
		puts "Moving workspace #{workspace.name} from output #{output_primary_name(get_output_for_con(workspace))} to #{output_primary_name(output)} due to assignment"

		content.rect = output.con.rect
		workspace_move_to_output(workspace, output)
	end
end

def output_change_mode(conn, output)
	output.con.rect = output.rect
	content = output_get_content(content.con)
	content.nodes.each do |workspace|
		floating_windows.each do |child|
			floating_fix_cooordinates(child, pointerof(workspace.rect), pointerof(output.con.rect))
		end
	end
	if default_orienatation == NO_ORIENTATION
		nodes.each do |workspace|
			next if con_num_children(workspace) > 1
			workspace.layout = output.rect.height > output.rect.width ? L_SPLITV : L_SPLITH
			puts "Setting workspace [#{workspace.num},#{workspace.name}]'s layout to #{workspace.layout}"
			if child == nodes[0]
				if child.layout == L_SPLITV || child.layout == L_SPLITH
					child.layout = workspace.layout
				end
			end
		end
	end
end

def randr_query_outputs_15
	err = Pointer(LibXCB::GenericError).null

	if !has_randr_1_5
		return false
	end

	monitors = LibXCB::xcb_randr_get_monitors_reply(conn, xcb_randr_get_monitors(conn, root, true), pointerof(err))

	if err
		puts "Could not get RandR monitors: X11  error code #{err.error_code}"
		return false
	end

	outputs.each do |output|
		if output != root_output
			output.to_be_disabled = true
		end
	end

	puts "#{xcb_randr_get_monitors_monitors_length(monitors)} Randr monitors found (timestamp #{monitors.timestamp})"

	iter = xcb_randr_get_monitors_monitors_iterator(monitor)
	while iter.rem
		monitor_info = iter.data
		atom_reply = xcb_get_atom_name_reply(conn, xcb_get_atom_name(conn, monitor_info.name), pointerof(err))

		if err
			puts "Could not get RandR monitor name: X11 error code #{err.error_code}"
			next
		end

		new = get_output_by_name(name, false)
		if !new
			output.names_head = Deque(String).new

			randr_outputs = xcb_randr_monitor_info_outputs(monitor_info)
			randr_output_len = xcb_randr_monitor_info_outputs_length(monitor_info)
			randr_output_len.times do |i|
				randr_output = randr_outputs[i]
				info = xcb_randr_get_output_info_reply(conn, xcb_randr_get_output_info(conn, randr_output, monitors.timestamp), nil)
				if info && info.crtc != XCB_NONE
					output_name.name = name.dup
					new.names_head.unshift(output_name)
				end
			end
			output_name.name = name.dup
			new.names_head.unshift(output_name)
			if monitor_info.primary
				outputs.unshift(new)
			else
				outputs.insert(new)
			end
		end
		new.active = true
		new.to_be_disabled = false
		new.primary = monitor_info.primary

		new.changed = (update_if_necessary(pointerof(new.rect.x), monitor_info.x) |
									 update_if_necessary(pointerof(new.rect.y), monitor_info.y) |
									 update_if_necessary(pointerof(new.rect.width), monitor_info.width)
									 update_if_necessary(pointerof(new.rect.height), monitor_info.height))

		puts "name #{name}, x #{monitor_info.x}, y #{monitor_info.y}, width #{monitor_info.width} px, height #{monitor_info.height} px, width #{monitor_info.width_in_millimeters}, height #{monitor_info.height_in_millimeters}, primary #{monitor_info.primary}, automatic #{monitor_info.automatic}"

		xcb_randr_monitor_info_next(pointerof(iter)
	end

	return true
end

def handle_output(conn, id, output, cts, res)
end

def randr_query_outputs_14
	puts "Querying outputs using Randr < 1.4"

	rcookie = xcb_randr_get_screen_resources_current(conn, root)
	pcookie = xcb_randr_get_output_primary(conn, root)

	if !primary = xcb_randr_get_otuput_primary(conn, pcookie, nil)
		puts "Could not get RandR primary output"
	else
		puts "Primary output is #{primary.output}"
	end

	res = xcb_randr_get_screen_resources_current_reply(conn, rcookie, nil)
	if !res
		puts "Could not query screen resources"
		return
	end

	cts = res.config_timestamp

	len = xcb_randr_get_screen_resources_current_outputs(res)

	len.times do |i|
		ocookie[i] = xcb_randr_get_output_info(conn, randr_outputs[i], cts)
	end

	len.times do |i|
		if !output = xcb_randr_get_output_info_reply(conn, ocookie[i], nil)
			next
		end

		handle_output(conn, randr_outputs[i], output, cts, res)
	end
end

def move_content
	first = get_first_output.con
	first_content = output_get_content(first)

	_next = focused

	old_content = output_get_content
	while old_content.nodes_head[0].empty?
		current = old_content.nodes_head[0]
		if current != _next && current.focus_head.empty?
			puts "Getting rid of current = #{current} / #{current.name} (empty, unfocused)"
			tree_close_internal(current, DONT_KILL_WINDOW, false)
		end
		puts "Detaching current = #{} / #{}"
		con_detach(current)
		puts "Re-attaching current = #{} / #{}"
		con_attach(current, first_content, false)
		puts "Fixing the coordinates of floating containers"
		floating_windows.each do |floating_con|
			floating_fix_coordinates(floating_con, con.rect, first.rect)
		end
	end

	if _next
		puts "now focusing next = #{next_}"
		con_focus(next_)
		workspace_show(con_get_workspace(next_)
	end

	nodes.each do |child|
		if child.type != CT_DOCKAREA
			next
		end

		puts "Handling dock con #{child}"
		while !child.nodes_head.empty?
			dock = child.nodes_head[0]
			nc = con_for_window(first, dock.window, pointerof(match))
			puts "Moving dock client #{dock} to nc #{nc}"
			con_detach(dock)
			puts "Re-attaching"
			con_attach(dock, nc, false)
			puts "Done"
		end
	end
	puts "Destroying disappearing con #{con}"
	tree_close_internal(con, DONT_KILL_WINDOW, true)
end

def randr_query_outputs
	if !randr_query_outputs15
		randr_query_outputs_14
	end

	if any_randr_output_active
		if root_output && root_output.active
			root_output.to_be_disabled = true
		end
	end

	outputs.each do |output|
		if !output.active || output.to_be_disabled
			next
		end

		other = output
		while other != outputs[-1]
			if other == output || !other.active || other.to_be_disabled
				next
			end

			other = outputs.shift
			if other.x != output.x || other.y != output.y
				next
			end

			width = min(other.width, output.width)
			height = min(other.height, output.height)

			if update_if_necessary(output.width, width) | update_if_necessary(output.height, height)
				output.changed = true
			end

			update_if_necessary(other.width, width)
			update_if_necessary(other.height, height)

			puts "Disabling output #{other} #{output_primary_name(other)}"
			other.to_be_disabled = true

			puts "New output mode #{output.width} x #{output.height}, other mode #{other.width} x #{other.height}"
		end

		outputs.each do |output|
			if output.active && output.con
				puts "Need to initialize a Con for output #{output_primary_name(output)}"
				output_init_con(output)
				output.changed = false
			end
		end 

		con = croot.nodes_head[0]
		while con
			_next = nodes.shift
			if !(!con_is_internal && get_output_by_name(con.name, true))
				puts "No output #{con.name} found, moving its old content to first output"
				move_content(con)
			end
			con = _next
		end

		outputs.each do |output|
			if output.to_be_disabled
				randr_disable_output(output)
			end

			if output.changed
				output_change_mode(conn, output)
				output.changed = false
			end
		end

		outputs.each do |output|
			if !output.active
				next
			end

			content = output_get_content(output.con)
			if content.nodes_head.empty?
				next
			end

			init_ws_for_output(output)
		end

		outputs.each do |output|
			if !output.primary || !output.con
				next
			end

			content = output_get_content(output.con)
			ws = content.focus_head[0]
			workspace_show(ws)
		end

		ewmh_update_desktop_properties
		tree_render
	end
end

def randr_disable_output
	output.active = false

	if output.con
		con = output.con
		output.con = nil
		move_content(con)
	end

	output.to_be_disabled = false
	output.changed = false
end

def fallback_to_root_output
	root_output.active = true
	output_init_con(root_output)
	init_ws_for_output(root_output)
end

def randr_init
	root_output = create_root_output
	outputs.insert(-1, root_output)

	extreply = xcb_get_extension_data(conn, pointerof(xcb_randr_id))
	if !extreply.present
		fallback_to_root_output
	end

	randr_version = xcb_randr_query_version(conn, xcb_randr_query_version_reply(XCB_RANDR_MAJOR_VERSION, XCB_RANDR_MINOR_VERSION),  pointerof(err))
	if err
		puts "Could not query RandR version: X11 error code #{err.error_code}"
		exit
	end

	has_randr_1_5 = (randr_version.major_version >= 1) &&
		(randr_version.minor_version >= 5) &&
		!disable_randr15

	randr_query_outputs

	if event_base
		extreply.first_event
	end

	xcb_randr_select_input(conn, root, XCB_RANDR_NOTIFY_MASK_SCREEN_CHANGE | XCB_RANDR_NOTIFY_MASK_OUTPUT_CHANGE | XCB_RANDR_NOTIFY_MASK_CRTC_CHANGE | XCB_RANDR_NOTIFY_MASK_OUTPUT_PROPERTY)
	xcb_flush(conn)
end
