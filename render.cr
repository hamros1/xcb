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
end

def render_root(con, fullscreen)
end

def render_output(con)
end

def render_con_split(con, child, p, i)
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
