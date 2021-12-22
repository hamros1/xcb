require "./**"

def handle_key_release
	puts "Releasing #{event.detail}, state raw #{event.state}"

	sym = xcb_key_press_lookup_keysym(symbols, event, event.state)
	if sym == XK_Mode_Switch
		puts "Mode switch disabled"
		modeswitch_active = false
	end

	return 1
end

def handle_key_press(ignored, conn, event)
	puts "Keypress #{event.detail}, state raw = #{event.state}"

	col = event.stae & XCB_MOD_MASK_SHIFT

	if modeswitch_active
		col += 2
	end

	sym = xcb_key_press_lookup_keysym(symbols, event, col)
	if sym == XK_Mode_switch
		puts "Mode switch enabled"
		modeswitch_active = true
		return 1
	end

	if sym == XK_Return
		finish_input
	end

	if sym == XK_BackSpace
		if input_position == 0
			return 1
		end

		input_position -= 1

		handle_expose(nil, conn, nil)
		return 1
	end

	if sym == XK_Escape
		exit
	end

	puts "is_keypad_key = #{xcb_is_keypad_key(sym)}"
	puts "is_private_keypad_key = #{xcb_is_private_keypad_key(sym)}"
	puts "xcb_is_cursor_key = #{xcb_is_cursor_key(sym)}"
	puts "xcb_is_pf_key = #{xcb_is_pf_key(sym)}"
	puts "xcb_is_function_key = #{xcb_is_function_key(sym)}"
	puts "xcb_is_misc_function_key = #{xcb_is_misc_function_key(sym)}"
	puts "xcb_is_modifier_key = #{xcb_is_modifier_key(sym)}"

	if xcb_is_modifier_key(sym) || xcb_is_cursor_key(sym)
		return 1
	end

	ucs = keysym2ucs(sym)
	if ucs == -1
		puts "Keysym could not be converted to UCS, skipping"
		return 1
	end

	inp = LibXCB::Char2b.new(byte1: (ucs & 0xff00) >> 2, byte2: (ucs & 0x00ff) >> 0)
	
	puts "inp.byte1 = #{inp.byte1}, inp.byte2 = #{inp.byte2}"

	_out = convert_ucs2_to_utf8(pointerof(inp), 1)

	puts "Converted to #{_out}"

	glyphs_ucs[input_position] = inp
	glyphs_utf8[input_position] = _out
	input_position += 1

	if input_position == limit
		finish_input
	end

	handle_expose(nil, conn, nil)
	return 1
end

def get_window_position
end
