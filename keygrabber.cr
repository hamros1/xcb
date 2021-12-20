def grab
	1000.times do |i|
		if xgb = xcb_grab_keyboard_reply(conn, xcb_grab_keyboard(conn, true, root_screen_.root, XCB_CURRENT_TIME, XCB_GRAB_MODE_ASYNC, XCB_GRAB_MODE_ASYNC), nil)
			return true
		end
		#usleep(1000)
	end
	return false
end

def control?
	return buf[0] >= 0 && buf[0] < 0x20 || buf[0] == 0x7f
end

def handle
	buf = StaticArray(Char, 64)
	if control?
		keysym = xcb_key_symbols_get_keysym(keysyms, e.detail, 0)
		xkb_keysym_get_name(keysym, buf, buf.size)
	end
end
