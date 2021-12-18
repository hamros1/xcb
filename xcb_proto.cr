@[Link("xcb")]
lib LibXCB

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
		root_visual : Visualid
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

	fun xcb_setup_roots_iterator(x0 : Pointer(Setup)) : ScreenIterator
	fun xcb_change_window_attributes(x0 : Pointer(Connection), x1 : Window, x2 : UInt32, x3 : Pointer(Void))
	fun xcb_change_property(x0 : Pointer(Connection), x1 : UInt8, x2 : Window, x3 : Atom, x4 : Atom, x5 : UInt8, x6 : UInt32, x7 : Void*) : VoidCookie
	fun xcb_create_colormap_checked(x0 : Pointer(Connection), x1 : UInt8, x2 : UInt32, x3 : Window, x4 : Visualid) : VoidCookie
end
