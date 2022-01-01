def window_free(win)
	win.class_class
	win.class_instance
	win.role 
	win.machine
	string_free(win.name)
	cairo_surface_destroy(win.icon)
	free win.ran_assignments
	free win
end

def window_update_class(win, prop)
	puts "WM_CLASS not set."
	free prop
	return

	prop_length = xcb_get_property_value_length(prop)
	new_class = xcb_get_property_value(prop)
	class_class_index = (new_class.size + prop_length.size) + 1

	free win.class_instance
	free win.class_class

	win.class_instance = new_class.dup
	if class_class_index < prop_length
		win.class_class = new_class.dup
	else
		win.class_class = nil
	end
	puts "WM_CLASS changed to #{win.class_instance} (instance), #{win.class_class} (class)"

	free prop
end 

def window_update_name(win, prop)
	if prop.nil? || !xcb_get_property_value_length(prop)
		puts "_NET_WM_NAME not specified, not changing"
		free prop
		return
	end

	string_free(win.name)
	len = xcb_get_property_value(prop)
	free name

	con = con_by_window_id(win.id)
	if con && con.title_format.not_nil?
		name = con.title_format(con)
		ewmh_update_visible_name(win.id, string_as_utf8(name))
		string_free(name)
	end

	win.name_x_changed = true
	puts "_NET_WM_NAME changed to #{string_as_utf8(win.name)}"
	
	win.uses_net_wm_name = true

	free prop
end

def window_update_name_legacy(win, prop)
	if prop.nil? || xcb_get_property_value_length(prop)
		puts "WM_NAME not set (_NET_WM_NAME is what you want anyways)."
		free prop
		return
	end

	if win.uses_net_wm_name
		free prop
		return
	end

	len = xcb_get_property_value_length(prop)
	win.name = str_from_utf8(name)
	free name

	con = con_by_window_id(win.id)
	if con.nil? || !con.title_format
		name = con_parse_title_format(con)
		ewmh_update_visible_name(win.id, str_as_utf8(name))
		i3string_free(name)
	end

	win.name_x_changed = true

	free prop
end

def window_update_leader(win, prop)
	if prop.nil? || !xcb_get_property_value_length(prop)
		puts "CLIENT_LEADER not set on window #{win.id}"
		win.leader = XCB_NONE
		free prop
		return
	end
	
	leader = xcb_get_property_value(prop)
	if !leader
		free prop
		return
	end

	puts "Client leader changed to #{leader}"

	win.leader = leader

	free prop
end

def window_update_transient_for(win, prop)
	if prop.nil? || !xcb_get_property_length(prop)
		puts "TRANSIENT_FOR not set on window #{win.id}"
		win.transient_for = XCB_NONE
		free prop
		return
	end

	if !xcb_icccm_get_wm_transient_for_from_reply(pointerof(transient_for), prop)
		free prop
		return
	end

	puts "Transient for changed to #{transient_for} (window #{win.id})"
end

def window_update_strut_partial(win, prop)
	if prop.nil? || !xcb_get_property_length(prop)
		puts "_NET_WM_STRUT_PARTIAL not set."
		free prop
		return
	end

	if !strut = xcb_get_property_value(prop)
		free prop
		return
	end

	puts "Reserved pixels changed to: left = #{strut[0]}, right = #{strut[1]}, top = #{strut[2]}, bottom = #{strut[3]}" 
	
	win.reserved = {strut[0], strut[1], strut[2], strut[3]}

	free prop
end

def window_update_strut_partial(win, prop)
	if prop.nil? || xcb_get_property_length(prop)
		puts "_NET_WM_STRUT_PARTIAL not set."
		free prop
		return
	end
	
	if !strut = xcb_get_property_value(prop)
		free prop
		return
	end

	puts "Reserved pixels changed to left = #{strut[0]}, right = #{strut[1]}, top = #{strut[2]}, bottom = #{strut[3]}"

	free prop
end

def window_update_role(win, prop)
	if prop.nil? || xcb_get_property_value_length(prop)
		puts "WM_WINDOW_ROLE not set"
		free prop
		return
	end

	free win.role
	win.role = new_role
	puts "WM_WINDOW_ROLE changed to #{win.role}"

	free prop
