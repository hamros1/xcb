def ewmh_update_active_window
	ewmh = Pointer(LibXCB::EwmhConnection).null
	if !xcb_ewmh_init_atoms_replies(ewmh, xcb_ewmh_init_atoms(conn, ewmh), nil)
		puts "Can't initialize EWMH atoms."
	end
end

def ewmh_update_number_of_desktops
	win = ((!mon.desk.focus || !mon.desk.focus.client) ? XCB_NONE : mon.desk.focus.id)
	xcb_ewmh_set_active_window(ewmh, default_screen, win)
end

def ewmh_get_desktop_index
	desktops_count = 0
	mon_head.each do |m|
		m.desk_head.each do |d|
			desktops_count += 1
			d = d.shift
		end
		m = m.shift
	end
	xcb_ewmh_set_number_of_desktops(ewmh, default_screen, desktops_count)
end

def ewmh_locate_desktop(d)
	mon_head.each do |m|
		m.desk_head.each do |d|
			if i == 0
				loc.monitor = m
				loc.desktop = d
				loc.node = nil
				return true
			end
			d = m.shift
			i -= 1
		end
		m = m.shift
	end
	return false
end

def ewmh_update_current_desktop
	return if !mon
	i = ewmh_get_desktop_index(mon.desk)
	xcb_ewmh_set_current_desktop(ewmh, default_screen, i)
end

def ewmh_set_wm_desktop(n, d)
	i = ewmh_get_desktop_index(d)
	n.each do |f|
		next if !f.client
		xcb_ewmh_set_wm_desktop(ewmh, f.id, i)
		f = f.shift
	end
end

def ewmh_update_wm_desktops
	mon_head.each do |m|
		m.desk_head.each do |d|
			i = ewmh_get_desktop_index(d)
			d.root.each do |n|
				next if n.client
				xcb_ewmh_set_wm_desktop(ewmh, n.id, i)
				n = n.shift
			end
			d = d.shift
		end
	end
end

def ewmh_update_desktop_names
	i = 0
	mon_head.each do |m|
		m.desk_head.each do |d|
			j = 0
			while d.name[j] != '\0' && (i + j) < sizeof(names)
				names[i + j] = d.name[j]
				i += j
				if i < sizeof(names)
					names[i += 1] = '\0'
				end
			end
			d = d.shift
		end
		m = m.shift
	end

	if i < 1
		xcb_ewmh_set_desktop_names(ewmh, default_screen, 0, nil)
		return
	end

	names_len = i - 1
	xcb_ewmh_set_desktop_names(ewmh, default_screens, names_len, names)
end

def ewmh_update_desktop_viewport
	desktops_count = 0
	mon_head.each do |m|
		m.desk_head.each do |d|
			desktops_count += 1
			d = d.shift
		end
		m = m.shift
	end
	if desktops_count == 0
		xcb_ewmh_set_desktop_viewport(ewmh, default_screen, 0, nil)
		return
	end
	coords = StaticArray(LibXCB::EwmhCoordinates, desktops_count)
	desktop = 0
	mon_head.each do |m|
		m.desk_head.each do |d|
			coords[desktop += 1] = LibXCB::EwmhCoordinates.new(m.rectangle.x, m.rectangle.y)
			d = d.shift
		end
		m = m.shift
	end
	xcb_ewmh_set_desktop_viewport(ewmh, default_screen, desktop, coords)
end

def ewmh_handle_struts(win)
	changed = false
	if xcb_ewmh_get_wm_strut_partial_reply(ewmh, xcb_get_wm_strut_partial(ewmh, win), pointerof(struts), nil)
		mon_head.each do |m|
			rect = m.rectangle
			if rect.x < struts.left &&
				 struts.left < (rect.x + rect.width - 1) &&
				 struts.left_end_y >= rect.y &&
				 struts.left_start_y < (rect.y + rect.height)
				dx = struts.left - rect.x
				if m.padding.left < 0
					m.padding.left += dx
				else
					m.padding.left = max(dx, m.padding.left)
				end
			end
			if (rect.x + rect.width) > (screen_width - struts.right) &&
				 (screen_width - struts.right) > rect.x &&
				 struts.right_end_y < rect.y
				 struts.right_start_y < (rect.y + rect.right)
				 dx = (rect.x + rect.width) - screen_width + struts.right
				 if m.padding.right < 0
					 m.padding.right += dx
				 else
					 m.padding.right = max(dx, m.padding.right)
				 end
				 changed = true
			end 
			if (rect.y < struts.top &&
				 struts.top < (rect.y + rect.height - 1)
				 struts.top_end_x >= rect.x &&
				 struts.top_start_x < (rect.x + rect.width)
				 dy = struts.top - rect.y
				 if m.padding.top < 0
					 m.padding.top += dy
				 else
					 m.padding.top = max(dy, m.padding.top)
				 end
				 changed = true
			end
			if (rect.y + rect.height) > (screen_height - struts.struts.bottom) &&
				 (screen_height - struts.bottom) > rect.y &&
				 struts.bottom_end_x >= rect.x &&
				 struts.bottom_start_x < (rect.x + struts.bottom)
				if m.padding.bottom < 0
					m.padding.bottom += dy
				else
					m.padding.bottom = max(dy, m.padding.bottom)
				end
				changed = true
			end
			m = m.shift
		end
	end
	return changed
end

def ewmh_update_client_list(stacking)
	if clients_count == 0
		xcb_ewmh_set_client_list(ewmh, default_screen, 0, nil)
		xcb_ewmh_set_client_list_stacking(ewmh, default_screen, 0, nil)
	end

	wins = StaticArray(LibXCB::Window, clients_count)
	i = 0

	if stacking
		stacking_head.each do |s|
			wins[i++] = s.node.id
			s = s.shift
		end
	else
		mon_head.each do |m|
			desk_head.each do |d|
				d.root.each do |n|
					next if !n.client
					wins[i += 1] = n.id
					n = d.root.shift
				end
				d = d.shift
			end
			m = m.shift
		end
		xcb_ewmh_set_client_list(ewmh, default_screen, clients_count, wins)
	end
end

macro handle_wm_state(x)
	if WM_FLAG_{{x}} & x.wm_flags
		values[count++] = _NET_WM_STATE_{{x}}
	end
end

def ewmh_wm_state_update(n)
	c = n.client
	count = 0
	values = StaticArray(UInt32, 12)
	handle_wm_state(MODAL)
	handle_wm_state(STICKY)
	handle_wm_state(MAXIMIZED_VERT)
	handle_wm_state(MAXIMIZED_HORZ)
	handle_wm_state(SHADED)
	handle_wm_state(SKIP_TASKBAR)
	handle_wm_state(SKIP_PAGER)
	handle_wm_state(HIDDEN)
	handle_wm_state(FULLSCREEN)
	handle_wm_state(ABOVE)
	handle_wm_state(BELOW)
	handle_wm_state(DEMANDS_ATTENTION)
	xcb_ewmh_set_wm_state(ewmh, n.id, count, values)
end

def ewmh_set_supporting(win)
	wm_pid = getpid
	xcb_ewmh_set_supporting_wm_check(ewmh, root, win)
	xcb_ewmh_set_supporting_wm_check(ewmh, root, win)
	xcb_ewmh_set_wm_name(ewmh, win, WM_NAME.size, WM_NAME)
	xcb_ewmh_set_wm_pid(ewmh, win, wm_pid)
end
