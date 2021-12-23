alias CursorContext = Void
alias Cursor = UInt32

struct CursorIterator
	data : Cursor*
	rem : Int32
	index : Int32
end

fun xcb_cursor_context_free(ctx : CursorContext)
fun xcb_cursor_context_new(conn : Connection, screen : XcbScreenT*, ctx : CursorContext*) : Int32
fun xcb_cursor_end(i : CursorIterator) : GenericIterator
fun xcb_cursor_load_cursor(ctx : CursorContext, name : Char*) : Cursor
fun xcb_cursor_next(i : CursorIterator*)
fun xcb_free_cursor(c : Connection, cursor : Cursor) : VoidCookie
fun xcb_free_cursor_checked(c : Connection, cursor : Cursor) : VoidCookie
