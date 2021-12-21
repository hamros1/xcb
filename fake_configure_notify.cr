def fake_configure_notfiy(conn, rect, window, border_width)
	event = LibXCB.xcb_configure_notify_event(
		event: window,
		window: window,
		response_type: XCB_CONFIGURE_NOTIFY,
		x: rect.x,
		y: rect.y,
		width: r.width,
		height: r.height,
		border_width: border_width,
		above_sibling: XCB_NONE,
		override_redirect: false
	)
	LibXCB.xcb_send_event(conn, false, window, XCB_EVENT_MASK_STRUCTURE_NOTIFY, pointerof(event).as(Char*)
	xcb_flush(conn)
end
