XCB_SHAPE_MAJOR_VERSION = 1
XCB_SHAPE_MINOR_VERSION = 1

alias XCB_SHAPE_OP_T = UInt8

struct ShapeOpIterator
	data : Pointer(ShapeOp)
	rem : Int32
	index : Int32
end 

alias ShapeKind = UInt8

struct ShapeKindIterator
	data : Pointer(ShapeKind)
	rem : Int32
	index : Int32
end

alias ShapeSo = UInt32

XCB_SHAPE_SO_SET = 0x00
XCB_SHAPE_SO_UNION = 0x01
XCB_SHAPE_SO_INTERSECT = 0x02
XCB_SHAPE_SO_SUBTRACT = 0x03
XCB_SHAPE_SO_INVERT = 0x04

alias ShapeSk = UInt32
XCB_SHAPE_SK_BOUNDING = 0x00
XCB_SHAPE_SK_CLIP = 0x01
XCB_SHAPE_SK_INPUT = 0x02

struct ShapeNotifyEvent
	response_type : UInt8
	shape_kind : ShapeKind
	sequence : UInt16
	affected_window : Window
	extents_x : Int16
	extents_y : Int16
	extents_width : UInt16
	extents_height : UInt16
	server_time : Timestamp
	shaped : UInt8
	pad0 : StaticArray(UInt8, 11)
end

XCB_SHAPE_QUERY_VERISON = 0

struct ShapeQueryVersionRequest
	major_opcode : UInt8
	minor_opcode : UInt8
	length : UInt16
end

struct ShapeQueryVersionReply
	response_type : UInt8
	pad0 : UInt8
	sequence : UInt16
	length : UInt32
	major_version : UInt16
	minor_version : UInt16
end

XCB_SHAPE_RECTANGLES = 1

struct ShapeRectanglesRequest
	major_opcode  :    UInt8
	minor_opcode  :    UInt8
	length  :          UInt16
	operation  :       ShapeKind
	destination_kind : ShapeKind
	ordering  :        UInt8
	pad0  :            UInt8
	destination_window : Window
	x_offset  :        Int16
	y_offset  :        Int16
end

XCB_SHAPE_MASK = 2

struct ShapeMaskRequest 
	major_opcode :      UInt8
	minor_opcode :      UInt8
	length :            UInt16
	operation :         ShapeOp
	destination_kind :  ShapeKind
	pad0 :              StaticArray(UInt8, 2)
	destination_window : Window
	x_offset :          Int16
	y_offset :          Int16
	source_bitmap :     Pixmap
end

XCB_SHAPE_COMBINE = 3

struct ShapeCombineRequest 
	major_opcode :      UInt8
	minor_opcode :      UInt8
	length :            UInt16
	operation :         ShapeOp
	destination_kind :  ShapeKind
	source_kind :       ShapeKind
	pad0 :              UInt8
	destination_window : Window
	x_offset :          Int16
	y_offset :          Int16
	source_window :     Window
end


XCB_SHAPE_OFFSET = 4

struct ShapeOffsetRequest 
	major_opcode :      UInt8
	minor_opcode :      UInt8
	length :            UInt16
	destination_kind :  ShapeKind
	pad0 :              [UInt8 3]
	destination_window : Window
	x_offset :          Int16
	y_offset :          Int16
end


XCB_SHAPE_QUERY_EXTENTS = 5

struct ShapeQueryExtentsRequest 
	major_opcode :      UInt8
	minor_opcode :      UInt8
	length :            UInt16
	destination_window : Window
end

struct ShapeQueryExtentsCookie 
	sequence : UInt32
end

