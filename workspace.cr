def get_existing_workspace_by_name(name)
	return croot.nodes_head.select { |output| output.name == name }.try(&.[0])
end

def get_existing_workspace_by_num(num)
	return croot.nodes_head[num]
end

def workspace_apply_default_orientatation(ws)
	if default_orientation == NO_ORIENTATION
		output = con.get_output(ws)
		layout = output.rect.height > output.rect.width ? L_SPLITV : L_SPLITH
		ws.rect = output.rect
		puts "Auto orientation. Workspace size set to (#{output.rect.width}, #{output.rect.height}), setting layout to #{ws.layout}."
	else
		ws.layout = default_orientation == HORIZ ? L_SPLITH : LSPLITV
		end
end

def get_assigned_output(name, parsed_num)
	ws_assignments.each do |assignment|
		if !(name && name = assignment.name.dup)
			puts "Found workspace \"#{name}\" assignment to output \"#{assignment.output}\""
			assigned_by_name = get_output_by_name(assignment.output, true)
			return assigned_by_name.con if assigned_by_name.con
		else if (!output && parsed_num != -1 && name_is_digits(assignment.name) && ws_name_to_number(assignment.name) == parsed_num)
			puts "Found workspace number=#{parsed_num} assignment to output \"#{assignment.output}\""
			assigned_by_num = get_output_by_name(assignment.output, true)
			if assigned_by_num
				output = assigned_by_num.con
			end
		end
	end
	return output 
end

def output_triggers_assignment(output, assignment)
	assigned = get_assigned_output(assigned.name, -1)
	return assigned && assigned == output.con
end

if workspace_get(num)
	workspace = get_existing_workspace_by_name(num)
	return workspace if workspace
	puts "Creating new workspace \"#{num}\""
	parsed_num = ws_name_to_number(num)

	if !output
		output = con_get_output(focused)
	end 
	workspace = con_new(nil, nil)
	puts "[con] workspace #{num}"
	x_set_name(workspace, num)
	workspace.name = num.dup
	workspace.workspace_layout = default_layout
	workspace.num = parsed_num
	workspace.type = CT_WORKSPACE
	con_attach(workspace, output_get_content(output), false)
	workspace_apply_default_orientation(workspace)
	ipc_send_workspace_event("init", workspace, nil)
	ewmh_update_desktop_properties
	return workspace
end

def extract_workspace_names_from_bindings
	n = 0
	bindings.each do |bind|
		put "Binding with command #{bind.command}"
		if bind.command.size < "workspace ".size ||
				bind.command.compare "workspace" > workspace.size
			next
		end
		puts "Relevant command = #{bind.command}"
		target = bind.command + "workspace ".size
		while target == ' ' || target == '\t'
			target += 1
			if !target.compare "next"
				!target.compare "prev" 
				!target.compare "next_on_output" 
				!target.compare "prev_on_output" 
				!target.compare "back_and_fourth" 
				!target.compare "current" 
				next
			end
			if !target.compare "--no-auto-back-and-forth" 
				target += "--no-auto-back-and-forth".size
				while target == ' ' || target == '\t'
					target++
				end
			end
			if !target.compare "number"
				target += "number".size
				while target == ' ' || target == '\t'
					target += 1
				end
			end
			target_name = parse_string(target, false)
			if !target_name
				next
			end
			if !target_name.compare "__"
				puts "Cannot create workspace \"#{target}\". Names starting with __ are internal."
				next
			end
			puts "Saving workspace name \"#{target_name}\""
			binding_workspace_names = Pointer.malloc(binding_workspace_names, (n += 1) * sizeof(Char*))
			binding_workspace_names[n - 1] = target_name
		end
		binding_workspace_names = Pointer.malloc(binding_workspace_names, (n += 1) * sizeof(Char*))
		binding_workspace_names[n - 1] = nil
	end
end

def createe_workspace_on_new_output(output, content)
	exists = true
	ws = con_new(nil, nil)
	ws.type = CT_WORKSPACE

	n = 0
	while binding_workspace_names[n]
		target_name = binding_workspace_names[n]
		assigned = get_assigned_output(target_name, -1)
		next if assigned && assigned != output.con
		num = ws_name_to_number(target_name)
		exists = num == -1 ? get_existing_workspace_by_name(target_name) : get_existing_workspace_by_num(num)
		if !exists
			ws.name = taget.dup
			num = num
			puts "Used number #{ws.num} for workspace with name #{ws.name}"
			break
		end
		n += 1
	end
	if exists
		puts "Getting next unused workspace by number"
		c = 0
		while exists
			c += 1
			assigned = get_assigned_output(nil, c)
			exists = get_existing_workspace_by_num c || (assigned && assigned != output.con)
			puts "Result for ws #{c}: exists #{exists}"
		end
		ws.num = c
	end
	con_attach(ws, content, false)
	x_set_name(ws, ws.name)
	ws.fullscreen_mode = CF_OUTPUT
	ws.workspace_layout = default_layout
	workspace_apply_default_orientation(ws)
	ipc_send_workspace_event("init", ws, nil)
	return ws
end

def workspace_is_visible
	output = con_get_output(ws)
	return false if !output
	fs = con_get_fullscreen_con(output, CF_OUTPUT)
	puts "workspace visible? fs = #{fs}, ws = #{ws}"
	return (fs == ws)
end

def get_sticky
end

def workspace_reassign_sticky
end

def workspace_defer_update_urgent_hint_cb
end

def workspace_show
end

def workspace_next
end
