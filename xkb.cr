@[Link("xkbcommon")
	lib XkbCommon
		alias VaList = GnucVaList
		alias IoCodecvt = Void
		alias IoLock = Void
		alias IoMarker = Void
		alias IoWideData = Void
		alias GnucVaList = LibC::VaList
		alias XkbComposeState = Void
		alias XkbComposeTable = Void
		alias XkbContext = Void
		alias XkbKeycode = UInt32
		alias XkbKeymap = Void
		alias XkbKeymapKeyIter = (XkbKeymap*, XkbKeycode, Void* -> Void)
		alias XkbKeysym = UInt32
		alias XkbLayoutIndex = UInt32
		alias XkbLedIndex = UInt32
		alias XkbLevelIndex = UInt32
		alias XkbModIndex = UInt32
		alias XkbModMask = UInt32
		alias XkbState = Void

		enum XkbComposeCompileFlags
			XkbComposeCompileNoFlags = 0
		end

		enum XkbComposeFeedResult
			XkbComposeFeedIgnored  = 0
			XkbComposeFeedAccepted = 1
		end

		enum XkbComposeFormat
			XkbComposeFormatTextV1 = 1
		end

		enum XkbComposeStateFlags
			XkbComposeStateNoFlags = 0
		end

		enum XkbComposeStatus
			XkbComposeNothing   = 0
			XkbComposeComposing = 1
			XkbComposeComposed  = 2
			XkbComposeCancelled = 3
		end

		enum XkbConsumedMode
			XkbConsumedModeXkb = 0
			XkbConsumedModeGtk = 1
		end

		enum XkbContextFlags
			XkbContextNoFlags            = 0
			XkbContextNoDefaultIncludes  = 1
			XkbContextNoEnvironmentNames = 2
		end

		enum XkbKeyDirection
			XkbKeyUp   = 0
			XkbKeyDown = 1
		end

		enum XkbKeymapCompileFlags
			XkbKeymapCompileNoFlags = 0
		end

		enum XkbKeymapFormat
			XkbKeymapFormatTextV1 = 1
		end

		enum XkbKeysymFlags
			XkbKeysymNoFlags         = 0
			XkbKeysymCaseInsensitive = 1
		end

		enum XkbLogLevel
			XkbLogLevelCritical = 10
			XkbLogLevelError    = 20
			XkbLogLevelWarning  = 30
			XkbLogLevelInfo     = 40
			XkbLogLevelDebug    = 50
		end

		enum XkbStateComponent
			XkbStateModsDepressed   =   1
			XkbStateModsLatched     =   2
			XkbStateModsLocked      =   4
			XkbStateModsEffective   =   8
			XkbStateLayoutDepressed =  16
			XkbStateLayoutLatched   =  32
			XkbStateLayoutLocked    =  64
			XkbStateLayoutEffective = 128
			XkbStateLeds            = 256
		end

		enum XkbStateMatch
			XkbStateMatchAny          =     1
			XkbStateMatchAll          =     2
			XkbStateMatchNonExclusive = 65536
		end

		enum XkbX11SetupXkbExtensionFlags
			XkbX11SetupXkbExtensionNoFlags = 0
		end

		fun xkb_compose_state_feed(state : XkbComposeState*, keysym : XkbKeysym) : XkbComposeFeedResult
		fun xkb_compose_state_get_compose_table(state : XkbComposeState*) : XkbComposeTable*
			fun xkb_compose_state_get_one_sym(state : XkbComposeState*) : XkbKeysym
		fun xkb_compose_state_get_status(state : XkbComposeState*) : XkbComposeStatus
		fun xkb_compose_state_get_utf8(state : XkbComposeState*, buffer : Char*, size : LibC::Size) : Int32
		fun xkb_compose_state_new(table : XkbComposeTable*, flags : XkbComposeStateFlags) : XkbComposeState*
			fun xkb_compose_state_ref(state : XkbComposeState*) : XkbComposeState*
			fun xkb_compose_state_reset(state : XkbComposeState*)
		fun xkb_compose_state_unref(state : XkbComposeState*)
		fun xkb_compose_table_new_from_buffer(context : XkbContext*, buffer : Char*, length : LibC::Size, locale : Char*, format : XkbComposeFormat, flags : XkbComposeCompileFlags) : XkbComposeTable*
			fun xkb_compose_table_new_from_file(context : XkbContext*, file : File*, locale : Char*, format : XkbComposeFormat, flags : XkbComposeCompileFlags) : XkbComposeTable*
			fun xkb_compose_table_new_from_locale(context : XkbContext*, locale : Char*, flags : XkbComposeCompileFlags) : XkbComposeTable*
			fun xkb_compose_table_ref(table : XkbComposeTable*) : XkbComposeTable*
			fun xkb_compose_table_unref(table : XkbComposeTable*)
		fun xkb_context_get_log_level(context : XkbContext*) : XkbLogLevel
		fun xkb_context_get_log_verbosity(context : XkbContext*) : Int32
		fun xkb_context_get_user_data(context : XkbContext*) : Void*
			fun xkb_context_include_path_append(context : XkbContext*, path : Char*) : Int32
		fun xkb_context_include_path_append_default(context : XkbContext*) : Int32
		fun xkb_context_include_path_clear(context : XkbContext*)
		fun xkb_context_include_path_get(context : XkbContext*, index : UInt32) : Char*
			fun xkb_context_include_path_reset_defaults(context : XkbContext*) : Int32
		fun xkb_context_new(flags : XkbContextFlags) : XkbContext*
			fun xkb_context_num_include_paths(context : XkbContext*) : UInt32
		fun xkb_context_ref(context : XkbContext*) : XkbContext*
			fun xkb_context_set_log_fn(context : XkbContext*, log_fn : (XkbContext*, XkbLogLevel, Char*, VaList -> Void))
		fun xkb_context_set_log_level(context : XkbContext*, level : XkbLogLevel)
		fun xkb_context_set_log_verbosity(context : XkbContext*, verbosity : Int32)
		fun xkb_context_set_user_data(context : XkbContext*, user_data : Void*)
		fun xkb_context_unref(context : XkbContext*)
		fun xkb_keymap_get_as_string(keymap : XkbKeymap*, format : XkbKeymapFormat) : Char*
			fun xkb_keymap_key_by_name(keymap : XkbKeymap*, name : Char*) : XkbKeycode
		fun xkb_keymap_key_for_each(keymap : XkbKeymap*, iter : XkbKeymapKeyIter, data : Void*)
		fun xkb_keymap_key_get_mods_for_level(keymap : XkbKeymap*, key : XkbKeycode, layout : XkbLayoutIndex, level : XkbLevelIndex, masks_out : XkbModMask*, masks_size : LibC::Size) : LibC::Size
		fun xkb_keymap_key_get_name(keymap : XkbKeymap*, key : XkbKeycode) : Char*
			fun xkb_keymap_key_get_syms_by_level(keymap : XkbKeymap*, key : XkbKeycode, layout : XkbLayoutIndex, level : XkbLevelIndex, syms_out : XkbKeysym**) : Int32
		fun xkb_keymap_key_repeats(keymap : XkbKeymap*, key : XkbKeycode) : Int32
		fun xkb_keymap_layout_get_index(keymap : XkbKeymap*, name : Char*) : XkbLayoutIndex
		fun xkb_keymap_layout_get_name(keymap : XkbKeymap*, idx : XkbLayoutIndex) : Char*
			fun xkb_keymap_led_get_index(keymap : XkbKeymap*, name : Char*) : XkbLedIndex
		fun xkb_keymap_led_get_name(keymap : XkbKeymap*, idx : XkbLedIndex) : Char*
			fun xkb_keymap_max_keycode(keymap : XkbKeymap*) : XkbKeycode
		fun xkb_keymap_min_keycode(keymap : XkbKeymap*) : XkbKeycode
		fun xkb_keymap_mod_get_index(keymap : XkbKeymap*, name : Char*) : XkbModIndex
		fun xkb_keymap_mod_get_name(keymap : XkbKeymap*, idx : XkbModIndex) : Char*
			fun xkb_keymap_new_from_buffer(context : XkbContext*, buffer : Char*, length : LibC::Size, format : XkbKeymapFormat, flags : XkbKeymapCompileFlags) : XkbKeymap*
			fun xkb_keymap_new_from_file(context : XkbContext*, file : File*, format : XkbKeymapFormat, flags : XkbKeymapCompileFlags) : XkbKeymap*
			fun xkb_keymap_new_from_names(context : XkbContext*, names : XkbRuleNames*, flags : XkbKeymapCompileFlags) : XkbKeymap*
			fun xkb_keymap_new_from_string(context : XkbContext*, string : Char*, format : XkbKeymapFormat, flags : XkbKeymapCompileFlags) : XkbKeymap*
			fun xkb_keymap_num_layouts(keymap : XkbKeymap*) : XkbLayoutIndex
		fun xkb_keymap_num_layouts_for_key(keymap : XkbKeymap*, key : XkbKeycode) : XkbLayoutIndex
		fun xkb_keymap_num_leds(keymap : XkbKeymap*) : XkbLedIndex
		fun xkb_keymap_num_levels_for_key(keymap : XkbKeymap*, key : XkbKeycode, layout : XkbLayoutIndex) : XkbLevelIndex
		fun xkb_keymap_num_mods(keymap : XkbKeymap*) : XkbModIndex
		fun xkb_keymap_ref(keymap : XkbKeymap*) : XkbKeymap*
			fun xkb_keymap_unref(keymap : XkbKeymap*)
		fun xkb_keysym_from_name(name : Char*, flags : XkbKeysymFlags) : XkbKeysym
		fun xkb_keysym_get_name(keysym : XkbKeysym, buffer : Char*, size : LibC::Size) : Int32
		fun xkb_keysym_to_lower(ks : XkbKeysym) : XkbKeysym
		fun xkb_keysym_to_upper(ks : XkbKeysym) : XkbKeysym
		fun xkb_keysym_to_utf32(keysym : XkbKeysym) : UInt32
		fun xkb_keysym_to_utf8(keysym : XkbKeysym, buffer : Char*, size : LibC::Size) : Int32
		fun xkb_state_get_keymap(state : XkbState*) : XkbKeymap*
			fun xkb_state_key_get_consumed_mods(state : XkbState*, key : XkbKeycode) : XkbModMask
		fun xkb_state_key_get_consumed_mods2(state : XkbState*, key : XkbKeycode, mode : XkbConsumedMode) : XkbModMask
		fun xkb_state_key_get_layout(state : XkbState*, key : XkbKeycode) : XkbLayoutIndex
		fun xkb_state_key_get_level(state : XkbState*, key : XkbKeycode, layout : XkbLayoutIndex) : XkbLevelIndex
		fun xkb_state_key_get_one_sym(state : XkbState*, key : XkbKeycode) : XkbKeysym
		fun xkb_state_key_get_syms(state : XkbState*, key : XkbKeycode, syms_out : XkbKeysym**) : Int32
		fun xkb_state_key_get_utf32(state : XkbState*, key : XkbKeycode) : UInt32
		fun xkb_state_key_get_utf8(state : XkbState*, key : XkbKeycode, buffer : Char*, size : LibC::Size) : Int32
		fun xkb_state_layout_index_is_active(state : XkbState*, idx : XkbLayoutIndex, type : XkbStateComponent) : Int32
		fun xkb_state_layout_name_is_active(state : XkbState*, name : Char*, type : XkbStateComponent) : Int32
		fun xkb_state_led_index_is_active(state : XkbState*, idx : XkbLedIndex) : Int32
		fun xkb_state_led_name_is_active(state : XkbState*, name : Char*) : Int32
		fun xkb_state_mod_index_is_active(state : XkbState*, idx : XkbModIndex, type : XkbStateComponent) : Int32
		fun xkb_state_mod_index_is_consumed(state : XkbState*, key : XkbKeycode, idx : XkbModIndex) : Int32
		fun xkb_state_mod_index_is_consumed2(state : XkbState*, key : XkbKeycode, idx : XkbModIndex, mode : XkbConsumedMode) : Int32
		fun xkb_state_mod_indices_are_active(state : XkbState*, type : XkbStateComponent, match : XkbStateMatch, ...) : Int32
		fun xkb_state_mod_mask_remove_consumed(state : XkbState*, key : XkbKeycode, mask : XkbModMask) : XkbModMask
		fun xkb_state_mod_name_is_active(state : XkbState*, name : Char*, type : XkbStateComponent) : Int32
		fun xkb_state_mod_names_are_active(state : XkbState*, type : XkbStateComponent, match : XkbStateMatch, ...) : Int32
		fun xkb_state_new(keymap : XkbKeymap*) : XkbState*
			fun xkb_state_ref(state : XkbState*) : XkbState*
			fun xkb_state_serialize_layout(state : XkbState*, components : XkbStateComponent) : XkbLayoutIndex
		fun xkb_state_serialize_mods(state : XkbState*, components : XkbStateComponent) : XkbModMask
		fun xkb_state_unref(state : XkbState*)
		fun xkb_state_update_key(state : XkbState*, key : XkbKeycode, direction : XkbKeyDirection) : XkbStateComponent
		fun xkb_state_update_mask(state : XkbState*, depressed_mods : XkbModMask, latched_mods : XkbModMask, locked_mods : XkbModMask, depressed_layout : XkbLayoutIndex, latched_layout : XkbLayoutIndex, locked_layout : XkbLayoutIndex) : XkbStateComponent
		fun xkb_utf32_to_keysym(ucs : UInt32) : XkbKeysym
		fun xkb_x11_get_core_keyboard_device_id(connection : Connection) : Int32
		fun xkb_x11_keymap_new_from_device(context : XkbContext*, connection : Connection, device_id : Int32, flags : XkbKeymapCompileFlags) : XkbKeymap*
			fun xkb_x11_setup_xkb_extension(connection : Connection, major_xkb_version : UInt16, minor_xkb_version : UInt16, flags : XkbX11SetupXkbExtensionFlags, major_xkb_version_out : UInt16*, minor_xkb_version_out : UInt16*, base_event_out : UInt8*, base_error_out : UInt8*) : Int32
		fun xkb_x11_state_new_from_device(keymap : XkbKeymap*, connection : Connection, device_id : Int32) : XkbState*

			struct IoFile
				_flags : Int32
				_io_read_ptr : Char*
				_io_read_end : Char*
				_io_read_base : Char*
				_io_write_base : Char*
				_io_write_ptr : Char*
				_io_write_end : Char*
				_io_buf_base : Char*
				_io_buf_end : Char*
				_io_save_base : Char*
				_io_backup_base : Char*
				_io_save_end : Char*
				_markers : IoMarker*
				_chain : IoFile*
				_fileno : Int32
				_flags2 : Int32
				_old_offset : Off
				_cur_column : UShort
				_vtable_offset : Char
				_shortbuf : StaticArray(Char, 1)
				_lock : IoLock*
				_offset : Off64
				_codecvt : IoCodecvt*
				_wide_data : IoWideData*
				_freeres_list : IoFile*
				_freeres_buf : Void*
				__pad5 : LibC::Size
				_mode : Int32
				_unused2 : StaticArray(Char, 20)
		end

		struct XkbRuleNames
			rules : Char*
			model : Char*
			layout : Char*
			variant : Char*
			options : Char*
		end

		type File = IoFile
		type Connection = Void*
	end
