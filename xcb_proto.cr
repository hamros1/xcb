
lib LibXCB
	XCB_WINDOW_CLASS_COPY_FROM_PARENT = 0
	XCB_WINDOW_CLASS_INPUT_OUTPUT = 1
	XCB_WINDOW_CLASS_INPUT_ONLY = 2

	XCB_KEY_PRESS= 2
	XCB_KEY_RELEASE= 3
	XCB_BUTTON_PRESS= 4
	XCB_BUTTON_RELEASE= 5
	XCB_MOTION_NOTIFY= 6
	XCB_ENTER_NOTIFY= 7
	XCB_LEAVE_NOTIFY= 8
	XCB_FOCUS_IN= 9
	XCB_FOCUS_OUT= 10
	XCB_KEYMAP_NOTIFY= 11
	XCB_EXPOSE= 12
	XCB_GRAPHICS_EXPOSURE= 13
	XCB_NO_EXPOSURE= 14
	XCB_VISIBILITY_NOTIFY= 15
	XCB_CREATE_NOTIFY= 16
	XCB_DESTROY_NOTIFY= 17
	XCB_UNMAP_NOTIFY= 18
	XCB_MAP_NOTIFY= 19
	XCB_MAP_REQUEST= 20
	XCB_REPARENT_NOTIFY= 21
	XCB_CONFIGURE_NOTIFY= 22
	XCB_CONFIGURE_REQUEST= 23
	XCB_GRAVITY_NOTIFY= 24
	XCB_RESIZE_REQUEST= 25
	XCB_CIRCULATE_NOTIFY= 26
	XCB_CIRCULATE_REQUEST= 27
	XCB_PROPERTY_NOTIFY= 28
	XCB_SELECTION_CLEAR= 29
	XCB_SELECTION_REQUEST= 30
	XCB_SELECTION_NOTIFY= 31
	XCB_COLORMAP_NOTIFY= 32
	XCB_CLIENT_MESSAGE= 33
	XCB_MAPPING_NOTIFY= 34
	XCB_GE_GENERIC= 35
	XCB_REQUEST= 1
	XCB_VALUE= 2
	XCB_WINDOW= 3
	XCB_PIXMAP= 4
	XCB_ATOM= 5
	XCB_CURSOR= 6
	XCB_FONT= 7
	XCB_MATCH= 8
	XCB_DRAWABLE= 9
	XCB_ACCESS= 10
	XCB_ALLOC= 11
	XCB_COLORMAP= 12
	XCB_G_CONTEXT= 13
	XCB_ID_CHOICE= 14
	XCB_NAME= 15
	XCB_LENGTH= 16
	XCB_IMPLEMENTATION= 17
	XCB_CREATE_WINDOW= 1
	XCB_CHANGE_WINDOW_ATTRIBUTES= 2
	XCB_GET_WINDOW_ATTRIBUTES= 3
	XCB_DESTROY_WINDOW= 4
	XCB_DESTROY_SUBWINDOWS= 5
	XCB_CHANGE_SAVE_SET= 6
	XCB_REPARENT_WINDOW= 7
	XCB_MAP_WINDOW= 8
	XCB_MAP_SUBWINDOWS= 9
	XCB_UNMAP_WINDOW= 10
	XCB_UNMAP_SUBWINDOWS= 11
	XCB_CONFIGURE_WINDOW= 12
	XCB_CIRCULATE_WINDOW= 13
	XCB_GET_GEOMETRY= 14
	XCB_QUERY_TREE= 15
	XCB_INTERN_ATOM= 16
	XCB_GET_ATOM_NAME= 17
	XCB_CHANGE_PROPERTY= 18
	XCB_DELETE_PROPERTY= 19
	XCB_GET_PROPERTY= 20
	XCB_LIST_PROPERTIES= 21
	XCB_SET_SELECTION_OWNER= 22
	XCB_GET_SELECTION_OWNER= 23
	XCB_CONVERT_SELECTION= 24
	XCB_SEND_EVENT= 25
	XCB_GRAB_POINTER= 26
	XCB_UNGRAB_POINTER= 27
	XCB_GRAB_BUTTON= 28
	XCB_UNGRAB_BUTTON= 29
	XCB_CHANGE_ACTIVE_POINTER_GRAB= 30
	XCB_GRAB_KEYBOARD= 31
	XCB_UNGRAB_KEYBOARD= 32
	XCB_GRAB_KEY= 33
	XCB_UNGRAB_KEY= 34
	XCB_ALLOW_EVENTS= 35
	XCB_GRAB_SERVER= 36
	XCB_UNGRAB_SERVER= 37
	XCB_QUERY_POINTER= 38
	XCB_GET_MOTION_EVENTS= 39
	XCB_TRANSLATE_COORDINATES= 40
	XCB_WARP_POINTER= 41
	XCB_SET_INPUT_FOCUS= 42
	XCB_GET_INPUT_FOCUS= 43
	XCB_QUERY_KEYMAP= 44
	XCB_OPEN_FONT= 45
	XCB_CLOSE_FONT= 46
	XCB_QUERY_FONT= 47
	XCB_QUERY_TEXT_EXTENTS= 48
	XCB_LIST_FONTS= 49
	XCB_LIST_FONTS_WITH_INFO= 50
	XCB_SET_FONT_PATH= 51
	XCB_GET_FONT_PATH= 52
	XCB_CREATE_PIXMAP= 53
	XCB_FREE_PIXMAP= 54
	XCB_CREATE_GC= 55
	XCB_CHANGE_GC= 56
	XCB_COPY_GC= 57
	XCB_SET_DASHES= 58
	XCB_SET_CLIP_RECTANGLES= 59
	XCB_FREE_GC= 60
	XCB_CLEAR_AREA= 61
	XCB_COPY_AREA= 62
	XCB_COPY_PLANE= 63
	XCB_POLY_POINT= 64
	XCB_POLY_LINE= 65
	XCB_POLY_SEGMENT= 66
	XCB_POLY_RECTANGLE= 67
	XCB_POLY_ARC= 68
	XCB_FILL_POLY= 69
	XCB_POLY_FILL_RECTANGLE= 70
	XCB_POLY_FILL_ARC= 71
	XCB_PUT_IMAGE= 72
	XCB_GET_IMAGE= 73
	XCB_POLY_TEXT_8= 74
	XCB_POLY_TEXT_16= 75
	XCB_IMAGE_TEXT_8= 76
	XCB_IMAGE_TEXT_16= 77
	XCB_CREATE_COLORMAP= 78
	XCB_FREE_COLORMAP= 79
	XCB_COPY_COLORMAP_AND_FREE= 80
	XCB_INSTALL_COLORMAP= 81
	XCB_UNINSTALL_COLORMAP= 82
	XCB_LIST_INSTALLED_COLORMAPS= 83
	XCB_ALLOC_COLOR= 84
	XCB_ALLOC_NAMED_COLOR= 85
	XCB_ALLOC_COLOR_CELLS= 86
	XCB_ALLOC_COLOR_PLANES= 87
	XCB_FREE_COLORS= 88
	XCB_STORE_COLORS= 89
	XCB_STORE_NAMED_COLOR= 90
	XCB_QUERY_COLORS= 91
	XCB_LOOKUP_COLOR= 92
	XCB_CREATE_CURSOR= 93
	XCB_CREATE_GLYPH_CURSOR= 94
	XCB_FREE_CURSOR= 95
	XCB_RECOLOR_CURSOR= 96
	XCB_QUERY_BEST_SIZE= 97
	XCB_QUERY_EXTENSION= 98
	XCB_LIST_EXTENSIONS= 99
	XCB_CHANGE_KEYBOARD_MAPPING= 100
	XCB_GET_KEYBOARD_MAPPING= 101
	XCB_CHANGE_KEYBOARD_CONTROL= 102
	XCB_GET_KEYBOARD_CONTROL= 103
	XCB_BELL= 104
	XCB_CHANGE_POINTER_CONTROL= 105
	XCB_GET_POINTER_CONTROL= 106
	XCB_SET_SCREEN_SAVER= 107
	XCB_GET_SCREEN_SAVER= 108
	XCB_CHANGE_HOSTS= 109
	XCB_LIST_HOSTS= 110
	XCB_SET_ACCESS_CONTROL= 111
	XCB_SET_CLOSE_DOWN_MODE= 112
	XCB_KILL_CLIENT= 113
	XCB_ROTATE_PROPERTIES= 114
	XCB_FORCE_SCREEN_SAVER= 115
	XCB_SET_POINTER_MAPPING= 116
	XCB_GET_POINTER_MAPPING= 117
	XCB_SET_MODIFIER_MAPPING= 118
	XCB_GET_MODIFIER_MAPPING= 119
	XCB_NO_OPERATION= 127

	XCB_EVENT_MASK_NO_EVENT              =       0x00
	XCB_EVENT_MASK_KEY_PRESS             =       0x01
	XCB_EVENT_MASK_KEY_RELEASE           =       0x02
	XCB_EVENT_MASK_BUTTON_PRESS          =       0x04
	XCB_EVENT_MASK_BUTTON_RELEASE        =       0x08
	XCB_EVENT_MASK_ENTER_WINDOW          =       0x10
	XCB_EVENT_MASK_LEAVE_WINDOW          =       0x20
	XCB_EVENT_MASK_POINTER_MOTION        =       0x40
	XCB_EVENT_MASK_POINTER_MOTION_HINT   =       0x80
	XCB_EVENT_MASK_BUTTON_1_MOTION       =      0x100
	XCB_EVENT_MASK_BUTTON_2_MOTION       =      0x200
	XCB_EVENT_MASK_BUTTON_3_MOTION       =      0x400
	XCB_EVENT_MASK_BUTTON_4_MOTION       =      0x800
	XCB_EVENT_MASK_BUTTON_5_MOTION       =     0x1000
	XCB_EVENT_MASK_BUTTON_MOTION         =     0x2000
	XCB_EVENT_MASK_KEYMAP_STATE          =     0x4000
	XCB_EVENT_MASK_EXPOSURE              =     0x8000
	XCB_EVENT_MASK_VISIBILITY_CHANGE     =    0x10000
	XCB_EVENT_MASK_STRUCTURE_NOTIFY      =    0x20000
	XCB_EVENT_MASK_RESIZE_REDIRECT       =    0x40000
	XCB_EVENT_MASK_SUBSTRUCTURE_NOTIFY   =    0x80000
	XCB_EVENT_MASK_SUBSTRUCTURE_REDIRECT =   0x100000
	XCB_EVENT_MASK_FOCUS_CHANGE          =   0x200000
	XCB_EVENT_MASK_PROPERTY_CHANGE       =   0x400000
	XCB_EVENT_MASK_COLOR_MAP_CHANGE      =   0x800000
	XCB_EVENT_MASK_OWNER_GRAB_BUTTON     =  0x1000000


	XCB_CW_BACK_PIXMAP      =   0x01
	XCB_CW_BACK_PIXEL       =   0x02
	XCB_CW_BORDER_PIXMAP    =   0x04
	XCB_CW_BORDER_PIXEL     =   0x08
	XCB_CW_BIT_GRAVITY      =   0x10
	XCB_CW_WIN_GRAVITY      =   0x20
	XCB_CW_BACKING_STORE    =   0x40
	XCB_CW_BACKING_PLANES   =   0x80
	XCB_CW_BACKING_PIXEL    =  0x100
	XCB_CW_OVERRIDE_REDIRECT=  0x200
	XCB_CW_SAVE_UNDER       =  0x400
	XCB_CW_EVENT_MASK       =  0x800
	XCB_CW_DONT_PROPAGATE   = 0x1000
	XCB_CW_COLORMAP         = 0x2000
	XCB_CW_CURSOR           = 0x4000 

	XCB_ATOM_NONE                = 0x00
	XCB_ATOM_ANY                 = 0x00
	XCB_ATOM_PRIMARY             = 0x01
	XCB_ATOM_SECONDARY           = 0x02
	XCB_ATOM_ARC                 = 0x03
	XCB_ATOM_ATOM                = 0x04
	XCB_ATOM_BITMAP              = 0x05
	XCB_ATOM_CARDINAL            = 0x06
	XCB_ATOM_COLORMAP            = 0x07
	XCB_ATOM_CURSOR              = 0x08
	XCB_ATOM_CUT_BUFFER0         = 0x09
	XCB_ATOM_CUT_BUFFER1         = 0x0a
	XCB_ATOM_CUT_BUFFER2         = 0x0b
	XCB_ATOM_CUT_BUFFER3         = 0x0c
	XCB_ATOM_CUT_BUFFER4         = 0x0d
	XCB_ATOM_CUT_BUFFER5         = 0x0e
	XCB_ATOM_CUT_BUFFER6         = 0x0f
	XCB_ATOM_CUT_BUFFER7         = 0x10
	XCB_ATOM_DRAWABLE            = 0x11
	XCB_ATOM_FONT                = 0x12
	XCB_ATOM_INTEGER             = 0x13
	XCB_ATOM_PIXMAP              = 0x14
	XCB_ATOM_POINT               = 0x15
	XCB_ATOM_RECTANGLE           = 0x16
	XCB_ATOM_RESOURCE_MANAGER    = 0x17
	XCB_ATOM_RGB_COLOR_MAP       = 0x18
	XCB_ATOM_RGB_BEST_MAP        = 0x19
	XCB_ATOM_RGB_BLUE_MAP        = 0x1a
	XCB_ATOM_RGB_DEFAULT_MAP     = 0x1b
	XCB_ATOM_RGB_GRAY_MAP        = 0x1c
	XCB_ATOM_RGB_GREEN_MAP       = 0x1d
	XCB_ATOM_RGB_RED_MAP         = 0x1e
	XCB_ATOM_STRING              = 0x1f
	XCB_ATOM_VISUALID            = 0x20
	XCB_ATOM_WINDOW              = 0x21
	XCB_ATOM_WM_COMMAND          = 0x22
	XCB_ATOM_WM_HINTS            = 0x23
	XCB_ATOM_WM_CLIENT_MACHINE   = 0x24
	XCB_ATOM_WM_ICON_NAME        = 0x25
	XCB_ATOM_WM_ICON_SIZE        = 0x26
	XCB_ATOM_WM_NAME             = 0x27
	XCB_ATOM_WM_NORMAL_HINTS     = 0x28
	XCB_ATOM_WM_SIZE_HINTS       = 0x29
	XCB_ATOM_WM_ZOOM_HINTS       = 0x2a
	XCB_ATOM_MIN_SPACE           = 0x2b
	XCB_ATOM_NORM_SPACE          = 0x2c
	XCB_ATOM_MAX_SPACE           = 0x2d
	XCB_ATOM_END_SPACE           = 0x2e
	XCB_ATOM_SUPERSCRIPT_X       = 0x2f
	XCB_ATOM_SUPERSCRIPT_Y       = 0x30
	XCB_ATOM_SUBSCRIPT_X         = 0x31
	XCB_ATOM_SUBSCRIPT_Y         = 0x32
	XCB_ATOM_UNDERLINE_POSITION  = 0x33
	XCB_ATOM_UNDERLINE_THICKNESS = 0x34
	XCB_ATOM_STRIKEOUT_ASCENT    = 0x35
	XCB_ATOM_STRIKEOUT_DESCENT   = 0x36
	XCB_ATOM_ITALIC_ANGLE        = 0x37
	XCB_ATOM_X_HEIGHT            = 0x38
	XCB_ATOM_QUAD_WIDTH          = 0x39
	XCB_ATOM_WEIGHT              = 0x3a
	XCB_ATOM_POINT_SIZE          = 0x3b
	XCB_ATOM_RESOLUTION          = 0x3c
	XCB_ATOM_COPYRIGHT           = 0x3d
	XCB_ATOM_NOTICE             = 0x3e
	XCB_ATOM_FONT_NAME           = 0x3f
	XCB_ATOM_FAMILY_NAME         = 0x40
	XCB_ATOM_FULL_NAME           = 0x41
	XCB_ATOM_CAP_HEIGHT          = 0x42
	XCB_ATOM_WM_CLASS            = 0x43
	XCB_ATOM_WM_TRANSIENT_FOR    = 0x44 

	XCB_PROP_MODE_REPLACE = 0x00
	XCB_PROP_MODE_PREPEND = 0x01
	XCB_PROP_MODE_APPEND  = 0x02

	XCB_COLORMAP_ALLOC_NONE = 0x00
	XCB_COLORMAP_ALLOC_ALL = 0x01

	struct KeyPressEvent
    response_type : UInt8
    detail : KeyCode
    sequence : UInt16
    time : Timestamp
    root : Window
    event : Window
    child : Window
    root_x : Int16
    root_y : Int16
    event_x : Int16
    event_y : Int16
    state : UInt16
    same_screen : UInt8
    pad0 : UInt8
	end

	type KeyReleaseEvent = KeyPressEvent

