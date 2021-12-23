def render_con(con)
	params = RenderParams.new(x: con.x, y: con.y, children: con_num_children(con))

	puts "Rendering node #{con} / #{con.name} / #{con.layout} / #{params.children}"

	i = 0
	con.mapped = true

	if con.window
		inset = con.window_rect
		inset = Rect.new(0, 0, con.width, con.height)
		if con.fullscreen_mode == CF_NONE
			inset = rect_add(inset, con_border_style_rect(con))
		end

		inset.width -= 2 * con.border_width
		inset.height -= 2 * con.border_width

		inset = rect_sanitize_dimensions(inset)

		puts "Child will be at #{inset.x} x #{inset.y} with size #{inset.width} x #{inset.height}"
	end

	if con.type != CT_OUTPUT
		fullscreen = con_get_fullscreen_con(con, con.type == CT_ROOT ? CT_GLOBAL : CF_OUTPUT)
	end

	if fullscreen
		fullscreen.rect = params.rect
		x_raise_con(fullscreen)
		render_con(fullscreen)
		if con.type != CT_ROOT
			return
		end
	end

	params.deco_height = render_deco_height

	params.sizes = precalculate_sizes(con, pointerof(params))

	if con.layout == L_OUTPUT
		if con_is_internal(con)
			return
		end
	else if con.type == CT_ROOT
		render_root(con, fullscreen)
	else
		con.nodes_head.each do |child|
			if con.layout == L_SPLITH || con.layout == LSPLITV
				render_con_split(con, child, params, i)
			else if con.layout == L_STACKED
				render_con_stacked(con, child, params, i)
			else if con.layout == L_TABBED
				render_con_tabbed(con, child, params, i)
			else if con.layout == L_DOCKAREA
				render_con_dockarea(con, child, params)
			end

			child.rect = rect_sanitize_dimensions(child.rect)

			puts "Child at (#{child.x}, #{child.y}) with (#{child.width} x #{child.height})"
			x_raise_con(child)
			render_con(child)
			i += 1
		end

		if con.layout == L_STACKED || con.layout == L_TABBED
			con.focus_head.reverse_each do |focused|
				x_raise_con(child)
			end
			if child == con.focus_head[0]
				render_con(child)
			end
			if params.children != 1
				x_raise_con(con)
			end
		end 
	end
end

def precalculate_sizes(con, p)
	if con.layout != L_SPLITH && con.layout != L_SPLITV || p.children <= 0
		return
	end

	con.nodes_head.each do |child|
		percentage = child.percent > 0.0 ? child.percent : 1.0 / p.children
		assigned += sizes[i++] = lround(percentage * total)
	end

	int i, assigned = 0
	total = con_rect_size_in_orientation(con)
	signal = assigned < total 1 : -1
	while assigned != total
		while i < p.children && assigned != total
			sizes[i] += signal
			assigned += signal
			i += 1
		end
	end

	return sizes
end

def render_root(con, fullscreen)
	if !fullscreen
		con.nodes_head.each do |output|
			render_con output
		end
	end

	con.nodes_head.each do |output|
		if con_is_internal(output)
			next
		end

		if !content || content.focus_head.empty?
			puts "Skipping this output because it is currently being destroyed"
			next
		end

		workspace = content.focus_head[0]
		fullscreen = con_get_fullscreen_covering_ws(workspace)
		workspace.floating_head.each do |floating_windows|
			if !fullscreen
				if !fullcreen.window
					next
				end
			end

			floating_child = con_descend_focused(child)
			if con_find_transient_for_window(floating_child, fullscreen.window.id)
				puts "Rendering floating child even though in fullscreen mode: floating.transient_for (#{floating_child.window.transient_for}) --> fullscreen.id (#{fullscreen.window.id})"
			else
				next
			end
			puts "Floatiing child at (#{child.rect.x}, #{child.rect.y}) with #{child.rect.width} x #{child.rect.height}"
			x_raise_con(child)
			render(con)
		end
	end
end

