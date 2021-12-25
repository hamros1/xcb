def sync_respond(window, rnd)
	puts "[sync protocol] Sending random value #{rnd} back to X11 window #{window}"
	ev = ClientMessageEvent.new(
		response_type: XCB_CLIENT_MESSAGE,
		window: window,
		type: A_I3_SYNC,
		format: 32,
		data: ([window, rnd])
	)
	xcb_send_event(conn, false, window, XCB_EVENT_MASK_NO_EVENT, ev.as(Char*))
	xcb_flush(conn)
end
