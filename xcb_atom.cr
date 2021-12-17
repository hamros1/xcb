@[Link("XCB")]
lib LibXCB
	TAG_COOKIE = 0
	TAG_VALUE = 1

	struct AtomFastCookie
		tag : Int32 
		u : Tuple(xcb_Int32ern_atom_cookie_t, Atom)
	end

	fun xcb_atom_get(x0 : Pointer(Connection), Pointer(Char)) : Atom 
	fun xcb_atom_get_predefined(x0 : UInt16, Pointer(Char)) : Atom 
	fun xcb_atom_get_fast(x0 : Pointer(Connection), x1 : UInt8, x2 : UInt16, x3 : Pointer(Char)) : AtomFastCookie 
	fun Atom xcb_atom_get_fast_reply(x0 : Pointer(Connection), x1 : AtomFastCookie, x2 : Pointer(xcb_generic_error_t*)) : 

		fun xcb_atom_get_name_predefined(x0 : Atom) : Pointer(Char)
	fun xcb_atom_get_name(x0 : Pointer(Connection), x1 : Atom, x2 : Pointer(Char*), x3 : Pointer(Int32)) : Int32 

	fun xcb_atom_name_by_screen(x0 : Pointer(Char), x1 : UInt8) : Pointer(Char)
	fun xcb_atom_name_by_resource(x0 : Pointer(Char), x2 : UInt32) : Pointer(Char)
	fun xcb_atom_name_unique(x0 : Pointer(Char), x1 : UInt32) : Pointer(Char)
end