def render_output(con)
	x = con.rect.x
	y = con.rect.y
	height = con.rect.height

	con.nodes_head.each do |child|
		if child.type == CT_CON
			if content
				puts "More than one CT_CON on output container"
				return
			end 
			content = child
		else if child.type != CT_DOCKAREA
			puts "Child #{child} of type #{child.type} is inside the OUTPUT con"
			return
		end
	end

	if !content
		puts "Skipping this output because it is currently being destroyed."
		return
	end

	ws = con_get_fullscreen_con(content, CF_OUTPUT)
	if !ws
		puts "Skipping this output because it is currently being destroyed."
		return
	end
	fullscreen = con_get_fullscreen_con(ws, CF_OUTPUT)
	if fullscreen
		fullscreen.rect = con.rect
		x_raise_con(fullscreen)
		render_con(fullscreen)
		return
	end

	con.nodes_head.each do |child|
		if child.type != CT_DOCKAREA
			next
		end

		child.rect.height = 0
		child.nodes_head.each do |dockchild|
			child.rect.height += dockchild.geometry.height
		end

		height -= child.rect.height
	end

	con.nodes_head.each do |child|
		if child.type == CT_CON
			child.rect.x = x
			child.rect.y = y
			child.rect.width = con.rect.width
			child.rect.height = height
		end

		child.rect.x = x
		child.rect.y = y
		child.rect.width = con.rect.width
		child.deco_rect.x = 0
		child.deco_rect.y = 0
		child.deco_rect.width = 0
		child.deco_rect.height = 0

		y += child.rect.height

		puts "Child at #{child.rect.x}, #{child.rect.y} with #{child.rect.width} x #{child.rect.height}"
		x_raise_con(child)
		render_con(child)
	end
end

def render_con_split(con, child, p, i)
	if con.layout == L_SPLITH
		child.rect.x = p.x
		child.rect.y = p.y
		child.rect.width = p.sizes[i]
		child.rect.height = p.rect.height
		p.x += child.rect.width
	else
		child.deco_rect.x = 0
		child.deco_rect.y = 0
		child.rect.height = p.rect.width
		child.rect.height = p.sizes[i]
		p.y += child.rect.height
	end

	if con_is_leaf(child)
		if child.border_style == BS_NORMAL
			child.deco_rect.x = child.rect.x - con.rect.x
			child.deco_rect.x = child.rect.x - con.rect.x

			child.rect.y = += p.deco_height
			child.rect.height = += p.deco_height

			child.deco_rect.width = child.rect.width
			child.deco.rect.height = p.deco_height
		else
			child.deco_rect.x = 0
			child.deco_rect.y = 0
			child.deco_rect.height = 0
			child.deco_rect.height = 0
		end
	end
end

def render_con_stacked(con, child, p, i)
	child.rect.x = p.x
	child.rect.y = p.y
	child.rect.width = p.rect.width
	child.rect.height = p.rect.height

	child.deco_rect.x = p.x - con.rect.x
	child.deco_rect.y = p.y - con.rect.y + (i * p.deco_height)
	child.deco_rect.width = child.rect.width
	child.deco_rect.height = p.deco_height

	if p.children > 1 || (child.border_style != BS_PIXEL && child.border_style != BS_NONE)
		child.rect.y += p.deco_height * p.children
		child.rect.height -= p.deco_height * p.children
	end
end

def render_con_tabbed(con, child, p, i)
	child.rect.x = p.x
	child.rect.y = p.y
	child.rect.width = p.rect.width
	child.rect.height = p.rect.height

	child.deco_rect.width = child.rect.width / p.children
	child.deco_rect.x = p.x - con.rect.x + i * child.deco_rect.width
	child.deco_rect.y = p.y - con.rect.y

	if i == p.children - 1
		child.deco_rect.width = child.rect.width - child.deco_rect.x
	end

	if p.children > 1 || child.border_style != BS_PIXEL && child.border_style != BS_NONE
		child.rect.y += p.deco_height
		child.rect.height -= p.deco_height
		child.deco_rect.height = p.deco_height
	else
		child.deco_rect.height = child.border_style == BS_PIXEL ? 1 : 0
	end
end

def render_con_dockarea(con, child, p)
	child.rect.x = p.x
	child.rect.y = p.y
	child.width = p.rect.width
	child.height = child.geometry.height

	child.deco_rect.x = 0
	child.deco_rect.y = 0
	child.reco_rect.width = 0
	child.deco_rect.height = 0
	p.y += child.rect.height
end
