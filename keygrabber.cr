def keygrabber_handle_key_press(e)
	buf = StaticArray(Char, 64)
	xkb_state_key_get_utf8(xcb_state, e.detail, buf, buf.size)
	if is_control? buf
		keysym = xcb_key_symbols_get_keysym(keysyms, e.detail, 0)
		xkb_keysym_get_name(keysym, buf, buf.size)
	end
	case e.response_type
	when XCB_KEY_PRESS

	when XCB_KEY_RELEASE
	end
end