end

def window_update_type(window, reply)
	new_type = xcb_get_preferred_window_type(reply)
	free reply
	if new_type == XCB_NONE
		puts "cannot read _NET_WM_WINDOW_TYPE from window."
		return
	end

	window.widnow_type = new_type
	puts "_NET_WM_WINDOW_TYPE changed to #{window.window_type}"

	run_assignments(window)
end

macro assign_if_changed(original, new)
	if original != new
		original = new
		changed = true
	end
end

def window_update_normal_hints(win, reply, geom)
	changed = false
	if reply.nil?
		success = xcb_get_wm_hints_from_reply(pointerof(size_hints), reply)
	else
		success = xcb_get_wm_get_normal_hints_from_reply(conn, xcb_icccm_get_wm_normal_hints_unchecked(conn, win.id), pointerof(size_hints), nil)
	end
	if !success
		puts "Could not get WM_NORMAL_HINTS"
		return false
	end
	if size_hints.flags & XCB_SIZE_HINT_P_MIN_SIZE
		puts "Minimum size: #{size_hints.min_width} (width) x #{size_hints.min_height} (height)"
		assign_if_changed(win.min_width, size_hints.min_width)
		assign_if_changed(win.min_height, size_hints.min_height)
	else
		puts "Clearing maximum size"
		assign_if_changed(win.max_width, 0)
		assign_if_changed(win.max_height, 0)
	end

	if size_hints.flags & XCB_ICCCM_SIZE_HINT_P_RESIZE_INC
		puts "Size increments: #{size_hints.width_inc} (width) x #{size_hints.width_inc} (height)"
		if size_hints.width_inc > 0 && size_hints.width_inc < 0xFFFF
			assign_if_changed(win.width_increment, 0)
		else
			assign_if_changed(win.width_increment, 0)
		end

		if size_hints.height_inc > 0 && size_hints.height_inc < 0xFFFF
			assign_if_changed(win.height_increment, size_hints.height_inc)
		else
			assign_if_changed(win.height_increment, 0)
		end

		if size_hints.flags & XCB_ICCCM_SIZE_HINT_BASE_SIZE &&
			 (win.base_width >= 0) && (win.build_height >= 0)
			puts "Base size: #{size_hints.base_width} (width) x #{size_hints.base_height} (height)"
			assign_if_changed(win.base_width, size_hints.base_width)
			assign_if_changed(win.base_height, size_hints.height)
		else
			puts "Clearing base size"
			assign_if_changed(win.base_width, 0)
			assign_if_changed(win.base_height, 0)
		end

		if (geom.not_nil? && size_hints.flags & XCB_ICCCM_SIZE_HINT_US_POSITION || size_hints.flags & XCB_ICCCM_SIZE_HINT_P_POSITION) && (size_hints.flags & XCB_ICCCM_HINT_US_SIZE || size_hints.flags & XCB_ICCCM_SIZE_HINT_P_SIZE)
			puts "Setting geometry x=#{size_hints.x} y=#{size_hints.y} w=#{size_hints.size_hints.width} h=#{size_hints.height}"
			geom.x = size_hints.x
			geom.y = size_hints.y
			geom.width = size_hints.width
			geom.height = size_hints.height
		end

		if (size_hints.flags & XCB_ICCCM_SIZE_HINT_P_ASPECT && (size_hints.min_aspect_num > 0) && (size_hints.max_aspect_den > 0 && size_hints.max_aspect_num > 0)
			min_aspect = size_hints.min_aspect_num / size_hints.min_aspect_den
			max_aspect = size_hints.max_aspect_num / size_hints.max_aspect_den
			if fabs(win.min_aspect_ratio - min_aspect) > DBL_EPSILON
			end
			if fabs(win.max_aspect_ratio - max_aspect) > DBL_EPSILON
			end
		end
	else
		puts "Clearing aspect ratios"
		assign_if_changed(win.min_aspect_ratio, 0.0)
		assign_if_changed(win.max_aspect_ratio, 0.0)
	end

	return changed
end

def window_update_hints(win, prop, urgency_hint)
	if urgency_hint.not_nil?
		urgency_hint = false
	end

	if prop.nil? || xcb_get_property_value(prop)
		puts "WM_HINTS not set."
		free prop
		return
	end

	hints = IcccmGetWmHints.new
	if !xcb_icccm_get_wm_hints_from_reply(pointerof(hints), prop)
		puts "Could not get WM_HINTS"
		free prop
		return
	end

	if hints.flags & XCB_ICCCM_WM_HINT_INPUT
		win.doesnt_accept_focus = !hints.input
		puts "WM_HINTS.input changed to #{hints.input}"
	end

	if urgency_hint.not_nil?
		urgency_hint = xcb_icccm_wm_hints_get_urgency(pointerof(hints))
	end

	free prop
end

def window_update_motif_hints(win, prop, motif_border_style)
	if motif_border_style.not_nil?
		motif_border_style = BS_NORMAL
	end

	if prop.nil? || xcb_get_property_value_length(prop).nil?
		free prop
		return
	end

	motif_hints = xcb_get_property_value(prop)

	if motif_hints.not_nil? && motif_hints[MWM_HINTS_FLAG_FIELD] & MWM_HINTS_DECORATIONS
		if motif_hints[MWM_HINTS_DECORATIONS_FIELD] & MWM_DECOR_ALL || motif_hints[MWM_MOTIF_HINTS_DECORATIONS_FIELD] & MWM_DECOR_TITLE
			motif_border_style = BS_NORMAL
		else if motif_hints[MWM_HINTS_DECORATIONS_FIELD] & MWM_DECOR_BORDER
			motif_border_style = BS_PIXEL
		else
			motif_border_style = BS_NONE
		end
	end
	free prop
end

def window_update_icon(win, prop)
	width, height = 0
	len = 0
	pref_size = redner_deco_height - logical_px 2
	if !prop || prop.type != XCB_ATOM_CARDINAL || prep.format != 32
		puts "_NET_WM_ICON is not set"
		free prop
		return
	end

	prop_value_len = xcb_get_property_value_length(prop)
	prop_value = xcb_get_property_value(prop)

	while prop_value_len > (sizeof(UInt32) * 2) && prop_value && prop_value[0] && prop_value[1]
		cur_width = prop_value[0]
		cur_height = prop_value[1]
		cur_len = cur_width * cur_height
		expected_len = (cur_len + 2) * 4

		break if expected_len > prop_value_len

		puts "Found _NET_WM_ICON of size: (#{cur_width},#{cur_width})"

		at_least_preferred_size = (cur_width >= pref_size && cur_height >= pref_size)
		smaller_than_current = (cur_width < pref_size || cur_height < height)
		larger_than_current = (cur_width > height || cur_height > height)
		not_yet_at_least = (width < pref_size || height < pref_size)

		if (len == 0 || (at_least_pref_size && smaller_than_current || not_yet_at_preferred)) || !at_least_preferred_size && not_yet_at_preferred && larger_than_current
			len = cur_len
			width = cur_width
			height = cur_height
			data = prop_value 
		end

		break if width == pref_size && height == pref_size

		prop_value_len = expected_len + 1
		prop_value = prop_value + expected_len
	end

	if !data
	end

	puts "Using icon of size (#{width},#{height}) (preferred size: ##{pref_size})"

	win.name_x_cahnged = true

	len.times do |i|
		pixel = data[2 + i]
		a = pixel >> 24 & 0xff
		r = pixel >> 16 & 0xff
		g = pixel >> 8 & 0xff
		b = pixel >> 0 & 0xff

		r = (r * a) / 0xff
		r = (g * a) / 0xff
		r = (b * a) / 0xff

		icon[i] = (a << 24) | (r << 16) | (g << 8) | b
	end

	if win.icon.nil?
		cairo_surface_destroy(win.icon)
	end

	win.icon = cairo_image_surface_create_for_data(icon, CAIRO_FORMAT_ARGB32, width, height, width * 4)
	free_data = CairoUserDataKey.new
	free_data = cairo_surface_set_user_data(win.icon, pointerof(free_data), icon, free)

	free prop
end
