@[Link("xcb")]
lib LibXCB
	alias Atom = UInt32
	type Visualid = Void*
	type Visualtype = Void*
	alias Window = UInt32
	alias GContext = UInt32
	alias Drawable = UInt32
	type GetPropertyCookie = Void* 
	type GetPropertyReply = Void*
	type InternAtomCookie = Void*
	alias Timestamp = UInt32
	alias Gravity = UInt32
	type GetSelectionOwnerCookie = Void*
	type GetSelectionOwnerReply = Void*
	type Pixmap = Void*
	
	fun GetProperty(Pointer(Connection), UInt8, Window, Atom, Atom, UInt32, UInt32) : GetPropertyCookie 

	X_PROTOCOL = 11

	X_PROTOCOL_REVISION = 0

	X_TCP_PORT = 6000

	XCB_CONN_ERROR = 1

	XCB_CONN_CLOSED_EXT_NOTSUPPORTED = 2

	XCB_CONN_CLOSED_MEM_INSUFFICIENT = 3

	XCB_CONN_CLOSED_REQ_LEN_EXCEED = 4

	XCB_CONN_CLOSED_PARSE_ERR = 5

	XCB_CONN_CLOSED_INVALID_SCREEN = 6

	XCB_CONN_CLOSED_FDPASSING_FAILED = 7

	type Connection = Void*

	struct GenericIterator 
		data :    Pointer(Void)
		rem :     Int32 
		index :   Int32 
	end

	struct GenericReply 
		response_type :   UInt8   
		pad0 :            UInt8  
		sequence :        UInt16 
		length :          UInt32 
	end

	struct GenericEvent 
		response_type :   UInt8   
		pad0 :            UInt8  
		sequence :        UInt16 
		pad :          StaticArray(UInt32, 7)
		full_sequence :   UInt32 
	end

	struct RawGenericEvent 
		response_type :   UInt8   
		pad0 :            UInt8  
		sequence :        UInt16 
		pad : StaticArray(UInt32, 7)           
	end

	struct GeEvent 
		response_type :   UInt8  
		pad0 :            UInt8  
		sequence :        UInt16 
		length : UInt32 
		event_type : UInt16 
		pad1 : UInt16 
		pad :          StaticArray(UInt32, 5)
		full_sequence :   UInt32 
	end

	struct GenericError 
		response_type :   UInt8   
		error_code :      UInt8   
		sequence :        UInt16 
		resource_id :      UInt32 
		minor_code :       UInt16 
		major_code :        UInt8 
		pad0 : UInt8 
		pad :          StaticArray(UInt32, 5)
		full_sequence :   UInt32 
	end

	struct VoidCookie 
		sequence :   UInt32 
	end

	XCB_NONE = 0_i64

	XCB_COPY_FROM_PARENT = 0_i64

	XCB_CURRENT_TIME = 0_i64

	XCB_NO_SYMBOL = 0_i64

	struct AuthInfo 
		namelen : Int32     
		name :      Pointer(Char)
		datalen :   Int32   
		data :    Pointer(Char)
	end

	fun xcb_flush(x0 : Pointer(Connection)) : Int32 

	fun xcb_get_maximum_request_length(x0 : Pointer(Connection)) : UInt32 

	fun xcb_prefetch_maximum_request_length(x0 : Pointer(Connection)) : UInt32 

	fun xcb_wait_for_event(x0 : Pointer(Connection)) : Pointer(GenericEvent)

	fun xcb_poll_for_event(x0 : Pointer(Connection)) : Pointer(GenericEvent) 

	fun xcb_poll_for_queued_event(x0 : Pointer(Connection) ) : Pointer(GenericEvent)

	type SpecialEvent = Void*

	fun xcb_poll_for_special_event(x0 : Pointer(Connection), x1 : Pointer(SpecialEvent)) : Pointer(GenericEvent)

	fun xcb_wait_for_special_event(x0 : Pointer(Connection), x1 : Pointer(SpecialEvent)) : Pointer(GenericEvent)

	type Extension = Void*

	fun xcb_register_for_special_xge(x0 : Pointer(Connection) , x1 : Pointer(Extension), x2 : UInt32, x3 : Pointer(UInt32)) : Pointer(SpecialEvent)

	fun xcb_unregister_for_special_event(x0 : Pointer(Connection) , x1 : Pointer(SpecialEvent)) : Void 

	fun xcb_request_check(x0 : Pointer(Connection), x1 : VoidCookie) : Pointer(GenericError)

	fun xcb_discard_reply(x0 : Pointer(Connection), x1 : UInt32) : Void 

	fun xcb_discard_reply64(x0 : Pointer(Connection), x1 : UInt64) : Void 

	fun xcb_prefetch_extension_data(x0 : Pointer(Connection) , x1 : Pointer(Extension)) : Void 

	fun xcb_get_file_descriptor(x0 : Pointer(Connection) ) : Int32 

	fun xcb_connection_has_error(x0 : Pointer(Connection) ) : Int32 

	fun xcb_connect_to_fd(x0 : Int32, x1 : Pointer(AuthInfo)) : Pointer(Connection)

	fun xcb_disconnect(x0 : Pointer(Connection)) : Void

	type Setup = Void*

	fun xcb_get_setup(x0 : Pointer(Connection)) : Pointer(Setup)

	fun xcb_parse_display(x0 : Pointer(Char), x1 : Pointer(Char*), x2 : Pointer(Int32), x3 : Pointer(Int32)) : Int32 

	fun xcb_connect(x0 : Pointer(Char), x1 : Pointer(Int32)) : Pointer(Connection)

	fun xcb_connect_to_display_with_auth_info(x0 : Pointer(Char), x1 : Pointer(AuthInfo), x2 : Pointer(Int32)) : Pointer(Connection)
end
