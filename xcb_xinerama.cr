@[Link("xcb")
	lib LibXCB
		struct XineramaGetScreenCountCookie
			sequence : UInt32
		end

		struct XineramaGetScreenCountReply
			response_type : UInt8
			screen_count : UInt8
			sequence : UInt16
			length : UInt32
			window : Window
		end

		struct XineramaGetScreenCountRequest
			major_opcode : UInt8
			minor_opcode : UInt8
			length : UInt16
			window : Window
		end

		struct XineramaGetScreenSizeCookie
			sequence : UInt32
		end

		struct XineramaGetScreenSizeReply
			response_type : UInt8
			pad0 : UInt8
			sequence : UInt16
			length : UInt32
			width : UInt32
			height : UInt32
			window : Window
			screen : UInt32
		end

		struct XineramaGetScreenSizeRequest
			major_opcode : UInt8
			minor_opcode : UInt8
			length : UInt16
			window : Window
			screen : UInt32
		end

		struct XineramaGetStateCookie
			sequence : UInt32
		end

		struct XineramaGetStateReply
			response_type : UInt8
			state : UInt8
			sequence : UInt16
			length : UInt32
			window : Window
		end

		struct XineramaGetStateRequest
			major_opcode : UInt8
			minor_opcode : UInt8
			length : UInt16
			window : Window
		end

		struct XineramaIsActiveCookie
			sequence : UInt32
		end

		struct XineramaIsActiveReply
			response_type : UInt8
			pad0 : UInt8
			sequence : UInt16
			length : UInt32
			state : UInt32
		end

		struct XineramaIsActiveRequest
			major_opcode : UInt8
			minor_opcode : UInt8
			length : UInt16
		end

		struct XineramaQueryScreensCookie
			sequence : UInt32
		end

		struct XineramaQueryScreensReply
			response_type : UInt8
			pad0 : UInt8
			sequence : UInt16
			length : UInt32
			number : UInt32
			pad1 : StaticArray(UInt8, 20)
		end

		struct XineramaQueryScreensRequest
			major_opcode : UInt8
			minor_opcode : UInt8
			length : UInt16
		end

		struct XineramaQueryVersionCookie
			sequence : UInt32
		end

		struct XineramaQueryVersionReply
			response_type : UInt8
			pad0 : UInt8
			sequence : UInt16
			length : UInt32
			major : UInt16
			minor : UInt16
		end

		struct XineramaQueryVersionRequest
			major_opcode : UInt8
			minor_opcode : UInt8
			length : UInt16
			major : UInt8
			minor : UInt8
		end

		struct XineramaScreenInfoIterator
			data : XineramaGetScreenInfo*
			rem : Int32
			index : Int32
		end

		struct XineramaGetScreenInfo
			x_org : UInt16
			y_org : UInt16
			width : UInt16
			height : UInt16
		end

		fun xcb_xinerama_get_screen_count(Pointer(Connection), window : Window) : XineramaGetScreenCountCookie
		fun xcb_xinerama_get_screen_count_reply(Pointer(Connection), cookie : XineramaGetScreenCountCookie, e : GenericError**) : XineramaGetScreenCountReply*
			fun xcb_xinerama_get_screen_count_unchecked(Pointer(Connection), window : Window) : XineramaGetScreenCountCookie
		fun xcb_xinerama_get_screen_size(Pointer(Connection), window : Window, screen : UInt32) : XineramaGetScreenSizeCookie
		fun xcb_xinerama_get_screen_size_reply(Pointer(Connection), cookie : XineramaGetScreenSizeCookie, e : GenericError**) : XineramaGetScreenSizeReply*
			fun xcb_xinerama_get_screen_size_unchecked(Pointer(Connection), window : Window, screen : UInt32) : XineramaGetScreenSizeCookie
		fun xcb_xinerama_get_state(Pointer(Connection), window : Window) : XineramaGetStateCookie
		fun xcb_xinerama_get_state_reply(Pointer(Connection), cookie : XineramaGetStateCookie, e : GenericError**) : XineramaGetStateReply*
			fun xcb_xinerama_get_state_unchecked(Pointer(Connection), window : Window) : XineramaGetStateCookie
		fun xcb_xinerama_is_active(Pointer(Connection)) : XineramaIsActiveCookie
		fun xcb_xinerama_is_active_reply(Pointer(Connection), cookie : XineramaIsActiveCookie, e : GenericError**) : XineramaIsActiveReply*
			fun xcb_xinerama_is_active_unchecked(Pointer(Connection)) : XineramaIsActiveCookie
		fun xcb_xinerama_query_screens(Pointer(Connection)) : XineramaQueryScreensCookie
		fun xcb_xinerama_query_screens_reply(Pointer(Connection), cookie : XineramaQueryScreensCookie, e : GenericError**) : XineramaQueryScreensReply*
			fun xcb_xinerama_query_screens_screen_info(r : XineramaQueryScreensReply*) : XineramaGetScreenInfo*
			fun xcb_xinerama_query_screens_screen_info_iterator(r : XineramaQueryScreensReply*) : XineramaScreenInfoIterator
		fun xcb_xinerama_query_screens_screen_info_length(r : XineramaQueryScreensReply*) : Int32
		fun xcb_xinerama_query_screens_sizeof(_buffer : Void*) : Int32
		fun xcb_xinerama_query_screens_unchecked(Pointer(Connection)) : XineramaQueryScreensCookie
		fun xcb_xinerama_query_version(Pointer(Connection), major : UInt8, minor : UInt8) : XineramaQueryVersionCookie
		fun xcb_xinerama_query_version_reply(Pointer(Connection), cookie : XineramaQueryVersionCookie, e : GenericError**) : XineramaQueryVersionReply*
			fun xcb_xinerama_query_version_unchecked(Pointer(Connection), major : UInt8, minor : UInt8) : XineramaQueryVersionCookie
		fun xcb_xinerama_screen_info_end(i : XineramaScreenInfoIterator) : GenericIterator
		fun xcb_xinerama_screen_info_next(i : XineramaScreenInfoIterator*)
	end
