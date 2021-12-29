struct DragCb
	prepare : EvPrepare
	result : DragResult
	con : Container
	event : ButtonPressEvent
	old_rect : Rect
	callback : Callback
	threshold_exceeded : Bool
	xcursor : Cursor
	extra : Pointer(Void)
end

def threshold_exceeded(x1, y1, x2, y2)
	threshold = 9
	return (x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2) > threshold * threshold
end

def drain_drag_events(ev, dragloop)
	until !event = xcb_poll_for_event(conn)
		if !event.response_type
			puts "X11 EError received (probably harmless)! sequence #{error.sequence}, error_code = #{error.error_code}"
			next
		end

		type = event.response_type & 0x7F

		case type
		when XCB_BUTTON_RELEASE
			dragloop.result = DRAG_SUCCESS
			break
		when XCB_KEY_PRESS
			puts "A key was pressd during drag, reverting changes."
			dragloop.result = DRAG_REVERT
			handle_event(type, ev)
			break
		when XCB_UNMAP_UNOTIFY
			if con = con_by_window_id(unmap_event.window)
				puts "UnmapNotify for window #{unmap_event.window} (container #{con}"

				if con_get_workspace(con) == con_get_workspace(focused)
					puts "UnmapNotify for a managed window on the current workspace, aborting"
					dragloop.result = DRAG_ABORT
				end
			end
		when XCB_MOTION_NOTIFY
			last_motion_notify = ev
			break
		else
			puts "Passing to original handler"
			handle_event(type, ev)
			break
		end 

		if dragloop.result != DRAGGING
			ev_break(EV_A_ EVBREAK_ONE)
			break if dragloop.result == DRAG_SUCCESS else return true
		end
	end

	return true if last_motion_notify.nil?

	if !dragloop.threshold_exceeded && threshold_exceeded(last_motion_notify.root_x, last_motion_notify.root_y, dragloop.event.root_x, dragloop.event.root_y)
		if dragloop.xcursor != XCB_NONE
			xcb_change_active_pointer_grab(conn, dragloop.xcursor, XCB_CURRENT_TIME, XCB_EVENT_MASK_BUTTON_RELEASE | XCB_EVENT_MASK_POINTER_MOTION)
		end
		dragloop.threshold_exceeded = true
	end

	if dragloop.threshold_exceeded && !dragloop.con || con_exists(dragloop.con)
		dragloop.callback(dragloop.con, pointerof(dragloop.old_rect), last_motion_notify.root_x, last_motion_notify.root_y, dragloop.event, dragloop.extra)
	end

	xcb_flush(con)
	return dragloop.result != DRAGGING
end

def xcb_drag_prepare_cb(w, revents)
	dragloop = w.data
	until drain_drag_events(EV_A, dragloop)
	end
end

def drag_pointer(con, event, confine_to, cursor, use_threshold, callback, extra)
	xcursor = cursor xcursor ? xcursor_get_cursor(cursor) : XCB_NONE
	cookie = xcb_grab_pointer_reply(conn, false, root, XCB_EVENT_MASK_BUTTON_RELEASE | XCB_EVENT_MASK_BUTTON_RELEASE, XCB_GRAB_MODE_ASYNC, XCB_GRAB_MODE_ASYNC, confine_to, use_threshold : XCB_NONE, XCB_CURRENT_TIME)
	if reply = xcb_grab_pointer_reply(conn, cookie, pointerof(error))
		puts "Could not grab pointer (error code = #{error.error_code}"
		return DRAG_ABORT
	end

	if !keyb_reply = xcb_grab_keyboard_reply(conn, keyb_reply, pointerof(error))
		puts "Could not grab keyboard (error_code = #{error.error_code}"
		return DRAB_ABORT
	end

	prepare = pointerof(_loop.prepare)
	_loop.old = con.not_nil!.rect
	ev_prepare_init(prepare, xcb_drag_prepare_cb)
	ev_prepare_start(main_loop, prepare)

	ev_loop(main_loop, 0)

	ev_prepare_stop(main_loop, prepare)
	main_set_x11_cb true

	ev_prepare_stop(main_loop, prepare)
	main_set_x11_cb true

	xcb_ungrab_keyboard(conn, XCB_CURRENT_TIME)
	xcb_ungrab_keyboard(conn, XCB_CURRENT_TIME)
	xcb_flush(conn)

	return _loop.result
end