struct ShapeQueryExtentsReply 
	response_type :                UInt8
	pad0 :                         UInt8
	sequence :                     UInt16
	length :                       UInt32
	bounding_shaped :              UInt8
	clip_shaped :                  UInt8
	pad1 :                         StaticArray(UInt8, 2)
	bounding_shape_extents_x :     Int16
	bounding_shape_extents_y :     Int16
	bounding_shape_extents_width : UInt16
	bounding_shape_extents_height : UInt16
	clip_shape_extents_x :         Int16
	clip_shape_extents_y :         Int16
	clip_shape_extents_width :     UInt16
	clip_shape_extents_height :    UInt16


	XCB_SHAPE_SELECT_INPUT = 6

	struct ShapeSelectInputRequest
		major_opcode :      UInt8
		minor_opcode :      UInt8
		length :            UInt16
		destination_window : Window
		enable :            UInt8
		pad0 :              StaticArray(UInt8, 3)
	end

	XCB_SHAPE_INPUT_SELECTED = 7

	struct ShapeInputSelectedRequest 
		major_opcode :      UInt8
		minor_opcode :      UInt8
		length :            UInt16
		destination_window : Window
	end

	struct ShapeInputSelectedCookie 
		sequence : UInt32
	end

	struct ShapeInputSelectedReply 
		response_type : UInt8,
		enabled :      UInt8,
		sequence :     UInt16,
		length :       UInt32,
	end

	XCB_SHAPE_GET_RECTANGLES = 8

	struct ShapeGetRectanglesRequest 
		major_opcode : UInt8
		minor_opcode : UInt8
		length :      UInt16
		window :      Window
		source_kind : ShapeKind
		pad0 :        StaticArray(UInt8, 3)
	end

	struct ShapeGetRectanglesCookie
		sequence : UInt32
	end

	struct ShapeGetRectanglesReply
		response_type : UInt8
		ordering :      UInt8
		sequence :      UInt16
		length :        UInt32
		rectangles_len : UInt32
		pad0 :          StaticArray(UInt8, 20)
	end

	fun xcb_shape_op_next (x0 : Pointer(ShapeOpIterator))

	fun xcb_shape_op_end (x0 : Pointer(ShapeOpIterator)) :  GenericIterator

	fun xcb_shape_kind_next (x0 : Pointer(ShapeKindIterator))

	fun xcb_shape_kind_end (x0 : Pointer(ShapeKindIterator)) :  GenericIterator

	fun xcb_shape_query_version_reply (x0 : Pointer(Connection), x1 : ShapeQueryVersionCookie, x2 : Pointer(Pointer(xcb_generic_error_t)) : Pointer(xcb_shape_query_version_reply_t)

																		fun xcb_shape_query_version(x0 : Pointer(Connection))) :  ShapeQueryVersionCookie

	fun xcb_shape_query_version_unchecked (c: Pointer(Connection)) : ShapeQueryVersionCookie

	fun xcb_shape_rectangles (x0 : Pointer(Connection), x1 : ShapeOp, x2 : ShapeKind, x3 : UInt8, x4 : Window, x5 : Int16, x6 : Int16, x7 : UInt32, x8 : Pointer(Rectangle)) :  VoidCookie

	fun xcb_shape_rectangles_checked (x0 :                 Pointer(Connection), x1 :         ShapeOp, x2 :  ShapeKind, x3 :          UInt8, x4 : Window, x5 :          Int16, x6 :          Int16, rectangles_len :    UInt32, rectangles :        * Rectangle) :  VoidCookie

	fun xcb_shape_mask(x0 : Pointer(Connection), x1 :         ShapeOp, x2 :  ShapeKind, x3 : Window, x4 :          Int16, x5 :          Int16, x6 :     xcb_pixmap_t) :  VoidCookie

	fun xcb_shape_mask_checked (x0 : Pointer(Connection), x1 : ShapeOp, x2 :  ShapeKind,
														 x3 : Window, x4 : Int16, x5 : Int16, x6 : xcb_pixmap_t) : VoidCookie

	fun xcb_shape_combine (x0 : Pointer(Connection), x1 : ShapeOp, x2 :  ShapeKind, x3 : ShapeKind, x4 : Window, x5 : Int16, x6 : Int16, x7 : Window) :  VoidCookie

	fun xcb_shape_combine_checked (x0 : Pointer(Connection), x1 : ShapeOp, x2 :  ShapeKind, x3 : ShapeKind, x4 : Window, x5 : Int16, x6 : Int16, : Window) :  VoidCookie

	fun xcb_shape_offset (x0 : Pointer(Connection), x1 : ShapeKind, x2 : Window, x3 : Int16, x4 : Int16) :  VoidCookie

	fun xcb_shape_offset_checked (x0 : Pointer(Connection), x1 :  ShapeKind, x2 : Window,  x3 : Int16, x4 : Int16) : VoidCookie

	fun xcb_shape_query_extents_reply (x0 : Pointer(Connection), x1 : ShapeQueryExtentsCookie, x2 : Pointer(Pointer(GenericError))) :  Pointer(ShapeQueryExtensReply)

	fun xcb_shape_query_extents (x0 : Pointer(Connection), x1 : Window) :  ShapeQueryExtentsCookie

	fun xcb_shape_query_extents_unchecked (x0 : Pointer(Connection), x1 : Window) :  ShapeQueryExtentsCookie

	fun xcb_shape_select_input (x0 : Pointer(Connection), x1 : Window, x2 : UInt8) :  VoidCookie

	fun xcb_shape_select_input_checked (x0 : Pointer(Connection), x1 : Window, x2 : UInt8) : VoidCookie

	fun xcb_shape_input_selected_reply (x0 : Pointer(Connection), x1 : ShapeInputSelectedCookie, x2 : Pointer(Pointer(GenericError))) :  Pointer(ShapeInputSelectedReply)

	fun xcb_shape_input_selected (x0 : Pointer(Connection), x1 : Window) : ShapeInputSelectedCookie

	fun xcb_shape_input_selected_unchecked (x0 : Pointer(Connection), x1 : Window) :  ShapeInputSelectedCookie

	fun xcb_shape_get_rectangles_rectangles (x0 :  Pointer(ShapeGetRectanglesReply)) :  Pointer(Rectangle)

	fun xcb_shape_get_rectangles_rectangles_length (x0 : Pointer(ShapeGetRectanglesReply)) :  Int32

	fun xcb_shape_get_rectangles_rectangles_iterator (x0 : Pointer(ShapeGetRectanglesReply)) :  RectangleIterator

	fun xcb_shape_get_rectangles_reply (x0 : Pointer(Connection), x1 : GetRectanglesCookie, x2 : Pointer(Pointer(GenericError))) :  Pointer(ShapeGetRectanglesReply)

	fun xcb_shape_get_rectangles (x0 : Pointer(Connection), x1 : Window, x2 : ShapeKind) :  GetRectanglesCookie

	fun xcb_shape_get_rectangles_unchecked (x0 : Pointer(Connection), x1 :     Window, x2 : ShapeKind) :  GetRectanglesCookie
