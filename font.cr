def create_layout_with_dpi(cr)
	context = pango_cairo_create_context(cr)
	pango_cairo_context_set_resolution(context, get_dpi_value())
	layout = pango_layout_new(context)
	g_object_unref(context)
	return layout
end

def load_pango_font(font, desc)
	font.specific.pango_desc = pango_font_description_from_string(desc)
	if !font.specific.pango_desc
		puts "Could not open font #{desc} with Pango, fallback to X font"
		return false
	end
	puts "Using Pango font #{pango_font_description_get_family(font.specific.pango_desc)}, size #{pango_font_description_get_size(font.specific.pango_desc)}"
	root_visual_type = get_visualtype(root_screen)
	surface = cairo_xcb_surface_create(conn, root_screen.root, root_visual_type, 1, 1)
	cr = cairo_create(surface)
	layout = create_layout_with_dpi(cr)
	pango_layout_set_font_description(layout, font.specific.pango_desc)
	height = 0
	pango_layout_get_pixel_size(layout, pointerof(height))
	font.height = height
	g_object_unref(layout)
	cairo_destroy(cr)
	cairo_surface_destroy(surface)
	font.type = FONT_TYPE_PANGO
	return true
end

def draw_text_pango(text, text_len, drawable, surface, x, y, max_width, pango_markup)
	cr = cairo_create(surface)
	layout = create_layout_with_dpi(cr)
	pango_layout_set_font_description(layout, savedFont.specific.pango_desc)
	pango_layout_set_width(layout, max_width * PANGO_SCALE)
	pango_layout_set_wrap(layout, PANGO_WRAP_CHAR)
	pango_layout_set_ellipsize(layout, PANGO_ELLIPSIZE_END)
	if pango_markup
		pango_layout_set_markup(layout, text, text_len)
	else
		pango_layout_set_text(layout, text, text_len)
	end
	cairo_set_operator(cr, CAIRO_OPERATOR_SURFACE)
	cairo_set_source_rgb(cr, pango_font_red, pango_font_green, pango_font_blue)
	pango_cairo_update_layout(cr, layout)
	height = 0
	pango_layout_get_pixel_size(layout, nil, pointerof(height))
	yoffset = (height - savedFont.height) / 2
	cairo_move_to(cr, x, y - yoffset)
	pango_cairo_show_layout(cr, layout)
	g_object_unref(layout)
	cairo_destroy(cr)
end

def predict_text_width_pango(text, text_len, pango_markup)
	surface = cairo_xcb_surface_create(conn, root_screen.root, root_visual_type, 1, 1)
	cr = cairo_create(surface)
	layout = create_layout_with_dpi(cr)
	width = 0
	pango_layout_set_font_description(layout, savedFont.specific.pango_desc)
	if pango_markup
		pango_layout_set_markup(layout, text, text_len)
	else
		pango_layout_set_text(layout, text, text_len)
	end
	pango_cairo_update_layout(cr, layout)
	pango_layout_get_pixel_size(layout, pointerof(width), nil)
	g_object_unref(layout)
	cairo_destroy(cr)
	cairo_surface_destroy(surface)
	return width
end

def load_font(pattern, fallback)
end
