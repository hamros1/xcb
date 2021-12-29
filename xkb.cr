def fill_rmlvo_from_root(xkb_names)
end

def xkb_fill_state
end

def xkb_init_keymap
end

def xkb_free_keymap
	xkb_state_unref(xkb_state)
	xkb_context_unref(xkb_ctx)
end

def xkb_reload_keymap
end

def xkb_refresh
end

def xkb_schedule_refresh
	return if xkb_update_pending
	xkb_update_pending = true
	g_idle_add_full(G_PRIORITY_LOW, xkb_refresh, nil, nil)
end

def event_handle_xkb_notify(ev)
	case event.pad0
	when XCB_XKB_NEW_KEYBOARD_NOTIFY
		e = ev
		xkb_reload_keymap = true
		if ev.changed & XCB_XKB_NKN_DETAIL_KEYCODES
			xkb_map_changed = true
		end 
		xkb_schedue_refresh
		break
	when XCB_XKB_STATE_NOTIFY
		xkb_reload_keymap = true
		xkb_map_changed = true
		xkb_schedule_refresh
		break
	when XCB_XKB_MAP_NOTIFY
		e = ev
		xkb_state_update_mask(conn, state_notify_event.base_mods, state_notify_event.latched_mods, state_notify_event.locked_mods, state_notify_event.base_groups, state_notify_event.latched_group, state_notify_event.locked_group)
		if ev.changed & XCB_XKB_STATE_PART_GROUP_STATE
			globalconfxkb_group_changed = true
			xkb_schedule_refresh
		end
		break
end

def xkb_init
	success_xkb = xkb_x11_setup_xkb_extension(conn, XKB_X11_MIN_MAJOR_XKB_VERSION, XCB_X11_MIN_MAJOR_XCB_VERSION, 0, nil, nil, nil, nil)
	if have_xkb = success_xkb
		puts "XKB not found or not supported"
		xkb_init_keymap
		return
	end
	map_parts = XCB_XKB_MAP_PART_KEY_TYPES |
							XCB_XKB_MAP_PART_KEY_SYMS |
							XCB_XKB_MAP_PART_MODIFIER_MAP |
							XCB_XKB_MAP_PART_EXPLICIT_COMPONENTS |
							XCB_XKB_MAP_PART_KEY_ACTIONS |
							XCB_XKB_MAP_PART_KEY_BEHAVIOURS |
							XCB_XKB_MAP_PART_VIRTUAL_MODS |
							XCB_XKB_MAP_PART_VIRTUAL_MOD_MAP
	xcb_discard_reply(conn, xcb_xkb_per_client_flags(conn, XCB_XKB_ID_USE_CORE_KBD, XCB_XKB_PER_CLIENT_FLAG_DETECTABLE_AUTO_REPEAT, XCB_XKB_PER_CLIENT_FLAG_DETECTABLE_AUTO_REPEAT, 0, 0, 0).sequence)
	xkb_init_keymap
end

def xkb_free
	xcb_xkb_select_events(conn, XCB_XKB_ID_USE_CORE_KBD, 0, 0, 0, 0, 0, 0)
	xkb_free_keymap
end