struct MappingNotifyEvent
     response_type : UInt8
     pad0 : UInt8
     sequence : UInt16
     request : UInt8
     first_keycode : KeyCode
     count : UInt8
     pad1 : UInt8
end

	struct Setup
		status : UInt8
		pad0 : UInt8
		protocol_major_version : UInt16
		protocol_minor_version : UInt16
		length : UInt16
		release_number : UInt32
		resource_id_base : UInt32
		resource_id_mask : UInt32
		motion_buffer_size : UInt32
		vendor_len : UInt16
		maximum_request_length : UInt16
		roots_len : UInt8
		pixmap_formats_len : UInt8
		image_byte_order : UInt8
		bitmap_format_bit_order : UInt8
		bitmap_format_scanline_unit : UInt8
		bitmap_format_scanline_pad : UInt8
		min_keycode : KeyCode
		max_keycode : KeyCode
		pad : StaticArray(UInt8, 4)
	end

	alias KeyCode = UInt32
	struct KeyCodeIterator
		data : Pointer(KeyCode)
		rem : Int32
		index : Int32
	end

	struct Screen
		root : Window
		default_colormap : UInt32
		white_pixel : UInt32
		black_pixel : UInt32
		current_input_masks : UInt32
		width_in_pixels : UInt16
		height_in_pixels : UInt16
		width_in_millimeters : UInt16
		height_in_millimeters : UInt16
		min_installed_maps : UInt16
		max_installed_maps : UInt16
		root_visual : Int64
		backing_stores : UInt8
		save_unders : UInt8
		root_depth : UInt8
		allowed_depths_len : UInt8
	end

	struct ScreenIterator
		data : Pointer(Screen)
		rem : Int32
		index : Int32
	end

	struct Visualtype
		visual_id : Visualid
		class_ : UInt8
		bits_per_rgb_value : UInt8
		colormap_entries : UInt16
		red_mask : UInt32
		green_mask : UInt32
		blue_mask : UInt32
		pad0 : StaticArray(UInt8, 4)
	end

	struct GetGeometryCookie
		sequence : UInt32
	end

	struct QueryPointerCookie
		sequence : UInt32
	end

	struct InternAtomReply
