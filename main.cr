require "./**"

ewmh = Pointer.malloc(1, sizeof(LibXCB::EwmhConnection))
default_screen = uninitialized Int32

dpy = LibXCB.xcb_connect(nil, pointerof(default_screen))

screen = LibXCB.xcb_setup_roots_iterator(LibXCB.xcb_get_setup(dpy)).data
screen = screen.value

root = screen.root

screen_width = screen.width_in_pixels
screen_height = screen.height_in_pixels

values = [LibXCB::XCB_EVENT_MASK_SUBSTRUCTURE_NOTIFY |LibXCB::XCB_EVENT_MASK_SUBSTRUCTURE_REDIRECT | LibXCB::XCB_EVENT_MASK_BUTTON_PRESS | LibXCB::XCB_EVENT_MASK_ENTER_WINDOW | LibXCB::XCB_EVENT_MASK_LEAVE_WINDOW | LibXCB::XCB_EVENT_MASK_STRUCTURE_NOTIFY | LibXCB::XCB_EVENT_MASK_PROPERTY_CHANGE]

LibXCB.xcb_change_window_attributes_checked(dpy, root, LibXCB::XCB_CW_EVENT_MASK | LibXCB::XCB_CW_CURSOR, values)

syms = LibXCB.xcb_key_symbols_alloc(dpy)

wm_protocols = LibXCB.xcb_intern_atom_reply(dpy, LibXCB.xcb_intern_atom(dpy, 0, "WM_PROTOCOLS".size, "WM_PROTOCOLS".as(Pointer(Char))), nil).value.atom
net_supported = LibXCB.xcb_intern_atom_reply(dpy, LibXCB.xcb_intern_atom(dpy, 0, "_NET_SUPPORTED".size, "_NET_SUPPORTED".as(Pointer(Char))), nil).value.atom

def updatenumlockmask
	reply = LibXCB.xcb_get_modifier_mapping_reply(dpy, LibXCB.xcb_get_modifier_mapping(dpy), nil)
	codes = LibXCB.xcb_get_modifier_mapping_keycodes(reply)
	if temp = LibXCB.xcb_key_symbols_get_keycode(syms, XK_Num_Lock)
		target = temp.ptr
	end
	8.times do |i|
		reply.keycodes_per_modifier.each do |j|
			if codes[i * reply.keycodes_per_modifier + j] == target
				numlockmask = (1 << i)
			end
		end
	end
end

def grabkeys
	updatenumlockmask
	LibXCB.xcb_ungrab_key(dpy, LibXCB::XCB_GRAB_ANY, root, LibXCB::XCB_MOD_MASK_ANY)

	keys.each do |key|
		if key.func
			if code = LibXCB.xcb_key_symbols_get_keycode(syms, key.keysyms)
				LibXCB.xcb_grab_key(dpy, true, root, key.mod, code, LibXCB::XCB_GRAB_MODE_ASYNC)
				LibXCB.xcb_grab_key(dpy, true, root, key.mod | XCB_MOD_MASK_LOCK, code, XCB_GRAB_MODE_ASYNC)
				LibXCB.xcb_grab_key(dpy, true, root, key.mod | numlockmask, code, LibXCB::XCB_GRAB_MODE_ASYNC)
				LibXCB.xcb_grab_key(dpy, true, root, key.mod | numlockmask | LibXCB::XCB_MOD_MASK_LOCK, code, LibXCB::XCB_GRAB_MODE_ASYNC)
			end
		end
	end
end
