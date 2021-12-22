struct Output
	x : Int32
	y : Int32
	width : Int32
	height : Int32
	active : Bool
end

def get_screen_at(x, y)
	outputs.each do |output|
		if output.x == x && output.y == y
			return output
		end
	end
end

def query_screens(conn)
	reply = xcb_xinerama_query_screens_reply(conn, xcb_xinerama_query_screens_unchecked(conn), nil)
	if !reply
		puts "Couldn't get Xinerama screens"
		return
	end

	screen_info = xcb_xinerama_query_screens_info(reply)
	screens = xcb_xinerama_query_screens_screen_info_length(reply)

	screens.each do |screen|
		s = get_screen_at(screen_info[screen].x_org, screen_info[screen].y_org)
		if s
			s.rect.width = s.rect.width, screen_info[screen].width
			s.rect.height = s.rect.height, screen_info[screen].height
		else
			s = Screen.new(x: screen_info[screen].x_org, y: screen_info[screen].y_org, width: screen_info[screen].width, height: screen_info[screen].height, active: true)
			if s.x == 0 && s.y == 0
				outputs.insert(0, s)
			else
				outputs.insert(-1, s)
			end
			output_init_con(s)
			init_ws_for_output(s)
			num_screens += 1
		end

		puts "Found Xinerama screen: #{screen_info[screen].width} x #{screen_info[screen].height} at #{screen_info[screen].x_org} x #{screen_info[screen].y_org}"
	end

	if num_screens == 0
		puts("No screens found. Exiting.")
		exit
	end
end

def use_root_output(conn)
end

def xinerama_init
	if !xcb_get_extension_data(conn, xcb_xinerama_id).present
		puts "Xinerama extension not found, using root output."
		use_root_output
	else
		reply = xcb_xinerama_is_active_reply(conn, xcb_xinerama_is_active(conn), nil)
		if !reply || !reply.state
			puts "Xinerama is not active (in your X-Server), using root output."
			use_root_output(conn)
		else
			query_screens(conn)
		end
	end
end