response_type : UInt8
		pad0 : UInt8
		sequence : UInt16
		length : UInt32
		atom : Atom
	end

	struct AtomCookie
		sequence : UInt32
	end

	struct GetSelectionOwnerCookie
		sequence : UInt32
	end

	       struct GetSelectionOwnerReply
           response_type : UInt8
           pad0 : UInt8
           sequence : UInt16
           length : UInt32
           owner : Window
end

	fun xcb_setup_roots_iterator(x0 : Pointer(Setup)) : ScreenIterator
	fun xcb_change_window_attributes(x0 : Pointer(Connection), x1 : Window, x2 : UInt32, x3 : Pointer(Void))
	fun xcb_change_property(x0 : Pointer(Connection), x1 : UInt8, x2 : Window, x3 : Atom, x4 : Atom, x5 : UInt8, x6 : UInt32, x7 : Void*) : VoidCookie
	fun xcb_create_colormap_checked(x0 : Pointer(Connection), x1 : UInt8, x2 : UInt32, x3 : Window, x4 : Visualid) : VoidCookie
	fun xcb_get_geometry(x0 : Pointer(Connection), x1 : Drawable) : GetGeometryCookie
	fun xcb_query_pointer(x0 : Pointer(Connection), x1 : Window) : QueryPointerCookie
	fun xcb_flush(x0 : Pointer(Connection)) : Int32
	fun xcb_create_window(x0 : Pointer(Connection), x1 : UInt8, x2 : Window, x3 : Window, x4 : Int16, x5 : Int16, x6 : UInt16, x7 : UInt16, x8 : UInt16, x9 : UInt16, x10 : Int64, x11 : UInt32, x12 : Pointer(Void)) : VoidCookie
	fun xcb_change_window_attributes_checked(x0 : Pointer(Connection), x1 : Window, x2 : UInt32, x3 : Pointer(Void)) : VoidCookie
  fun xcb_intern_atom(x0 : Pointer(Connection), x1 : UInt8, x2 : UInt16, x3 : Pointer(Char)) : InternAtomCookie
	fun xcb_intern_atom_reply(Pointer(Connection), InternAtomCookie, Pointer(GenericError*)) : Pointer(InternAtomReply)
	fun xcb_get_selection_owner(Pointer(Connection), Atom) : GetSelectionOwnerCookie
	fun xcb_get_selection_owner_reply(Pointer(Connection), GetSelectionOwnerCookie, Pointer(GenericError*)) : Pointer(GetSelectionOwnerReply)
end
