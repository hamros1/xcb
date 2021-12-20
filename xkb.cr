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

type Context = Void*
alias KeymapCompileFlags = UInt64
alias KeymapFormat = UInt64
alias ActionControls = UInt64
alias Keycode = UInt32
alias Keys = UInt64
alias ModMask = UInt32
alias ModIndex = UInt32
alias LayoutIndex = UInt32

struct ContextIncludePaths
	context : Context
	ind : UInt32
	len : UInt32
end

struct SymInterpret
	sym : Keysym
	match : UInt64
	mods : ModMask
	virtual_mod : ModIndex
	action : Action
	level_one_only : Bool
	repeat : Bool
end

struct Keymap
    ctx : Pointer(Context)
    refcnt : Int32
    flags : KeymapCompileFlags
		format : KeymapFormat
    enabled_ctrls : ActionControls
    min_key_code : Keycode 
    max_key_code : Keycode 
    keys : Pointer(Keys)
    num_key_aliases : UInt32
    key_aliases : Pointer(KeyAlias)
    types : Pointer(Keytypes)
    num_types : UInt32
    num_sym_interprets : UInt32
    sym_interprets : Pointer(SymInterpret)
    mods : ModSet
    num_groups : LayoutIndex 
    num_group_names : LayoutIndex 
    group_names : Pointer(Atom)
    leds : StaticArray(Led, XKB_MAX_LEDS)
    num_leds : UInt32
    keycodes_section_name : Pointer(Char)
    symbols_section_name : Pointer(Char)
    types_section_name : Pointer(Char)
    compat_section_name : Pointer(Char)
end

struct KeymapLayouts
	keymap : Keymap
	ind : LayoutIndex
	len : LayoutIndex
end

struct KeymapLeds
	keymap : Keymap
	ind : LedIndex
	len : LedIndex
end

struct KeymapMods
	keymap : Keymap
	ind : ModIndex
	len : ModIndex
end

fun xcb_xkb_use_extension(x0 : Pointer(Connection), x1 : UInt16, x2 : UInt16) : PerClientFlagsReply

fun xcb_xkb_select_events(x0 : Pointer(Connection), x1 : DeviceSpec, x2 : UInt16, x3 : UInt16, x4 : UInt16, x5 : UInt16, x6 : UInt16, x7 : Pointer(Void)) : VoidCookie

fun xcb_xkb_per_client_flags_reply(x0 : Pointer(Connection), x1 : PerClientFlagsCookie, x2 : Pointer(GenericError*)) : PerClientFlagsReply
end

type State = Void*
fun xcb_state_new(x0 : Pointer(Keymap)) : Pointer(State)
