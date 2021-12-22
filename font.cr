struct Font
	property type : FontType
	property height : Int32
	property pattern : String
	property id : LibXCB::Font
	property info : LibXCB::QueryFontReply
	property table : LibXCB::CharInfo
	property pango_desc : PangoFontDescription
end

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
	pango_layout_set_font_description(layout, saved_font.specific.pango_desc)
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
	yoffset = (height - saved_font.height) / 2
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
	pango_layout_set_font_description(layout, saved_font.specific.pango_desc)
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
	font.type = FONT_TYPE_NONE
	pattern = nil

	return font if !conn

	if pattern.size > "pango:".size && !"pango:".compare(pattern)
		font_pattern = pattern + "xft:"
		if load_pango_font(pointerof(font), font_pattern)
			font.pattern = pattern.dup
			return font
		end
	end

	font.specific.xcb.id = xcb_generate_id(conn)

	font_cookie = xcb_open_font_checked(conn, font.specific.xcb.id, pattern.size, pattern)
	info_cookie = xcb_query_font(conn, font.specific.xcb.id)

	error = xcb_request_check(conn, font_cookie)
	if fallback && error
		puts "Could not open font #{pattern} (X error #{error.error_code}). Trying fallback to 'fixed'."

		pattern = "fixed"
		font_cookie = xcb_open_font_checked(conn, font.specific.xcb.id, pattern.size, pattern)
		info_cookie = xcb_query_font(conn, font.specific.xcb.id)

		error = xcb_request_check(conn, font_cookie)
		if error
			puts "Could not open fallback font 'fixed', trying with '-misc-*'"

			pattern = "-misc-*"
			font_cookie = xcb_open_font_checked(conn, font.specific.xcb.id, pattern.size, pattern)
			info_cookie = xcb_query_font(conn, font.specific.xcb.id)

			if error = xcb_request_check(conn, font_cookie)
				puts "Could open neither requested font nor fallbacks (fixed or -misc-*): X11 error #{error.error_code}"
				exit
			end 
		end
	end

	font.pattern = pattern.dup
	puts "Using X font #{pattern}"

	if !font.specific.xcb.info = xcb_query_font_reply(conn, info_cookie, nil)
		puts "Could not load font #{pattern}"
		exit
	end

	if !xcb_query_font_char_infos_length(font.specific.xcb.info)
		font.specific.xcb.table = nil
	else
		font.specific.xcb.table = xcb_query_font_char_infos(font.specific.xcb.info)
	end

	font.height = font.specific.xcb.info.font_ascent + font.specific.xcb.info.font_descent
	font.type = FONT_TYPE_XCB
	return font
end

def set_font_colors(gc, foreground, background)
	case saved_font.type
	when FONT_TYPE_NONE
		break
	when FONT_TYPE_XCB
		mask = XCB_GC_FOREGROUND | XCB_GC_BACKGROUND | XCB_GC_FONT
		values = [foreground.colorpixel, background.colorpixel, saved_font.specific.xcb.id]
		xcb_change_gc(conn, gc, mask, values)
	when FONT_TYPE_PANGO
		pango_font_red = foreground.red
		pango_font_green = foreground.green
		pango_font_blue = foreground.blue
		break
	end
end

def font_is_pango?
	return saved_font.type == FONT_TYPE_PANGO
end

def draw_text_xcb(text, text_len, drawable, gc, x, y)
	pos_y = y + saved_font.specific.xcb.info.font_ascent
	offset = 0
	loop do
		chunk_size = text_len > 255 ? 255 : text_len
		chunk = (text + offset)
		xcb_image_text_16(conn, chunk_size, drawable, gc, x, pos_y, chunk)
		offset += chunk_size
		text_len -= chunk_size
		break if text_len == 0
		x += predict_text_width_xcb(chunk, chunk_size)
	end
end

def draw_text(text, drawable, gc, surface, x, y, max_width)
	case saved_font.type
	when FONT_TYPE_NONE
		return
	when FONT_TYPE_XCB
		draw_text_xcb(text, string_get_num_glyphs(text), drawable, gc, x, y)
		break
	when FONT_TYPE_PANGO
		draw_text_pango(string_as_utf8(text), string_get_num_bytes(text), drawable, surface, x, y, max_width, string_is_markup(text))
		return
	end
end

def xcb_query_text_width(input, text_len)
	return if !text_len
	width = 0
	if !saved_font.specific.xcb.table
		width = xcb_query_text_width(input, text_len)
	else
		font_info = saved_font.specific.xcb.info
		font_table = saved_font.specific.xcb.table
		width = 0
		text_len.times do |i|
			row = input[i].byte1
			col = input[i].byte2
			if row < font_info.min_byte1 ||
				 row > font_info.max_byte1 ||
				 col < font_info.min_char_or_byte2 ||
				 col > font_info.max_char_or_byte2
				next
			end
			if !(info.character_width != 0 ||
				 (info.right_side_bearing | 
				 info.left_side_bearing |
				 info.ascent |
				 info.descent))
			width += info.character_width
			end
		end
		return width
	end
end

def predict_text_width(text)
	case saved_font.type
	when FONT_TYPE_NONE
		return 0
	when FONT_TYPE_XCB
		return predict_text_width_xcb(string_as_ucs2(text), string_get_num_glyphs(text))
	when FONT_TYPE_PANGO
		return predict_text_width_pango(string_as_utf8(text), string_get_num_bytes(text), string_is_markup(text))
	end
end
