@[Link("xcb-keysyms")]
lib LibXCB
	type KeySymbols = Void*

	fun xcb_key_symbols_alloc(Pointer(Connection)) : Pointer(KeySymbols)

	fun xcb_key_symbols_free(Pointer(KeySymbols)) : Void

	fun xcb_key_symbols_get_keysym(Pointer(KeySymbols), KeyCode, Int32) : UInt32      

	fun xcb_key_symbols_get_keycode(Pointer(KeySymbols), UInt32) : Pointer(KeyCode)

	fun xcb_key_press_lookup_keysym(Pointer(KeySymbols), Pointer(KeyPressEvent), Int32) : UInt32      

	fun xcb_key_release_lookup_keysym(Pointer(KeySymbols), Pointer(KeyReleaseEvent), Int32) : UInt32      

	fun xcb_refresh_keyboard_mapping (Pointer(KeySymbols), Pointer(MappingNotifyEvent)) : Int32            

	fun xcb_is_keypad_key(UInt32) : Int32 

	fun xcb_is_private_keypad_key(UInt32) : Int32 

	fun xcb_is_cursor_key(UInt32) : Int32 

	fun xcb_is_pf_key(UInt32) : Int32 

	fun xcb_is_function_key(UInt32) : Int32 

	fun xcb_is_misc_function_key(UInt32) : Int32 

	fun xcb_is_modifier_key(UInt32) : Int32 

end
