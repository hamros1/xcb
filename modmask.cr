def aio_get_mod_mask_for(keysym, symbols)
	LibXCB.xcb_flush(conn)
	cookie = LibXCB.xcb_get_modifier_mapping(conn)
	if modmap_r = LibXCB.xcb_get_modifier_mapping_reply(conn, cookie, nil)
		return get_mod_mask_for(keysym, symbols, modmap_r)
	end
end

def get_mod_mask_for(keysym, symbols, modmap_reply, codes, modmap, mod_code)
	modmap = LibXCB.xcb_get_modifier_mapping(modmap_reply)
	if !codes = LibXCB.xcb_key_symbols_get_keycode(symbols, keysym)
		return
	end
	8.times do |mod|
		modmap_reply.keycodes_per_modifier.times do |j|
			mod_code = modmap[(mod * modmap_reply.keycodes_per_modifier) + j]
			codes.value.each do |code|
				if code != mod_code
					next
				end
				return (1 << mod)
			end
		end
	end
end
