def draw_util_surface_init(conn, surface, drawable, visual, width, height)
	surface.id = drawable
	surface.width = width
	surface.height = height

	if !visual
		visual = visual_type
	end

	surface.gc = xcb_generate_id(conn)
	gc_cookie = xcb_create_gc_checked(conn, surface.gc, surface.id, 0, nil)

	error = xcb_request_check(conn, gc_cookie)
	if error
		puts "Could not create graphical context. Error code #{error.error_code}. Please report this bug."
		exit
	end 

	surface.surface = cairo_xcb_surface_create(conn, surface.id, visual, width, height)
	surface.cr = cairo_create(surface.surface)
end

def draw_util_surface_free(conn, surface)
	status = CAIRO_STATUS_SUCCESS
	if surface.cr
		status = cairo_status(surface.cr)
	end
	if status != CAIRO_STATUS_SUCCESS
		puts "Found cairo context in an error status while freeing, error #{status} is #{cairo_status_to_string}"
		exit
	end
	
	xcb_free_gc(conn, surface.gc)
	cairo_surface_destory(surface.surface)
	cairo_destroy(surface.cr)

	surface.surface = nil
	surface.cr = nil
end

def draw_util_set_size(surface, width, height)
	surface.width = width
	surface.height = height
	cairo_xcb_surface_set_size(surface.surface, width, height)
end

def draw_util_hex_to_color(color)
	if color.size == "rrggbbaa".size
		alpha[0] = color[7]
		alpha[1] = color[8]
	else
		alpha[0] = alpha[1] = 'F'
	end

	groups[4][3] = [[color[1], color[2], '\0'], [color[3], color[4], '\0'], [color[5], color[6], '\0'], [alpha[0], alpha[1], '\0']]

	return Color.new(red: groups[0].as(Int16) / 255,  green: groups[1].as(Int16) / 255, blue: groups[2].as(Int16) / 255, alpha: groups[3].as(Int16) / 255, colorpixel: get_colorpixel(color))
end

def draw_util_set_source_color(surface, color)
	cairo_set_source_rgba(surface.cr, color.red, color.green, color.blue, color.alpha)
end

def draw_util_text(text, surface, fg_color, bg_color)
	cairo_surface_flush(surface.surface)
	cairo_surface_flush(surface.surface)

	set_font_colors(surface.gc, fg_color, bg_color)
	draw_text(text, surface.id, surface.gc, surface.surface, x, y, max_width)

	cairo_surface_mark_dirty(surface.surface)
end

def draw_util_image(image, surface, x, y, width, height)
	cairo_save(surface.cr)

	cairo_translate(surface.cr, x, y)

	src_width = cairo_image_surface_get_width(image)
	src_height = cairo_image_surface_get_height(image)
	scale = width / src_width, height / src_height
	cairo_scale(surface.cr, scale, scale)

	cairo_set_source_surface(surface.cr, image, 0, 0)
	cairo_paint(surface.cr)

	cairo_restore(surface.cr)
end

def draw_util_rectange(surface, color, x, y, w, h)
	cairo_save(surface.cr)

	cairo_set_operator(surface.cr, x, y, w, h)
	draw_util_set_source_color(surface.cr)

	cairo_fill(surface.cr)

	cairo_surface_flush(surface.surface)
	cairo_surface_flush(surface.surface)

	cairo_restore(surface.cr)
end

def draw_util_clear_surface(surface, color)
	cairo_save(surface.cr)

	cairo_set_operator(surface.cr, CAIRO_OPERATOR_SOURCE)

	draw_util_set_source_color(surface, color)
	cairo_paint(surface.cr)

	cairo_surface_flush(surface.surface)
	cairo_surface_flush(surface.surface)

	cairo_restore(surface.cr)
end

def draw_util_copy_surface(src, dest, src_x, src_y, dest_x, dest_y, width,, height)
	cairo_save(dest.cr)

	cairo_set_operator(dest.cr, CAIRO_OPERATOR_SOURCE)
	cairo_set_source_surface(dest.cr, src.surface, dest_x - src_x, dest_y - src_y)

	cairo_rectangle(dest.cr, dest_x, dest_y, width, height)
	cairo_fill(dest.cr)

	cairo_surface_flush(src.surface)
	cairo_surface_flush(src.surface)
	cairo_surface_flush(dest.surface)
	cairo_surface_flush(dest.surface)

	cairo_restore(dest.cr)
end
