@[Link("xcb")]
lib LibXCB
alias DeviceSpec = UInt16

struct PerClientFlagsReply
	response_type : UInt8
	deviceID : UInt8
	sequence : UInt16
	length : UInt32
	supported : UInt32
	value : UInt32
	autoCtrls : UInt32
	autoCrlsValues : UInt32
	pad0 : StaticArray(UInt8, 8)
end

struct PerClientFlagsCookie
	sequence : UInt32
end

fun xcb_xkb_use_extension(x0 : Pointer(Connection), x1 : UInt16, x2 : UInt16) : PerClientFlagsReply

fun xcb_xkb_select_events(x0 : Pointer(Connection), x1 : DeviceSpec, x2 : UInt16, x3 : UInt16, x4 : UInt16, x5 : UInt16, x6 : UInt16, x7 : Pointer(Void)) : VoidCookie

fun xcb_xkb_per_client_flags_reply(x0 : Pointer(Connection), x1 : PerClientFlagsCookie, x2 : Pointer(GenericError*)) : PerClientFlagsReply
end
