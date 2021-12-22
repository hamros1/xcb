def mousegrabber_grab(cursor)
	grab_ptr_c = xcb_grab_pointer_unchecked(conn, false, root, XCB_EVENT_MASK_BUTTON_PRESS | XCB_EVENT_MASK_BUTTON_RELEASE | XCB_EVENT_MASK_POINTER_MOTION, XCB_GRAB_MODE_ASYNC, XCB_GRAB_MODE_ASYNC, root, cursor, XCB_CURRENT_TIME)
	if grab_ptr_r = xcb_grab_pointer_reply(conn, grab_ptr_c, nil)
		return true
	end
	C.usleep 1000
	return false
end
