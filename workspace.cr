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
