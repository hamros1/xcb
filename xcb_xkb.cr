@[Link("xcb")]
lib LibXCB
	alias XkbBellClassSpec = Uint16
	alias XkbDeviceSpec = Uint16
	alias XkbIdSpec = Uint16
	alias XkbLedClassSpec = Uint16

	struct XkbAccessXNotifyEvent
		response_type : UInt32
		xkb_type : UInt32
		sequence : Uint16
		time : Timestamp
		device_id : UInt32
		keycode : Keycode
		detailt : Uint16
		slow_keys_delay : Uint16
		debounce_delay : Uint16
		pad0 : UInt8[16]
	end

	struct XkbActionIterator
		data : XkbAction*
		rem : Int32
		index : Int32
	end

	struct XkbActionMessageEvent
		response_type : UInt32
		xkb_type : UInt32
		sequence : Uint16
		time : Timestamp
		device_id : UInt32
		keycode : Keycode
		press : UInt32
		key_event_follows : UInt32
		mods : UInt32
		group : UInt32
		message : CharT[8]
		pad0 : UInt8[10]
	end

	struct XkbBehaviorIterator
		data : XkbBehavior*
		rem : Int32
		index : Int32
	end

	struct XkbBellClassSpecIterator
		data : XkbBellClassSpec*
		rem : Int32
		index : Int32
	end

	struct XkbBellNotifyEvent
		response_type : UInt32
		xkb_type : UInt32
		sequence : Uint16
		time : Timestamp
		device_id : UInt32
		bell_class : UInt32
		bell_id : UInt32
		percent : UInt32
		pitch : Uint16
		duration : Uint16
		name : Atom
		window : Window
		event_only : UInt32
		pad0 : UInt8[7]
	end

	struct XkbBellRequest
		major_opcode : UInt32
		minor_opcode : UInt32
		length : Uint16
		device_spec : XkbDeviceSpec
		bell_class : XkbBellClassSpec
		bell_id : XkbIdSpec
		percent : Int8
		force_sound : UInt32
		event_only : UInt32
		pad0 : UInt32
		pitch : Int16
		duration : Int16
		pad1 : UInt8[2]
		name : Atom
		window : Window
	end

	struct XkbCommonBehaviorIterator
		data : XkbCommonBehavior*
		rem : Int32
		index : Int32
	end

	struct XkbCommonBehavior
		type : UInt32
		data : UInt32
	end

	struct XkbCompatMapNotifyEvent
		response_type : UInt32
		xkb_type : UInt32
		sequence : Uint16
		time : Timestamp
		device_id : UInt32
		changed_groups : UInt32
		first_si : Uint16
		n_si : Uint16
		n_total_si : Uint16
		pad0 : UInt8[16]
	end

	struct XkbControlsNotifyEvent
		response_type : UInt32
		xkb_type : UInt32
		sequence : Uint16
		time : Timestamp
		device_id : UInt32
		num_groups : UInt32
		pad0 : UInt8[2]
		changed_controls : Uint32
		enabled_controls : Uint32
		enabled_control_changes : Uint32
		keycode : Keycode
		event_type : UInt32
		request_major : UInt32
		request_minor : UInt32
		pad1 : UInt8[4]
	end

	struct XkbCountedString16Iterator
		data : XkbCountedString16*
		rem : Int32
		index : Int32
	end

	struct XkbCountedString16
		length : Uint16
	end

	struct XkbDefaultBehaviorIterator
		data : XkbDefaultBehavior*
		rem : Int32
		index : Int32
	end

	struct XkbDefaultBehavior
		type : UInt32
		pad0 : UInt32
	end

	struct XkbDeviceLedInfoIterator
		data : XkbDeviceLedInfo*
		rem : Int32
		index : Int32
	end

	struct XkbDeviceLedInfo
		led_class : XkbLedClassSpec
		led_id : XkbIdSpec
		names_present : Uint32
		maps_present : Uint32
		phys_indicators : Uint32
		state : Uint32
	end

	struct XkbDeviceSpecIterator
		data : XkbDeviceSpec*
		rem : Int32
		index : Int32
	end

	struct XkbExtensionDeviceNotifyEvent
		response_type : UInt32
		xkb_type : UInt32
		sequence : Uint16
		time : Timestamp
		device_id : UInt32
		pad0 : UInt32
		reason : Uint16
		led_class : Uint16
		led_id : Uint16
		leds_defined : Uint32
		led_state : Uint32
		first_button : UInt32
		n_buttons : UInt32
		supported : Uint16
		unsupported : Uint16
		pad1 : UInt8[2]
	end

	struct XkbGetCompatMapCookie
		sequence : UInt32
	end

	struct XkbGetCompatMapReply
		response_type : UInt32
		device_id : UInt32
		sequence : Uint16
		length : Uint32
		groups_rtrn : UInt32
		pad0 : UInt32
		first_si_rtrn : Uint16
		n_si_rtrn : Uint16
		n_total_si : Uint16
		pad1 : UInt8[16]
	end

	struct XkbGetCompatMapRequest
		major_opcode : UInt32
		minor_opcode : UInt32
		length : Uint16
		device_spec : XkbDeviceSpec
		groups : UInt32
		get_all_si : UInt32
		first_si : Uint16
		n_si : Uint16
	end

	struct XkbGetControlsCookie
		sequence : UInt32
	end

	struct XkbGetControlsReply
		response_type : UInt32
		device_id : UInt32
		sequence : Uint16
		length : Uint32
		mouse_keys_dflt_btn : UInt32
		num_groups : UInt32
		groups_wrap : UInt32
		internal_mods_mask : UInt32
		ignore_lock_mods_mask : UInt32
		internal_mods_real_mods : UInt32
		ignore_lock_mods_real_mods : UInt32
		pad0 : UInt32
		internal_mods_vmods : Uint16
		ignore_lock_mods_vmods : Uint16
		repeat_delay : Uint16
		repeat_interval : Uint16
		slow_keys_delay : Uint16
		debounce_delay : Uint16
		mouse_keys_delay : Uint16
		mouse_keys_interval : Uint16
		mouse_keys_time_to_max : Uint16
		mouse_keys_max_speed : Uint16
		mouse_keys_curve : Int16
		access_x_option : Uint16
		access_x_timeout : Uint16
		access_x_timeout_options_mask : Uint16
		access_x_timeout_options_values : Uint16
		pad1 : UInt8[2]
		access_x_timeout_mask : Uint32
		access_x_timeout_values : Uint32
		enabled_controls : Uint32
		per_key_repeat : UInt8[32]
	end

	struct XkbGetControlsRequest
		major_opcode : UInt32
		minor_opcode : UInt32
		length : Uint16
		device_spec : XkbDeviceSpec
		pad0 : UInt8[2]
	end

	struct XkbGetDeviceInfoCookie
		sequence : UInt32
	end

	struct XkbGetDeviceInfoReply
		response_type : UInt32
		device_id : UInt32
		sequence : Uint16
		length : Uint32
		present : Uint16
		supported : Uint16
		unsupported : Uint16
		n_device_led_f_bs : Uint16
		first_btn_wanted : UInt32
		n_btns_wanted : UInt32
		first_btn_rtrn : UInt32
		n_btns_rtrn : UInt32
		total_btns : UInt32
		has_own_state : UInt32
		dflt_kbd_fb : Uint16
		dflt_led_fb : Uint16
		pad0 : UInt8[2]
		dev_type : Atom
		name_len : Uint16
	end

	struct XkbGetDeviceInfoRequest
		major_opcode : UInt32
		minor_opcode : UInt32
		length : Uint16
		device_spec : XkbDeviceSpec
		wanted : Uint16
		all_buttons : UInt32
		first_button : UInt32
		n_buttons : UInt32
		pad0 : UInt32
		led_class : XkbLedClassSpec
		led_id : XkbIdSpec
	end

	struct XkbGetIndicatorMapCookie
		sequence : UInt32
	end

	struct XkbGetIndicatorMapReply
		response_type : UInt32
		device_id : UInt32
		sequence : Uint16
		length : Uint32
		which : Uint32
		real_indicators : Uint32
		n_indicators : UInt32
		pad0 : UInt8[15]
	end

	struct XkbGetIndicatorMapRequest
		major_opcode : UInt32
		minor_opcode : UInt32
		length : Uint16
		device_spec : XkbDeviceSpec
		pad0 : UInt8[2]
		which : Uint32
	end

	struct XkbGetIndicatorStateCookie
		sequence : UInt32
	end

	struct XkbGetIndicatorStateReply
		response_type : UInt32
		device_id : UInt32
		sequence : Uint16
		length : Uint32
		state : Uint32
		pad0 : UInt8[20]
	end

	struct XkbGetIndicatorStateRequest
		major_opcode : UInt32
		minor_opcode : UInt32
		length : Uint16
		device_spec : XkbDeviceSpec
		pad0 : UInt8[2]
	end

	struct XkbGetKbdByNameCookie
		sequence : UInt32
	end

	struct XkbGetKbdByNameRepliesKeyNamesValueList
		keycodes_name : Atom
		geometry_name : Atom
		symbols_name : Atom
		phys_symbols_name : Atom
		types_name : Atom
		compat_name : Atom
		type_names : Atom*
		n_levels_per_type : UInt8*
		kt_level_names : Atom*
		indicator_names : Atom*
		virtual_mod_names : Atom*
		groups : Atom*
		key_names : XkbKeyName*
		key_aliases : XkbKeyAlias*
		radio_group_names : Atom*
	end

	struct XkbGetKbdByNameReplies
		types : XkbGetKbdByNameRepliesTypes
		compat_map : XkbGetKbdByNameRepliesCompatMap
		indicator_maps : XkbGetKbdByNameRepliesIndicatorMaps
		key_names : XkbGetKbdByNameRepliesKeyNames
		geometry : XkbGetKbdByNameRepliesGeometry
	end

	struct XkbGetKbdByNameRepliesCompatMap
		compatmap_type : UInt32
		compat_device_id : UInt32
		compatmap_sequence : Uint16
		compatmap_length : Uint32
		groups_rtrn : UInt32
		pad7 : UInt32
		first_si_rtrn : Uint16
		n_si_rtrn : Uint16
		n_total_si : Uint16
		pad8 : UInt8[16]
		si_rtrn : XkbSymInterpret*
		group_rtrn : XkbModDef*
	end

	struct XkbGetKbdByNameRepliesGeometry
		geometry_type : UInt32
		geometry_device_id : UInt32
		geometry_sequence : Uint16
		geometry_length : Uint32
		name : Atom
		geometry_found : UInt32
		pad12 : UInt32
		width_mm : Uint16
		height_mm : Uint16
		n_properties : Uint16
		n_colors : Uint16
		n_shapes : Uint16
		n_sections : Uint16
		n_doodads : Uint16
		n_key_aliases : Uint16
		base_color_ndx : UInt32
		label_color_ndx : UInt32
		label_font : XkbCountedString16*
	end

	struct XkbGetKbdByNameRepliesIndicatorMaps
		indicatormap_type : UInt32
		indicator_device_id : UInt32
		indicatormap_sequence : Uint16
		indicatormap_length : Uint32
		which : Uint32
		real_indicators : Uint32
		n_indicators : UInt32
		pad9 : UInt8[15]
		maps : XkbIndicatorMap*
	end

	struct XkbGetKbdByNameRepliesKeyNames
		keyname_type : UInt32
		key_device_id : UInt32
		keyname_sequence : Uint16
		keyname_length : Uint32
		which : Uint32
		key_min_key_code : Keycode
		key_max_key_code : Keycode
		n_types : UInt32
		group_names : UInt32
		virtual_mods : Uint16
		first_key : Keycode
		n_keys : UInt32
		indicators : Uint32
		n_radio_groups : UInt32
		n_key_aliases : UInt32
		n_kt_levels : Uint16
		pad10 : UInt8[4]
		value_list : XkbGetKbdByNameRepliesKeyNamesValueList
	end

	struct XkbGetKbdByNameRepliesTypes
		getmap_type : UInt32
		type_device_id : UInt32
		getmap_sequence : Uint16
		getmap_length : Uint32
		pad1 : UInt8[2]
		type_min_key_code : Keycode
		type_max_key_code : Keycode
		present : Uint16
		first_type : UInt32
		n_types : UInt32
		total_types : UInt32
		first_key_sym : Keycode
		total_syms : Uint16
		n_key_syms : UInt32
		first_key_action : Keycode
		total_actions : Uint16
		n_key_actions : UInt32
		first_key_behavior : Keycode
		n_key_behaviors : UInt32
		total_key_behaviors : UInt32
		first_key_explicit : Keycode
		n_key_explicit : UInt32
		total_key_explicit : UInt32
		first_mod_map_key : Keycode
		n_mod_map_keys : UInt32
		total_mod_map_keys : UInt32
		first_v_mod_map_key : Keycode
		n_v_mod_map_keys : UInt32
		total_v_mod_map_keys : UInt32
		pad2 : UInt32
		virtual_mods : Uint16
		map : XkbGetKbdByNameRepliesTypesMap
	end

	struct XkbGetKbdByNameRepliesTypesMap
		types_rtrn : XkbKeyType*
		syms_rtrn : XkbKeySymMap*
		acts_rtrn_count : UInt8*
		acts_rtrn_acts : XkbAction*
		behaviors_rtrn : XkbSetBehavior*
		vmods_rtrn : UInt8*
		explicit_rtrn : XkbSetExplicit*
		modmap_rtrn : XkbKeyModMap*
		vmodmap_rtrn : XkbKeyVModMap*
	end

	struct XkbGetKbdByNameReply
		response_type : UInt32
		device_id : UInt32
		sequence : Uint16
		length : Uint32
		min_key_code : Keycode
		max_key_code : Keycode
		loaded : UInt32
		new_keyboard : UInt32
		found : Uint16
		reported : Uint16
		pad0 : UInt8[16]
	end

	struct XkbGetKbdByNameRequest
		major_opcode : UInt32
		minor_opcode : UInt32
		length : Uint16
		device_spec : XkbDeviceSpec
		need : Uint16
		want : Uint16
		load : UInt32
		pad0 : UInt32
	end

	struct XkbGetMapCookie
		sequence : UInt32
	end

	struct XkbGetMapMap
		types_rtrn : XkbKeyType*
		syms_rtrn : XkbKeySymMap*
		acts_rtrn_count : UInt8*
		pad2 : UInt8*
		acts_rtrn_acts : XkbAction*
		behaviors_rtrn : XkbSetBehavior*
		vmods_rtrn : UInt8*
		pad3 : UInt8*
		explicit_rtrn : XkbSetExplicit*
		pad4 : UInt8*
		modmap_rtrn : XkbKeyModMap*
		pad5 : UInt8*
		vmodmap_rtrn : XkbKeyVModMap*
	end

	struct XkbGetMapReply
		response_type : UInt32
		device_id : UInt32
		sequence : Uint16
		length : Uint32
		pad0 : UInt8[2]
		min_key_code : Keycode
		max_key_code : Keycode
		present : Uint16
		first_type : UInt32
		n_types : UInt32
		total_types : UInt32
		first_key_sym : Keycode
		total_syms : Uint16
		n_key_syms : UInt32
		first_key_action : Keycode
		total_actions : Uint16
		n_key_actions : UInt32
		first_key_behavior : Keycode
		n_key_behaviors : UInt32
		total_key_behaviors : UInt32
		first_key_explicit : Keycode
		n_key_explicit : UInt32
		total_key_explicit : UInt32
		first_mod_map_key : Keycode
		n_mod_map_keys : UInt32
		total_mod_map_keys : UInt32
		first_v_mod_map_key : Keycode
		n_v_mod_map_keys : UInt32
		total_v_mod_map_keys : UInt32
		pad1 : UInt32
		virtual_mods : Uint16
	end

	struct XkbGetMapRequest
		major_opcode : UInt32
		minor_opcode : UInt32
		length : Uint16
		device_spec : XkbDeviceSpec
		full : Uint16
		partial : Uint16
		first_type : UInt32
		n_types : UInt32
		first_key_sym : Keycode
		n_key_syms : UInt32
		first_key_action : Keycode
		n_key_actions : UInt32
		first_key_behavior : Keycode
		n_key_behaviors : UInt32
		virtual_mods : Uint16
		first_key_explicit : Keycode
		n_key_explicit : UInt32
		first_mod_map_key : Keycode
		n_mod_map_keys : UInt32
		first_v_mod_map_key : Keycode
		n_v_mod_map_keys : UInt32
		pad0 : UInt8[2]
	end

	struct XkbGetNamedIndicatorCookie
		sequence : UInt32
	end

	struct XkbGetNamedIndicatorReply
		response_type : UInt32
		device_id : UInt32
		sequence : Uint16
		length : Uint32
		indicator : Atom
		found : UInt32
		on : UInt32
		real_indicator : UInt32
		ndx : UInt32
		map_flags : UInt32
		map_which_groups : UInt32
		map_groups : UInt32
		map_which_mods : UInt32
		map_mods : UInt32
		map_real_mods : UInt32
		map_vmod : Uint16
		map_ctrls : Uint32
		supported : UInt32
		pad0 : UInt8[3]
	end

	struct XkbGetNamedIndicatorRequest
		major_opcode : UInt32
		minor_opcode : UInt32
		length : Uint16
		device_spec : XkbDeviceSpec
		led_class : XkbLedClassSpec
		led_id : XkbIdSpec
		pad0 : UInt8[2]
		indicator : Atom
	end

	struct XkbGetNamesCookie
		sequence : UInt32
	end

	struct XkbGetNamesReply
		response_type : UInt32
		device_id : UInt32
		sequence : Uint16
		length : Uint32
		which : Uint32
		min_key_code : Keycode
		max_key_code : Keycode
		n_types : UInt32
		group_names : UInt32
		virtual_mods : Uint16
		first_key : Keycode
		n_keys : UInt32
		indicators : Uint32
		n_radio_groups : UInt32
		n_key_aliases : UInt32
		n_kt_levels : Uint16
		pad0 : UInt8[4]
	end

	struct XkbGetNamesRequest
		major_opcode : UInt32
		minor_opcode : UInt32
		length : Uint16
		device_spec : XkbDeviceSpec
		pad0 : UInt8[2]
		which : Uint32
	end

	struct XkbGetNamesValueList
		keycodes_name : Atom
		geometry_name : Atom
		symbols_name : Atom
		phys_symbols_name : Atom
		types_name : Atom
		compat_name : Atom
		type_names : Atom*
		n_levels_per_type : UInt8*
		pad1 : UInt8*
		kt_level_names : Atom*
		indicator_names : Atom*
		virtual_mod_names : Atom*
		groups : Atom*
		key_names : XkbKeyName*
		key_aliases : XkbKeyAlias*
		radio_group_names : Atom*
	end

	struct XkbGetStateCookie
		sequence : UInt32
	end

	struct XkbGetStateReply
		response_type : UInt32
		device_id : UInt32
		sequence : Uint16
		length : Uint32
		mods : UInt32
		base_mods : UInt32
		latched_mods : UInt32
		locked_mods : UInt32
		group : UInt32
		locked_group : UInt32
		base_group : Int16
		latched_group : Int16
		compat_state : UInt32
		grab_mods : UInt32
		compat_grab_mods : UInt32
		lookup_mods : UInt32
		compat_lookup_mods : UInt32
		pad0 : UInt32
		ptr_btn_state : Uint16
		pad1 : UInt8[6]
	end

	struct XkbGetStateRequest
		major_opcode : UInt32
		minor_opcode : UInt32
		length : Uint16
		device_spec : XkbDeviceSpec
		pad0 : UInt8[2]
	end

	struct XkbIdSpecIterator
		data : XkbIdSpec*
		rem : Int32
		index : Int32
	end

	struct XkbIndicatorMapIterator
		data : XkbIndicatorMap*
		rem : Int32
		index : Int32
	end

	struct XkbIndicatorMapNotifyEvent
		response_type : UInt32
		xkb_type : UInt32
		sequence : Uint16
		time : Timestamp
		device_id : UInt32
		pad0 : UInt8[3]
		state : Uint32
		map_changed : Uint32
		pad1 : UInt8[12]
	end

	struct XkbIndicatorMap
		flags : UInt32
		which_groups : UInt32
		groups : UInt32
		which_mods : UInt32
		mods : UInt32
		real_mods : UInt32
		vmods : Uint16
		ctrls : Uint32
	end

	struct XkbIndicatorStateNotifyEvent
		response_type : UInt32
		xkb_type : UInt32
		sequence : Uint16
		time : Timestamp
		device_id : UInt32
		pad0 : UInt8[3]
		state : Uint32
		state_changed : Uint32
		pad1 : UInt8[12]
	end

	struct XkbKeyAliasIterator
		data : XkbKeyAlias*
		rem : Int32
		index : Int32
	end

	struct XkbKeyAlias
		real : Char[4]
		alias : Char[4]
	end

	struct XkbKeyIterator
		data : XkbKey*
		rem : Int32
		index : Int32
	end

	struct XkbKeyModMapIterator
		data : XkbKeyModMap*
		rem : Int32
		index : Int32
	end

	struct XkbKeyModMap
		keycode : Keycode
		mods : UInt32
	end

	struct XkbKeyNameIterator
		data : XkbKeyName*
		rem : Int32
		index : Int32
	end

	struct XkbKeyName
		name : Char[4]
	end

	struct XkbKeySymMapIterator
		data : XkbKeySymMap*
		rem : Int32
		index : Int32
	end

	struct XkbKeySymMap
		kt_index : UInt8[4]
		group_info : UInt32
		width : UInt32
		n_syms : Uint16
	end

	struct XkbKey
		name : CharT[4]
		gap : Int16
		shape_ndx : UInt32
		color_ndx : UInt32
	end

	struct XkbKeyTypeIterator
		data : XkbKeyType*
		rem : Int32
		index : Int32
	end

	struct XkbKeyType
		mods_mask : UInt32
		mods_mods : UInt32
		mods_vmods : Uint16
		num_levels : UInt32
		n_map_entries : UInt32
		has_preserve : UInt32
		pad0 : UInt32
	end

	struct XkbKeyVModMapIterator
		data : XkbKeyVModMap*
		rem : Int32
		index : Int32
	end

	struct XkbKeyVModMap
		keycode : Keycode
		pad0 : UInt32
		vmods : Uint16
	end

	struct XkbKeyboardError
		response_type : UInt32
		error_code : UInt32
		sequence : Uint16
		value : Uint32
		minor_opcode : Uint16
		major_opcode : UInt32
		pad0 : UInt8[21]
	end

	struct XkbKtMapEntryIterator
		data : XkbKtMapEntry*
		rem : Int32
		index : Int32
	end

	struct XkbKtMapEntry
		active : UInt32
		mods_mask : UInt32
		level : UInt32
		mods_mods : UInt32
		mods_vmods : Uint16
		pad0 : UInt8[2]
	end

	struct XkbKtSetMapEntryIterator
		data : XkbKtSetMapEntry*
		rem : Int32
		index : Int32
	end

	struct XkbKtSetMapEntry
		level : UInt32
		real_mods : UInt32
		virtual_mods : Uint16
	end

	struct XkbLatchLockStateRequest
		major_opcode : UInt32
		minor_opcode : UInt32
		length : Uint16
		device_spec : XkbDeviceSpec
		affect_mod_locks : UInt32
		mod_locks : UInt32
		lock_group : UInt32
		group_lock : UInt32
		affect_mod_latches : UInt32
		pad0 : UInt32
		pad1 : UInt32
		latch_group : UInt32
		group_latch : Uint16
	end

	struct XkbLedClassSpecIterator
		data : XkbLedClassSpec*
		rem : Int32
		index : Int32
	end

	struct XkbListComponentsCookie
		sequence : UInt32
	end

	struct XkbListComponentsReply
		response_type : UInt32
		device_id : UInt32
		sequence : Uint16
		length : Uint32
		n_keymaps : Uint16
		n_keycodes : Uint16
		n_types : Uint16
		n_compat_maps : Uint16
		n_symbols : Uint16
		n_geometries : Uint16
		extra : Uint16
		pad0 : UInt8[10]
	end

	struct XkbListComponentsRequest
		major_opcode : UInt32
		minor_opcode : UInt32
		length : Uint16
		device_spec : XkbDeviceSpec
		max_names : Uint16
	end

	struct XkbListingIterator
		data : XkbListing*
		rem : Int32
		index : Int32
	end

	struct XkbListing
		flags : Uint16
		length : Uint16
	end

	struct XkbLockBehaviorIterator
		data : XkbLockBehavior*
		rem : Int32
		index : Int32
	end

	struct XkbLockBehavior
		type : UInt32
		pad0 : UInt32
	end

	struct XkbMapNotifyEvent
		response_type : UInt32
		xkb_type : UInt32
		sequence : Uint16
		time : Timestamp
		device_id : UInt32
		ptr_btn_actions : UInt32
		changed : Uint16
		min_key_code : Keycode
		max_key_code : Keycode
		first_type : UInt32
		n_types : UInt32
		first_key_sym : Keycode
		n_key_syms : UInt32
		first_key_act : Keycode
		n_key_acts : UInt32
		first_key_behavior : Keycode
		n_key_behavior : UInt32
		first_key_explicit : Keycode
		n_key_explicit : UInt32
		first_mod_map_key : Keycode
		n_mod_map_keys : UInt32
		first_v_mod_map_key : Keycode
		n_v_mod_map_keys : UInt32
		virtual_mods : Uint16
		pad0 : UInt8[2]
	end

	struct XkbModDefIterator
		data : XkbModDef*
		rem : Int32
		index : Int32
	end

	struct XkbModDef
		mask : UInt32
		real_mods : UInt32
		vmods : Uint16
	end

	struct XkbNamesNotifyEvent
		response_type : UInt32
		xkb_type : UInt32
		sequence : Uint16
		time : Timestamp
		device_id : UInt32
		pad0 : UInt32
		changed : Uint16
		first_type : UInt32
		n_types : UInt32
		first_level_name : UInt32
		n_level_names : UInt32
		pad1 : UInt32
		n_radio_groups : UInt32
		n_key_aliases : UInt32
		changed_group_names : UInt32
		changed_virtual_mods : Uint16
		first_key : Keycode
		n_keys : UInt32
		changed_indicators : Uint32
		pad2 : UInt8[4]
	end

	struct XkbNewKeyboardNotifyEvent
		response_type : UInt32
		xkb_type : UInt32
		sequence : Uint16
		time : Timestamp
		device_id : UInt32
		old_device_id : UInt32
		min_key_code : Keycode
		max_key_code : Keycode
		old_min_key_code : Keycode
		old_max_key_code : Keycode
		request_major : UInt32
		request_minor : UInt32
		changed : Uint16
		pad0 : UInt8[14]
	end

	struct XkbOutlineIterator
		data : XkbOutline*
		rem : Int32
		index : Int32
	end

	struct XkbOutline
		n_points : UInt32
		corner_radius : UInt32
		pad0 : UInt8[2]
	end

	struct XkbOverlayBehaviorIterator
		data : XkbOverlayBehavior*
		rem : Int32
		index : Int32
	end

	struct XkbOverlayBehavior
		type : UInt32
		key : Keycode
	end

	struct XkbOverlayIterator
		data : XkbOverlay*
		rem : Int32
		index : Int32
	end

	struct XkbOverlayKeyIterator
		data : XkbOverlayKey*
		rem : Int32
		index : Int32
	end

	struct XkbOverlayKey
		over : CharT[4]
		under : CharT[4]
	end

	struct XkbOverlayRowIterator
		data : XkbOverlayRow*
		rem : Int32
		index : Int32
	end

	struct XkbOverlayRow
		row_under : UInt32
		n_keys : UInt32
		pad0 : UInt8[2]
	end

	struct XkbOverlay
		name : Atom
		n_rows : UInt32
		pad0 : UInt8[3]
	end

	struct XkbPerClientFlagsCookie
		sequence : UInt32
	end

	struct XkbPerClientFlagsReply
		response_type : UInt32
		device_id : UInt32
		sequence : Uint16
		length : Uint32
		supported : Uint32
		value : Uint32
		auto_ctrls : Uint32
		auto_ctrls_values : Uint32
		pad0 : UInt8[8]
	end

	struct XkbPerClientFlagsRequest
		major_opcode : UInt32
		minor_opcode : UInt32
		length : Uint16
		device_spec : XkbDeviceSpec
		pad0 : UInt8[2]
		change : Uint32
		value : Uint32
		ctrls_to_change : Uint32
		auto_ctrls : Uint32
		auto_ctrls_values : Uint32
	end

	struct XkbPermamentLockBehaviorIterator
		data : XkbPermamentLockBehavior*
		rem : Int32
		index : Int32
	end

	struct XkbPermamentLockBehavior
		type : UInt32
		pad0 : UInt32
	end

	struct XkbPermamentOverlayBehaviorIterator
		data : XkbPermamentOverlayBehavior*
		rem : Int32
		index : Int32
	end

	struct XkbPermamentOverlayBehavior
		type : UInt32
		key : Keycode
	end

	struct XkbPermamentRadioGroupBehaviorIterator
		data : XkbPermamentRadioGroupBehavior*
		rem : Int32
		index : Int32
	end

	struct XkbPermamentRadioGroupBehavior
		type : UInt32
		group : UInt32
	end

	struct XkbRadioGroupBehaviorIterator
		data : XkbRadioGroupBehavior*
		rem : Int32
		index : Int32
	end

	struct XkbRadioGroupBehavior
		type : UInt32
		group : UInt32
	end

	struct XkbRowIterator
		data : XkbRow*
		rem : Int32
		index : Int32
	end

	struct XkbRow
		top : Int16
		left : Int16
		n_keys : UInt32
		vertical : UInt32
		pad0 : UInt8[2]
	end

	struct XkbSaActionMessageIterator
		data : XkbSaActionMessage*
		rem : Int32
		index : Int32
	end

	struct XkbSaActionMessage
		type : UInt32
		flags : UInt32
		message : UInt8[6]
	end

	struct XkbSaDeviceBtnIterator
		data : XkbSaDeviceBtn*
		rem : Int32
		index : Int32
	end

	struct XkbSaDeviceBtn
		type : UInt32
		flags : UInt32
		count : UInt32
		button : UInt32
		device : UInt32
		pad0 : UInt8[3]
	end

	struct XkbSaDeviceValuatorIterator
		data : XkbSaDeviceValuator*
		rem : Int32
		index : Int32
	end

	struct XkbSaDeviceValuator
		type : UInt32
		device : UInt32
		val1what : UInt32
		val1index : UInt32
		val1value : UInt32
		val2what : UInt32
		val2index : UInt32
		val2value : UInt32
	end

	struct XkbSaIsoLockIterator
		data : XkbSaIsoLock*
		rem : Int32
		index : Int32
	end

	struct XkbSaIsoLock
		type : UInt32
		flags : UInt32
		mask : UInt32
		real_mods : UInt32
		group : Int8
		affect : UInt32
		vmods_high : UInt32
		vmods_low : UInt32
	end

	struct XkbSaLatchGroupIterator
		data : XkbSaLatchGroup*
		rem : Int32
		index : Int32
	end

	struct XkbSaLatchGroup
		type : UInt32
		flags : UInt32
		group : Int8
		pad0 : UInt8[5]
	end

	struct XkbSaLatchModsIterator
		data : XkbSaLatchMods*
		rem : Int32
		index : Int32
	end

	struct XkbSaLatchMods
		type : UInt32
		flags : UInt32
		mask : UInt32
		real_mods : UInt32
		vmods_high : UInt32
		vmods_low : UInt32
		pad0 : UInt8[2]
	end

	struct XkbSaLockControlsIterator
		data : XkbSaLockControls*
		rem : Int32
		index : Int32
	end

	struct XkbSaLockControls
		type : UInt32
		pad0 : UInt8[3]
		bool_ctrls_high : UInt32
		bool_ctrls_low : UInt32
		pad1 : UInt8[2]
	end

	struct XkbSaLockDeviceBtnIterator
		data : XkbSaLockDeviceBtn*
		rem : Int32
		index : Int32
	end

	struct XkbSaLockDeviceBtn
		type : UInt32
		flags : UInt32
		pad0 : UInt32
		button : UInt32
		device : UInt32
		pad1 : UInt8[3]
	end

	struct XkbSaLockGroupIterator
		data : XkbSaLockGroup*
		rem : Int32
		index : Int32
	end

	struct XkbSaLockGroup
		type : UInt32
		flags : UInt32
		group : Int8
		pad0 : UInt8[5]
	end

	struct XkbSaLockModsIterator
		data : XkbSaLockMods*
		rem : Int32
		index : Int32
	end

	struct XkbSaLockMods
		type : UInt32
		flags : UInt32
		mask : UInt32
		real_mods : UInt32
		vmods_high : UInt32
		vmods_low : UInt32
		pad0 : UInt8[2]
	end

	struct XkbSaLockPtrBtnIterator
		data : XkbSaLockPtrBtn*
		rem : Int32
		index : Int32
	end

	struct XkbSaLockPtrBtn
		type : UInt32
		flags : UInt32
		pad0 : UInt32
		button : UInt32
		pad1 : UInt8[4]
	end

	struct XkbSaMovePtrIterator
		data : XkbSaMovePtr*
		rem : Int32
		index : Int32
	end

	struct XkbSaMovePtr
		type : UInt32
		flags : UInt32
		x_high : Int8
		x_low : UInt32
		y_high : Int8
		y_low : UInt32
		pad0 : UInt8[2]
	end

	struct XkbSaNoActionIterator
		data : XkbSaNoAction*
		rem : Int32
		index : Int32
	end

	struct XkbSaNoAction
		type : UInt32
		pad0 : UInt8[7]
	end

	struct XkbSaPtrBtnIterator
		data : XkbSaPtrBtn*
		rem : Int32
		index : Int32
	end

	struct XkbSaPtrBtn
		type : UInt32
		flags : UInt32
		count : UInt32
		button : UInt32
		pad0 : UInt8[4]
	end

	struct XkbSaRedirectKeyIterator
		data : XkbSaRedirectKey*
		rem : Int32
		index : Int32
	end

	struct XkbSaRedirectKey
		type : UInt32
		newkey : Keycode
		mask : UInt32
		real_modifiers : UInt32
		vmods_mask_high : UInt32
		vmods_mask_low : UInt32
		vmods_high : UInt32
		vmods_low : UInt32
	end

	struct XkbSaSetControlsIterator
		data : XkbSaSetControls*
		rem : Int32
		index : Int32
	end

	struct XkbSaSetControls
		type : UInt32
		pad0 : UInt8[3]
		bool_ctrls_high : UInt32
		bool_ctrls_low : UInt32
		pad1 : UInt8[2]
	end

	struct XkbSaSetGroupIterator
		data : XkbSaSetGroup*
		rem : Int32
		index : Int32
	end

	struct XkbSaSetGroup
		type : UInt32
		flags : UInt32
		group : Int8
		pad0 : UInt8[5]
	end

	struct XkbSaSetModsIterator
		data : XkbSaSetMods*
		rem : Int32
		index : Int32
	end

	struct XkbSaSetMods
		type : UInt32
		flags : UInt32
		mask : UInt32
		real_mods : UInt32
		vmods_high : UInt32
		vmods_low : UInt32
		pad0 : UInt8[2]
	end

	struct XkbSaSetPtrDfltIterator
		data : XkbSaSetPtrDflt*
		rem : Int32
		index : Int32
	end

	struct XkbSaSetPtrDflt
		type : UInt32
		flags : UInt32
		affect : UInt32
		value : Int8
		pad0 : UInt8[4]
	end

	struct XkbSaSwitchScreenIterator
		data : XkbSaSwitchScreen*
		rem : Int32
		index : Int32
	end

	struct XkbSaSwitchScreen
		type : UInt32
		flags : UInt32
		new_screen : Int8
		pad0 : UInt8[5]
	end

	struct XkbSaTerminateIterator
		data : XkbSaTerminate*
		rem : Int32
		index : Int32
	end

	struct XkbSaTerminate
		type : UInt32
		pad0 : UInt8[7]
	end

	struct XkbSelectEventsDetails
		affect_new_keyboard : Uint16
		new_keyboard_details : Uint16
		affect_state : Uint16
		state_details : Uint16
		affect_ctrls : Uint32
		ctrl_details : Uint32
		affect_indicator_state : Uint32
		indicator_state_details : Uint32
		affect_indicator_map : Uint32
		indicator_map_details : Uint32
		affect_names : Uint16
		names_details : Uint16
		affect_compat : UInt32
		compat_details : UInt32
		affect_bell : UInt32
		bell_details : UInt32
		affect_msg_details : UInt32
		msg_details : UInt32
		affect_access_x : Uint16
		access_x_details : Uint16
		affect_ext_dev : Uint16
		extdev_details : Uint16
	end

	struct XkbSelectEventsRequest
		major_opcode : UInt32
		minor_opcode : UInt32
		length : Uint16
		device_spec : XkbDeviceSpec
		affect_which : Uint16
		clear : Uint16
		select_all : Uint16
		affect_map : Uint16
		map : Uint16
	end

	struct XkbSetBehaviorIterator
		data : XkbSetBehavior*
		rem : Int32
		index : Int32
	end

	struct XkbSetBehavior
		keycode : Keycode
		behavior : XkbBehavior
		pad0 : UInt32
	end

	struct XkbSetCompatMapRequest
		major_opcode : UInt32
		minor_opcode : UInt32
		length : Uint16
		device_spec : XkbDeviceSpec
		pad0 : UInt32
		recompute_actions : UInt32
		truncate_si : UInt32
		groups : UInt32
		first_si : Uint16
		n_si : Uint16
		pad1 : UInt8[2]
	end

	struct XkbSetControlsRequest
		major_opcode : UInt32
		minor_opcode : UInt32
		length : Uint16
		device_spec : XkbDeviceSpec
		affect_internal_real_mods : UInt32
		internal_real_mods : UInt32
		affect_ignore_lock_real_mods : UInt32
		ignore_lock_real_mods : UInt32
		affect_internal_virtual_mods : Uint16
		internal_virtual_mods : Uint16
		affect_ignore_lock_virtual_mods : Uint16
		ignore_lock_virtual_mods : Uint16
		mouse_keys_dflt_btn : UInt32
		groups_wrap : UInt32
		access_x_options : Uint16
		pad0 : UInt8[2]
		affect_enabled_controls : Uint32
		enabled_controls : Uint32
		change_controls : Uint32
		repeat_delay : Uint16
		repeat_interval : Uint16
		slow_keys_delay : Uint16
		debounce_delay : Uint16
		mouse_keys_delay : Uint16
		mouse_keys_interval : Uint16
		mouse_keys_time_to_max : Uint16
		mouse_keys_max_speed : Uint16
		mouse_keys_curve : Int16
		access_x_timeout : Uint16
		access_x_timeout_mask : Uint32
		access_x_timeout_values : Uint32
		access_x_timeout_options_mask : Uint16
		access_x_timeout_options_values : Uint16
		per_key_repeat : UInt8[32]
	end

	struct XkbSetDebuggingFlagsCookie
		sequence : UInt32
	end

	struct XkbSetDebuggingFlagsReply
		response_type : UInt32
		pad0 : UInt32
		sequence : Uint16
		length : Uint32
		current_flags : Uint32
		current_ctrls : Uint32
		supported_flags : Uint32
		supported_ctrls : Uint32
		pad1 : UInt8[8]
	end

	struct XkbSetDebuggingFlagsRequest
		major_opcode : UInt32
		minor_opcode : UInt32
		length : Uint16
		msg_length : Uint16
		pad0 : UInt8[2]
		affect_flags : Uint32
		flags : Uint32
		affect_ctrls : Uint32
		ctrls : Uint32
	end

	struct XkbSetDeviceInfoRequest
		major_opcode : UInt32
		minor_opcode : UInt32
		length : Uint16
		device_spec : XkbDeviceSpec
		first_btn : UInt32
		n_btns : UInt32
		change : Uint16
		n_device_led_f_bs : Uint16
	end

	struct XkbSetExplicitIterator
		data : XkbSetExplicit*
		rem : Int32
		index : Int32
	end

	struct XkbSetExplicit
		keycode : Keycode
		explicit : UInt32
	end

	struct XkbSetIndicatorMapRequest
		major_opcode : UInt32
		minor_opcode : UInt32
		length : Uint16
		device_spec : XkbDeviceSpec
		pad0 : UInt8[2]
		which : Uint32
	end

	struct XkbSetKeyTypeIterator
		data : XkbSetKeyType*
		rem : Int32
		index : Int32
	end

	struct XkbSetKeyType
		mask : UInt32
		real_mods : UInt32
		virtual_mods : Uint16
		num_levels : UInt32
		n_map_entries : UInt32
		preserve : UInt32
		pad0 : UInt32
	end

	struct XkbSetMapRequest
		major_opcode : UInt32
		minor_opcode : UInt32
		length : Uint16
		device_spec : XkbDeviceSpec
		present : Uint16
		flags : Uint16
		min_key_code : Keycode
		max_key_code : Keycode
		first_type : UInt32
		n_types : UInt32
		first_key_sym : Keycode
		n_key_syms : UInt32
		total_syms : Uint16
		first_key_action : Keycode
		n_key_actions : UInt32
		total_actions : Uint16
		first_key_behavior : Keycode
		n_key_behaviors : UInt32
		total_key_behaviors : UInt32
		first_key_explicit : Keycode
		n_key_explicit : UInt32
		total_key_explicit : UInt32
		first_mod_map_key : Keycode
		n_mod_map_keys : UInt32
		total_mod_map_keys : UInt32
		first_v_mod_map_key : Keycode
		n_v_mod_map_keys : UInt32
		total_v_mod_map_keys : UInt32
		virtual_mods : Uint16
	end

	struct XkbSetMapValues
		types : XkbSetKeyType*
		syms : XkbKeySymMap*
		actions_count : UInt8*
		actions : XkbAction*
		behaviors : XkbSetBehavior*
		vmods : UInt8*
		explicit : XkbSetExplicit*
		modmap : XkbKeyModMap*
		vmodmap : XkbKeyVModMap*
	end

	struct XkbSetNamedIndicatorRequest
		major_opcode : UInt32
		minor_opcode : UInt32
		length : Uint16
		device_spec : XkbDeviceSpec
		led_class : XkbLedClassSpec
		led_id : XkbIdSpec
		pad0 : UInt8[2]
		indicator : Atom
		set_state : UInt32
		on : UInt32
		set_map : UInt32
		create_map : UInt32
		pad1 : UInt32
		map_flags : UInt32
		map_which_groups : UInt32
		map_groups : UInt32
		map_which_mods : UInt32
		map_real_mods : UInt32
		map_vmods : Uint16
		map_ctrls : Uint32
	end

	struct XkbSetNamesRequest
		major_opcode : UInt32
		minor_opcode : UInt32
		length : Uint16
		device_spec : XkbDeviceSpec
		virtual_mods : Uint16
		which : Uint32
		first_type : UInt32
		n_types : UInt32
		first_kt_levelt : UInt32
		n_kt_levels : UInt32
		indicators : Uint32
		group_names : UInt32
		n_radio_groups : UInt32
		first_key : Keycode
		n_keys : UInt32
		n_key_aliases : UInt32
		pad0 : UInt32
		total_kt_level_names : Uint16
	end

	struct XkbSetNamesValues
		keycodes_name : Atom
		geometry_name : Atom
		symbols_name : Atom
		phys_symbols_name : Atom
		types_name : Atom
		compat_name : Atom
		type_names : Atom*
		n_levels_per_type : UInt8*
		kt_level_names : Atom*
		indicator_names : Atom*
		virtual_mod_names : Atom*
		groups : Atom*
		key_names : XkbKeyName*
		key_aliases : XkbKeyAlias*
		radio_group_names : Atom*
	end

	struct XkbShapeIterator
		data : XkbShape*
		rem : Int32
		index : Int32
	end

	struct XkbShape
		name : Atom
		n_outlines : UInt32
		primary_ndx : UInt32
		approx_ndx : UInt32
		pad0 : UInt32
	end

	struct XkbSiActionIterator
		data : XkbSiAction*
		rem : Int32
		index : Int32
	end

	struct XkbSiAction
		type : UInt32
		data : UInt8[7]
	end

	struct XkbStateNotifyEvent
		response_type : UInt32
		xkb_type : UInt32
		sequence : Uint16
		time : Timestamp
		device_id : UInt32
		mods : UInt32
		base_mods : UInt32
		latched_mods : UInt32
		locked_mods : UInt32
		group : UInt32
		base_group : Int16
		latched_group : Int16
		locked_group : UInt32
		compat_state : UInt32
		grab_mods : UInt32
		compat_grab_mods : UInt32
		lookup_mods : UInt32
		compat_loockup_mods : UInt32
		ptr_btn_state : Uint16
		changed : Uint16
		keycode : Keycode
		event_type : UInt32
		request_major : UInt32
		request_minor : UInt32
	end

	struct CharIterator
		data : Char*
		rem : Int32
		index : Int32
	end

	struct XkbSymInterpretIterator
		data : XkbSymInterpret*
		rem : Int32
		index : Int32
	end

	struct XkbSymInterpret
		sym : Keysym
		mods : UInt32
		match : UInt32
		virtual_mod : UInt32
		flags : UInt32
		action : XkbSiAction
	end

	struct XkbUseExtensionCookie
		sequence : UInt32
	end

	struct XkbUseExtensionReply
		response_type : UInt32
		supported : UInt32
		sequence : Uint16
		length : Uint32
		server_major : Uint16
		server_minor : Uint16
		pad0 : UInt8[20]
	end

	struct XkbUseExtensionRequest
		major_opcode : UInt32
		minor_opcode : UInt32
		length : Uint16
		wanted_major : Uint16
		wanted_minor : Uint16
	end


	fun xcb_xkb_action_end(i : XkbActionIterator) : GenericIterator
	fun xcb_xkb_action_next(i : XkbActionIterator*)
	fun xcb_xkb_behavior_end(i : XkbBehaviorIterator) : GenericIterator
	fun xcb_xkb_behavior_next(i : XkbBehaviorIterator*)
	fun xcb_xkb_bell(c : Connection, device_spec : XkbDeviceSpec, bell_class : XkbBellClassSpec, bell_id : XkbIdSpec, percent : Int8, force_sound : UInt8, event_only : UInt8, pitch : Int16, duration : Int16, name : Atom, window : Window) : VoidCookie
	fun xcb_xkb_bell_checked(c : Connection, device_spec : XkbDeviceSpec, bell_class : XkbBellClassSpec, bell_id : XkbIdSpec, percent : Int8, force_sound : UInt8, event_only : UInt8, pitch : Int16, duration : Int16, name : Atom, window : Window) : VoidCookie
	fun xcb_xkb_bell_class_spec_end(i : XkbBellClassSpecIterator) : GenericIterator
	fun xcb_xkb_bell_class_spec_next(i : XkbBellClassSpecIterator*)
	fun xcb_xkb_common_behavior_end(i : XkbCommonBehaviorIterator) : GenericIterator
	fun xcb_xkb_common_behavior_next(i : XkbCommonBehaviorIterator*)
	fun xcb_xkb_counted_string_16_alignment_pad(r : XkbCountedString16*) : Void*
		fun xcb_xkb_counted_string_16_alignment_pad_end(r : XkbCountedString16*) : GenericIterator
	fun xcb_xkb_counted_string_16_alignment_pad_length(r : XkbCountedString16*) : Int32
	fun xcb_xkb_counted_string_16_end(i : XkbCountedString16Iterator) : GenericIterator
	fun xcb_xkb_counted_string_16_next(i : XkbCountedString16Iterator*)
	fun xcb_xkb_counted_string_16_sizeof(_buffer : Void*) : Int32
	fun xcb_xkb_counted_string_16_string(r : XkbCountedString16*) : Char*
		fun xcb_xkb_counted_string_16_string_end(r : XkbCountedString16*) : GenericIterator
	fun xcb_xkb_counted_string_16_string_length(r : XkbCountedString16*) : Int32
	fun xcb_xkb_default_behavior_end(i : XkbDefaultBehaviorIterator) : GenericIterator
	fun xcb_xkb_default_behavior_next(i : XkbDefaultBehaviorIterator*)
	fun xcb_xkb_device_led_info_end(i : XkbDeviceLedInfoIterator) : GenericIterator
	fun xcb_xkb_device_led_info_maps(r : XkbDeviceLedInfo*) : XkbIndicatorMap*
		fun xcb_xkb_device_led_info_maps_iterator(r : XkbDeviceLedInfo*) : XkbIndicatorMapIterator
	fun xcb_xkb_device_led_info_maps_length(r : XkbDeviceLedInfo*) : Int32
	fun xcb_xkb_device_led_info_names(r : XkbDeviceLedInfo*) : Atom*
		fun xcb_xkb_device_led_info_names_end(r : XkbDeviceLedInfo*) : GenericIterator
	fun xcb_xkb_device_led_info_names_length(r : XkbDeviceLedInfo*) : Int32
	fun xcb_xkb_device_led_info_next(i : XkbDeviceLedInfoIterator*)
	fun xcb_xkb_device_led_info_sizeof(_buffer : Void*) : Int32
	fun xcb_xkb_device_spec_end(i : XkbDeviceSpecIterator) : GenericIterator
	fun xcb_xkb_device_spec_next(i : XkbDeviceSpecIterator*)
	fun xcb_xkb_get_compat_map(c : Connection, device_spec : XkbDeviceSpec, groups : UInt8, get_all_si : UInt8, first_si : UInt16, n_si : UInt16) : XkbGetCompatMapCookie
	fun xcb_xkb_get_compat_map_group_rtrn(r : XkbGetCompatMapReply*) : XkbModDef*
		fun xcb_xkb_get_compat_map_group_rtrn_iterator(r : XkbGetCompatMapReply*) : XkbModDefIterator
	fun xcb_xkb_get_compat_map_group_rtrn_length(r : XkbGetCompatMapReply*) : Int32
	fun xcb_xkb_get_compat_map_reply(c : Connection, cookie : XkbGetCompatMapCookie, e : GenericError**) : XkbGetCompatMapReply*
		fun xcb_xkb_get_compat_map_si_rtrn(r : XkbGetCompatMapReply*) : XkbSymInterpret*
		fun xcb_xkb_get_compat_map_si_rtrn_iterator(r : XkbGetCompatMapReply*) : XkbSymInterpretIterator
	fun xcb_xkb_get_compat_map_si_rtrn_length(r : XkbGetCompatMapReply*) : Int32
	fun xcb_xkb_get_compat_map_sizeof(_buffer : Void*) : Int32
	fun xcb_xkb_get_compat_map_unchecked(c : Connection, device_spec : XkbDeviceSpec, groups : UInt8, get_all_si : UInt8, first_si : UInt16, n_si : UInt16) : XkbGetCompatMapCookie
	fun xcb_xkb_get_controls(c : Connection, device_spec : XkbDeviceSpec) : XkbGetControlsCookie
	fun xcb_xkb_get_controls_reply(c : Connection, cookie : XkbGetControlsCookie, e : GenericError**) : XkbGetControlsReply*
		fun xcb_xkb_get_controls_unchecked(c : Connection, device_spec : XkbDeviceSpec) : XkbGetControlsCookie
	fun xcb_xkb_get_device_info(c : Connection, device_spec : XkbDeviceSpec, wanted : UInt16, all_buttons : UInt8, first_button : UInt8, n_buttons : UInt8, led_class : XkbLedClassSpec, led_id : XkbIdSpec) : XkbGetDeviceInfoCookie
	fun xcb_xkb_get_device_info_btn_actions(r : XkbGetDeviceInfoReply*) : XkbAction*
		fun xcb_xkb_get_device_info_btn_actions_iterator(r : XkbGetDeviceInfoReply*) : XkbActionIterator
	fun xcb_xkb_get_device_info_btn_actions_length(r : XkbGetDeviceInfoReply*) : Int32
	fun xcb_xkb_get_device_info_leds_iterator(r : XkbGetDeviceInfoReply*) : XkbDeviceLedInfoIterator
	fun xcb_xkb_get_device_info_leds_length(r : XkbGetDeviceInfoReply*) : Int32
	fun xcb_xkb_get_device_info_name(r : XkbGetDeviceInfoReply*) : Char*
		fun xcb_xkb_get_device_info_name_end(r : XkbGetDeviceInfoReply*) : GenericIterator
	fun xcb_xkb_get_device_info_name_length(r : XkbGetDeviceInfoReply*) : Int32
	fun xcb_xkb_get_device_info_reply(c : Connection, cookie : XkbGetDeviceInfoCookie, e : GenericError**) : XkbGetDeviceInfoReply*
		fun xcb_xkb_get_device_info_sizeof(_buffer : Void*) : Int32
	fun xcb_xkb_get_device_info_unchecked(c : Connection, device_spec : XkbDeviceSpec, wanted : UInt16, all_buttons : UInt8, first_button : UInt8, n_buttons : UInt8, led_class : XkbLedClassSpec, led_id : XkbIdSpec) : XkbGetDeviceInfoCookie
	# Returns A cookie
	fun xcb_xkb_get_indicator_map(c : Connection, device_spec : XkbDeviceSpec, which : UInt32) : XkbGetIndicatorMapCookie
	fun xcb_xkb_get_indicator_map_maps(r : XkbGetIndicatorMapReply*) : XkbIndicatorMap*
		fun xcb_xkb_get_indicator_map_maps_iterator(r : XkbGetIndicatorMapReply*) : XkbIndicatorMapIterator
	fun xcb_xkb_get_indicator_map_maps_length(r : XkbGetIndicatorMapReply*) : Int32
	fun xcb_xkb_get_indicator_map_reply(c : Connection, cookie : XkbGetIndicatorMapCookie, e : GenericError**) : XkbGetIndicatorMapReply*
		fun xcb_xkb_get_indicator_map_sizeof(_buffer : Void*) : Int32
	fun xcb_xkb_get_indicator_map_unchecked(c : Connection, device_spec : XkbDeviceSpec, which : UInt32) : XkbGetIndicatorMapCookie
	fun xcb_xkb_get_indicator_state(c : Connection, device_spec : XkbDeviceSpec) : XkbGetIndicatorStateCookie
	fun xcb_xkb_get_indicator_state_reply(c : Connection, cookie : XkbGetIndicatorStateCookie, e : GenericError**) : XkbGetIndicatorStateReply*
		fun xcb_xkb_get_indicator_state_unchecked(c : Connection, device_spec : XkbDeviceSpec) : XkbGetIndicatorStateCookie
	fun xcb_xkb_get_kbd_by_name(c : Connection, device_spec : XkbDeviceSpec, need : UInt16, want : UInt16, load : UInt8) : XkbGetKbdByNameCookie
	fun xcb_xkb_get_kbd_by_name_replies(r : XkbGetKbdByNameReply*) : Void*
		fun xcb_xkb_get_kbd_by_name_replies_compat_map_group_rtrn(s : XkbGetKbdByNameReplies*) : XkbModDef*
		fun xcb_xkb_get_kbd_by_name_replies_compat_map_group_rtrn_iterator(r : XkbGetKbdByNameReply*, s : XkbGetKbdByNameReplies*) : XkbModDefIterator
	fun xcb_xkb_get_kbd_by_name_replies_compat_map_group_rtrn_length(r : XkbGetKbdByNameReply*, s : XkbGetKbdByNameReplies*) : Int32
	fun xcb_xkb_get_kbd_by_name_replies_compat_map_si_rtrn(s : XkbGetKbdByNameReplies*) : XkbSymInterpret*
		fun xcb_xkb_get_kbd_by_name_replies_compat_map_si_rtrn_iterator(r : XkbGetKbdByNameReply*, s : XkbGetKbdByNameReplies*) : XkbSymInterpretIterator
	fun xcb_xkb_get_kbd_by_name_replies_compat_map_si_rtrn_length(r : XkbGetKbdByNameReply*, s : XkbGetKbdByNameReplies*) : Int32
	fun xcb_xkb_get_kbd_by_name_replies_geometry_label_font(r : XkbGetKbdByNameReplies*) : XkbCountedString16*
		fun xcb_xkb_get_kbd_by_name_replies_indicator_maps_maps(s : XkbGetKbdByNameReplies*) : XkbIndicatorMap*
		fun xcb_xkb_get_kbd_by_name_replies_indicator_maps_maps_iterator(r : XkbGetKbdByNameReply*, s : XkbGetKbdByNameReplies*) : XkbIndicatorMapIterator
	fun xcb_xkb_get_kbd_by_name_replies_indicator_maps_maps_length(r : XkbGetKbdByNameReply*, s : XkbGetKbdByNameReplies*) : Int32
	fun xcb_xkb_get_kbd_by_name_replies_key_names_value_list(r : XkbGetKbdByNameReplies*) : XkbGetKbdByNameRepliesKeyNamesValueList*
		fun xcb_xkb_get_kbd_by_name_replies_key_names_value_list_groups(s : XkbGetKbdByNameReplies*) : Atom*
		fun xcb_xkb_get_kbd_by_name_replies_key_names_value_list_groups_end(r : XkbGetKbdByNameReply*, s : XkbGetKbdByNameReplies*) : GenericIterator
	fun xcb_xkb_get_kbd_by_name_replies_key_names_value_list_groups_length(r : XkbGetKbdByNameReply*, s : XkbGetKbdByNameReplies*) : Int32
	fun xcb_xkb_get_kbd_by_name_replies_key_names_value_list_indicator_names(s : XkbGetKbdByNameReplies*) : Atom*
		fun xcb_xkb_get_kbd_by_name_replies_key_names_value_list_indicator_names_end(r : XkbGetKbdByNameReply*, s : XkbGetKbdByNameReplies*) : GenericIterator
	fun xcb_xkb_get_kbd_by_name_replies_key_names_value_list_indicator_names_length(r : XkbGetKbdByNameReply*, s : XkbGetKbdByNameReplies*) : Int32
	fun xcb_xkb_get_kbd_by_name_replies_key_names_value_list_key_aliases(s : XkbGetKbdByNameReplies*) : XkbKeyAlias*
		fun xcb_xkb_get_kbd_by_name_replies_key_names_value_list_key_aliases_iterator(r : XkbGetKbdByNameReply*, s : XkbGetKbdByNameReplies*) : XkbKeyAliasIterator
	fun xcb_xkb_get_kbd_by_name_replies_key_names_value_list_key_aliases_length(r : XkbGetKbdByNameReply*, s : XkbGetKbdByNameReplies*) : Int32
	fun xcb_xkb_get_kbd_by_name_replies_key_names_value_list_key_names(s : XkbGetKbdByNameReplies*) : XkbKeyName*
		fun xcb_xkb_get_kbd_by_name_replies_key_names_value_list_key_names_iterator(r : XkbGetKbdByNameReply*, s : XkbGetKbdByNameReplies*) : XkbKeyNameIterator
	fun xcb_xkb_get_kbd_by_name_replies_key_names_value_list_key_names_length(r : XkbGetKbdByNameReply*, s : XkbGetKbdByNameReplies*) : Int32
	fun xcb_xkb_get_kbd_by_name_replies_key_names_value_list_kt_level_names(s : XkbGetKbdByNameReplies*) : Atom*
		fun xcb_xkb_get_kbd_by_name_replies_key_names_value_list_kt_level_names_end(r : XkbGetKbdByNameReply*, s : XkbGetKbdByNameReplies*) : GenericIterator
	fun xcb_xkb_get_kbd_by_name_replies_key_names_value_list_kt_level_names_length(r : XkbGetKbdByNameReply*, s : XkbGetKbdByNameReplies*) : Int32
	fun xcb_xkb_get_kbd_by_name_replies_key_names_value_list_n_levels_per_type(s : XkbGetKbdByNameReplies*) : UInt8*
		fun xcb_xkb_get_kbd_by_name_replies_key_names_value_list_n_levels_per_type_end(r : XkbGetKbdByNameReply*, s : XkbGetKbdByNameReplies*) : GenericIterator
	fun xcb_xkb_get_kbd_by_name_replies_key_names_value_list_n_levels_per_type_length(r : XkbGetKbdByNameReply*, s : XkbGetKbdByNameReplies*) : Int32
	fun xcb_xkb_get_kbd_by_name_replies_key_names_value_list_radio_group_names(s : XkbGetKbdByNameReplies*) : Atom*
		fun xcb_xkb_get_kbd_by_name_replies_key_names_value_list_radio_group_names_end(r : XkbGetKbdByNameReply*, s : XkbGetKbdByNameReplies*) : GenericIterator
	fun xcb_xkb_get_kbd_by_name_replies_key_names_value_list_radio_group_names_length(r : XkbGetKbdByNameReply*, s : XkbGetKbdByNameReplies*) : Int32
	fun xcb_xkb_get_kbd_by_name_replies_key_names_value_list_serialize(_buffer : Void**, n_types : UInt8, indicators : UInt32, virtual_mods : UInt16, group_names : UInt8, n_keys : UInt8, n_key_aliases : UInt8, n_radio_groups : UInt8, which : UInt32, _aux : XkbGetKbdByNameRepliesKeyNamesValueList*) : Int32
	fun xcb_xkb_get_kbd_by_name_replies_key_names_value_list_sizeof(_buffer : Void*, n_types : UInt8, indicators : UInt32, virtual_mods : UInt16, group_names : UInt8, n_keys : UInt8, n_key_aliases : UInt8, n_radio_groups : UInt8, which : UInt32) : Int32
	fun xcb_xkb_get_kbd_by_name_replies_key_names_value_list_type_names(s : XkbGetKbdByNameReplies*) : Atom*
		fun xcb_xkb_get_kbd_by_name_replies_key_names_value_list_type_names_end(r : XkbGetKbdByNameReply*, s : XkbGetKbdByNameReplies*) : GenericIterator
	fun xcb_xkb_get_kbd_by_name_replies_key_names_value_list_type_names_length(r : XkbGetKbdByNameReply*, s : XkbGetKbdByNameReplies*) : Int32
	fun xcb_xkb_get_kbd_by_name_replies_key_names_value_list_unpack(_buffer : Void*, n_types : UInt8, indicators : UInt32, virtual_mods : UInt16, group_names : UInt8, n_keys : UInt8, n_key_aliases : UInt8, n_radio_groups : UInt8, which : UInt32, _aux : XkbGetKbdByNameRepliesKeyNamesValueList*) : Int32
	fun xcb_xkb_get_kbd_by_name_replies_key_names_value_list_virtual_mod_names(s : XkbGetKbdByNameReplies*) : Atom*
		fun xcb_xkb_get_kbd_by_name_replies_key_names_value_list_virtual_mod_names_end(r : XkbGetKbdByNameReply*, s : XkbGetKbdByNameReplies*) : GenericIterator
	fun xcb_xkb_get_kbd_by_name_replies_key_names_value_list_virtual_mod_names_length(r : XkbGetKbdByNameReply*, s : XkbGetKbdByNameReplies*) : Int32
	fun xcb_xkb_get_kbd_by_name_replies_serialize(_buffer : Void**, reported : UInt16, _aux : XkbGetKbdByNameReplies*) : Int32
	fun xcb_xkb_get_kbd_by_name_replies_sizeof(_buffer : Void*, reported : UInt16) : Int32
	fun xcb_xkb_get_kbd_by_name_replies_types_map(r : XkbGetKbdByNameReplies*) : XkbGetKbdByNameRepliesTypesMap*
		fun xcb_xkb_get_kbd_by_name_replies_types_map_acts_rtrn_acts(s : XkbGetKbdByNameReplies*) : XkbAction*
		fun xcb_xkb_get_kbd_by_name_replies_types_map_acts_rtrn_acts_iterator(r : XkbGetKbdByNameReply*, s : XkbGetKbdByNameReplies*) : XkbActionIterator
	fun xcb_xkb_get_kbd_by_name_replies_types_map_acts_rtrn_acts_length(r : XkbGetKbdByNameReply*, s : XkbGetKbdByNameReplies*) : Int32
	fun xcb_xkb_get_kbd_by_name_replies_types_map_acts_rtrn_count(s : XkbGetKbdByNameReplies*) : UInt8*
		fun xcb_xkb_get_kbd_by_name_replies_types_map_acts_rtrn_count_end(r : XkbGetKbdByNameReply*, s : XkbGetKbdByNameReplies*) : GenericIterator
	fun xcb_xkb_get_kbd_by_name_replies_types_map_acts_rtrn_count_length(r : XkbGetKbdByNameReply*, s : XkbGetKbdByNameReplies*) : Int32
	fun xcb_xkb_get_kbd_by_name_replies_types_map_behaviors_rtrn(s : XkbGetKbdByNameReplies*) : XkbSetBehavior*
		fun xcb_xkb_get_kbd_by_name_replies_types_map_behaviors_rtrn_iterator(r : XkbGetKbdByNameReply*, s : XkbGetKbdByNameReplies*) : XkbSetBehaviorIterator
	fun xcb_xkb_get_kbd_by_name_replies_types_map_behaviors_rtrn_length(r : XkbGetKbdByNameReply*, s : XkbGetKbdByNameReplies*) : Int32
	fun xcb_xkb_get_kbd_by_name_replies_types_map_explicit_rtrn(s : XkbGetKbdByNameReplies*) : XkbSetExplicit*
		fun xcb_xkb_get_kbd_by_name_replies_types_map_explicit_rtrn_iterator(r : XkbGetKbdByNameReply*, s : XkbGetKbdByNameReplies*) : XkbSetExplicitIterator
	fun xcb_xkb_get_kbd_by_name_replies_types_map_explicit_rtrn_length(r : XkbGetKbdByNameReply*, s : XkbGetKbdByNameReplies*) : Int32
	fun xcb_xkb_get_kbd_by_name_replies_types_map_modmap_rtrn(s : XkbGetKbdByNameReplies*) : XkbKeyModMap*
		fun xcb_xkb_get_kbd_by_name_replies_types_map_modmap_rtrn_iterator(r : XkbGetKbdByNameReply*, s : XkbGetKbdByNameReplies*) : XkbKeyModMapIterator
	fun xcb_xkb_get_kbd_by_name_replies_types_map_modmap_rtrn_length(r : XkbGetKbdByNameReply*, s : XkbGetKbdByNameReplies*) : Int32
	fun xcb_xkb_get_kbd_by_name_replies_types_map_serialize(_buffer : Void**, n_types : UInt8, n_key_syms : UInt8, n_key_actions : UInt8, total_actions : UInt16, total_key_behaviors : UInt8, virtual_mods : UInt16, total_key_explicit : UInt8, total_mod_map_keys : UInt8, total_v_mod_map_keys : UInt8, present : UInt16, _aux : XkbGetKbdByNameRepliesTypesMap*) : Int32
	fun xcb_xkb_get_kbd_by_name_replies_types_map_sizeof(_buffer : Void*, n_types : UInt8, n_key_syms : UInt8, n_key_actions : UInt8, total_actions : UInt16, total_key_behaviors : UInt8, virtual_mods : UInt16, total_key_explicit : UInt8, total_mod_map_keys : UInt8, total_v_mod_map_keys : UInt8, present : UInt16) : Int32
	fun xcb_xkb_get_kbd_by_name_replies_types_map_syms_rtrn_iterator(r : XkbGetKbdByNameReply*, s : XkbGetKbdByNameReplies*) : XkbKeySymMapIterator
	fun xcb_xkb_get_kbd_by_name_replies_types_map_syms_rtrn_length(r : XkbGetKbdByNameReply*, s : XkbGetKbdByNameReplies*) : Int32
	fun xcb_xkb_get_kbd_by_name_replies_types_map_types_rtrn_iterator(r : XkbGetKbdByNameReply*, s : XkbGetKbdByNameReplies*) : XkbKeyTypeIterator
	fun xcb_xkb_get_kbd_by_name_replies_types_map_types_rtrn_length(r : XkbGetKbdByNameReply*, s : XkbGetKbdByNameReplies*) : Int32
	fun xcb_xkb_get_kbd_by_name_replies_types_map_unpack(_buffer : Void*, n_types : UInt8, n_key_syms : UInt8, n_key_actions : UInt8, total_actions : UInt16, total_key_behaviors : UInt8, virtual_mods : UInt16, total_key_explicit : UInt8, total_mod_map_keys : UInt8, total_v_mod_map_keys : UInt8, present : UInt16, _aux : XkbGetKbdByNameRepliesTypesMap*) : Int32
	fun xcb_xkb_get_kbd_by_name_replies_types_map_vmodmap_rtrn(s : XkbGetKbdByNameReplies*) : XkbKeyVModMap*
		fun xcb_xkb_get_kbd_by_name_replies_types_map_vmodmap_rtrn_iterator(r : XkbGetKbdByNameReply*, s : XkbGetKbdByNameReplies*) : XkbKeyVModMapIterator
	fun xcb_xkb_get_kbd_by_name_replies_types_map_vmodmap_rtrn_length(r : XkbGetKbdByNameReply*, s : XkbGetKbdByNameReplies*) : Int32
	fun xcb_xkb_get_kbd_by_name_replies_types_map_vmods_rtrn(s : XkbGetKbdByNameReplies*) : UInt8*
		fun xcb_xkb_get_kbd_by_name_replies_types_map_vmods_rtrn_end(r : XkbGetKbdByNameReply*, s : XkbGetKbdByNameReplies*) : GenericIterator
	fun xcb_xkb_get_kbd_by_name_replies_types_map_vmods_rtrn_length(r : XkbGetKbdByNameReply*, s : XkbGetKbdByNameReplies*) : Int32
	fun xcb_xkb_get_kbd_by_name_replies_unpack(_buffer : Void*, reported : UInt16, _aux : XkbGetKbdByNameReplies*) : Int32
	fun xcb_xkb_get_kbd_by_name_reply(c : Connection, cookie : XkbGetKbdByNameCookie, e : GenericError**) : XkbGetKbdByNameReply*
		fun xcb_xkb_get_kbd_by_name_sizeof(_buffer : Void*) : Int32
	fun xcb_xkb_get_kbd_by_name_unchecked(c : Connection, device_spec : XkbDeviceSpec, need : UInt16, want : UInt16, load : UInt8) : XkbGetKbdByNameCookie
	fun xcb_xkb_get_map(c : Connection, device_spec : XkbDeviceSpec, full : UInt16, partial : UInt16, first_type : UInt8, n_types : UInt8, first_key_sym : Keycode, n_key_syms : UInt8, first_key_action : Keycode, n_key_actions : UInt8, first_key_behavior : Keycode, n_key_behaviors : UInt8, virtual_mods : UInt16, first_key_explicit : Keycode, n_key_explicit : UInt8, first_mod_map_key : Keycode, n_mod_map_keys : UInt8, first_v_mod_map_key : Keycode, n_v_mod_map_keys : UInt8) : XkbGetMapCookie
	fun xcb_xkb_get_map_map(r : XkbGetMapReply*) : Void*
		fun xcb_xkb_get_map_map_acts_rtrn_acts(s : XkbGetMapMap*) : XkbAction*
		fun xcb_xkb_get_map_map_acts_rtrn_acts_iterator(r : XkbGetMapReply*, s : XkbGetMapMap*) : XkbActionIterator
	fun xcb_xkb_get_map_map_acts_rtrn_acts_length(r : XkbGetMapReply*, s : XkbGetMapMap*) : Int32
	fun xcb_xkb_get_map_map_acts_rtrn_count(s : XkbGetMapMap*) : UInt8*
		fun xcb_xkb_get_map_map_acts_rtrn_count_end(r : XkbGetMapReply*, s : XkbGetMapMap*) : GenericIterator
	fun xcb_xkb_get_map_map_acts_rtrn_count_length(r : XkbGetMapReply*, s : XkbGetMapMap*) : Int32
	fun xcb_xkb_get_map_map_behaviors_rtrn(s : XkbGetMapMap*) : XkbSetBehavior*
		fun xcb_xkb_get_map_map_behaviors_rtrn_iterator(r : XkbGetMapReply*, s : XkbGetMapMap*) : XkbSetBehaviorIterator
	fun xcb_xkb_get_map_map_behaviors_rtrn_length(r : XkbGetMapReply*, s : XkbGetMapMap*) : Int32
	fun xcb_xkb_get_map_map_explicit_rtrn(s : XkbGetMapMap*) : XkbSetExplicit*
		fun xcb_xkb_get_map_map_explicit_rtrn_iterator(r : XkbGetMapReply*, s : XkbGetMapMap*) : XkbSetExplicitIterator
	fun xcb_xkb_get_map_map_explicit_rtrn_length(r : XkbGetMapReply*, s : XkbGetMapMap*) : Int32
	fun xcb_xkb_get_map_map_modmap_rtrn(s : XkbGetMapMap*) : XkbKeyModMap*
		fun xcb_xkb_get_map_map_modmap_rtrn_iterator(r : XkbGetMapReply*, s : XkbGetMapMap*) : XkbKeyModMapIterator
	fun xcb_xkb_get_map_map_modmap_rtrn_length(r : XkbGetMapReply*, s : XkbGetMapMap*) : Int32
	fun xcb_xkb_get_map_map_serialize(_buffer : Void**, n_types : UInt8, n_key_syms : UInt8, n_key_actions : UInt8, total_actions : UInt16, total_key_behaviors : UInt8, virtual_mods : UInt16, total_key_explicit : UInt8, total_mod_map_keys : UInt8, total_v_mod_map_keys : UInt8, present : UInt16, _aux : XkbGetMapMap*) : Int32
	fun xcb_xkb_get_map_map_sizeof(_buffer : Void*, n_types : UInt8, n_key_syms : UInt8, n_key_actions : UInt8, total_actions : UInt16, total_key_behaviors : UInt8, virtual_mods : UInt16, total_key_explicit : UInt8, total_mod_map_keys : UInt8, total_v_mod_map_keys : UInt8, present : UInt16) : Int32
	fun xcb_xkb_get_map_map_syms_rtrn_iterator(r : XkbGetMapReply*, s : XkbGetMapMap*) : XkbKeySymMapIterator
	fun xcb_xkb_get_map_map_syms_rtrn_length(r : XkbGetMapReply*, s : XkbGetMapMap*) : Int32
	fun xcb_xkb_get_map_map_types_rtrn_iterator(r : XkbGetMapReply*, s : XkbGetMapMap*) : XkbKeyTypeIterator
	fun xcb_xkb_get_map_map_types_rtrn_length(r : XkbGetMapReply*, s : XkbGetMapMap*) : Int32
	fun xcb_xkb_get_map_map_unpack(_buffer : Void*, n_types : UInt8, n_key_syms : UInt8, n_key_actions : UInt8, total_actions : UInt16, total_key_behaviors : UInt8, virtual_mods : UInt16, total_key_explicit : UInt8, total_mod_map_keys : UInt8, total_v_mod_map_keys : UInt8, present : UInt16, _aux : XkbGetMapMap*) : Int32
	fun xcb_xkb_get_map_map_vmodmap_rtrn(s : XkbGetMapMap*) : XkbKeyVModMap*
		fun xcb_xkb_get_map_map_vmodmap_rtrn_iterator(r : XkbGetMapReply*, s : XkbGetMapMap*) : XkbKeyVModMapIterator
	fun xcb_xkb_get_map_map_vmodmap_rtrn_length(r : XkbGetMapReply*, s : XkbGetMapMap*) : Int32
	fun xcb_xkb_get_map_map_vmods_rtrn(s : XkbGetMapMap*) : UInt8*
		fun xcb_xkb_get_map_map_vmods_rtrn_end(r : XkbGetMapReply*, s : XkbGetMapMap*) : GenericIterator
	fun xcb_xkb_get_map_map_vmods_rtrn_length(r : XkbGetMapReply*, s : XkbGetMapMap*) : Int32
	fun xcb_xkb_get_map_reply(c : Connection, cookie : XkbGetMapCookie, e : GenericError**) : XkbGetMapReply*
		fun xcb_xkb_get_map_sizeof(_buffer : Void*) : Int32
	fun xcb_xkb_get_map_unchecked(c : Connection, device_spec : XkbDeviceSpec, full : UInt16, partial : UInt16, first_type : UInt8, n_types : UInt8, first_key_sym : Keycode, n_key_syms : UInt8, first_key_action : Keycode, n_key_actions : UInt8, first_key_behavior : Keycode, n_key_behaviors : UInt8, virtual_mods : UInt16, first_key_explicit : Keycode, n_key_explicit : UInt8, first_mod_map_key : Keycode, n_mod_map_keys : UInt8, first_v_mod_map_key : Keycode, n_v_mod_map_keys : UInt8) : XkbGetMapCookie
	fun xcb_xkb_get_named_indicator(c : Connection, device_spec : XkbDeviceSpec, led_class : XkbLedClassSpec, led_id : XkbIdSpec, indicator : Atom) : XkbGetNamedIndicatorCookie
	fun xcb_xkb_get_named_indicator_reply(c : Connection, cookie : XkbGetNamedIndicatorCookie, e : GenericError**) : XkbGetNamedIndicatorReply*
		fun xcb_xkb_get_named_indicator_unchecked(c : Connection, device_spec : XkbDeviceSpec, led_class : XkbLedClassSpec, led_id : XkbIdSpec, indicator : Atom) : XkbGetNamedIndicatorCookie
	fun xcb_xkb_get_names(c : Connection, device_spec : XkbDeviceSpec, which : UInt32) : XkbGetNamesCookie
	fun xcb_xkb_get_names_reply(c : Connection, cookie : XkbGetNamesCookie, e : GenericError**) : XkbGetNamesReply*
		fun xcb_xkb_get_names_sizeof(_buffer : Void*) : Int32
	fun xcb_xkb_get_names_unchecked(c : Connection, device_spec : XkbDeviceSpec, which : UInt32) : XkbGetNamesCookie
	fun xcb_xkb_get_names_value_list(r : XkbGetNamesReply*) : Void*
		fun xcb_xkb_get_names_value_list_groups(s : XkbGetNamesValueList*) : Atom*
		fun xcb_xkb_get_names_value_list_groups_end(r : XkbGetNamesReply*, s : XkbGetNamesValueList*) : GenericIterator
	fun xcb_xkb_get_names_value_list_groups_length(r : XkbGetNamesReply*, s : XkbGetNamesValueList*) : Int32
	fun xcb_xkb_get_names_value_list_indicator_names(s : XkbGetNamesValueList*) : Atom*
		fun xcb_xkb_get_names_value_list_indicator_names_end(r : XkbGetNamesReply*, s : XkbGetNamesValueList*) : GenericIterator
	fun xcb_xkb_get_names_value_list_indicator_names_length(r : XkbGetNamesReply*, s : XkbGetNamesValueList*) : Int32
	fun xcb_xkb_get_names_value_list_key_aliases(s : XkbGetNamesValueList*) : XkbKeyAlias*
		fun xcb_xkb_get_names_value_list_key_aliases_iterator(r : XkbGetNamesReply*, s : XkbGetNamesValueList*) : XkbKeyAliasIterator
	fun xcb_xkb_get_names_value_list_key_aliases_length(r : XkbGetNamesReply*, s : XkbGetNamesValueList*) : Int32
	fun xcb_xkb_get_names_value_list_key_names(s : XkbGetNamesValueList*) : XkbKeyName*
		fun xcb_xkb_get_names_value_list_key_names_iterator(r : XkbGetNamesReply*, s : XkbGetNamesValueList*) : XkbKeyNameIterator
	fun xcb_xkb_get_names_value_list_key_names_length(r : XkbGetNamesReply*, s : XkbGetNamesValueList*) : Int32
	fun xcb_xkb_get_names_value_list_kt_level_names(s : XkbGetNamesValueList*) : Atom*
		fun xcb_xkb_get_names_value_list_kt_level_names_end(r : XkbGetNamesReply*, s : XkbGetNamesValueList*) : GenericIterator
	fun xcb_xkb_get_names_value_list_kt_level_names_length(r : XkbGetNamesReply*, s : XkbGetNamesValueList*) : Int32
	fun xcb_xkb_get_names_value_list_n_levels_per_type(s : XkbGetNamesValueList*) : UInt8*
		fun xcb_xkb_get_names_value_list_n_levels_per_type_end(r : XkbGetNamesReply*, s : XkbGetNamesValueList*) : GenericIterator
	fun xcb_xkb_get_names_value_list_n_levels_per_type_length(r : XkbGetNamesReply*, s : XkbGetNamesValueList*) : Int32
	fun xcb_xkb_get_names_value_list_radio_group_names(s : XkbGetNamesValueList*) : Atom*
		fun xcb_xkb_get_names_value_list_radio_group_names_end(r : XkbGetNamesReply*, s : XkbGetNamesValueList*) : GenericIterator
	fun xcb_xkb_get_names_value_list_radio_group_names_length(r : XkbGetNamesReply*, s : XkbGetNamesValueList*) : Int32
	fun xcb_xkb_get_names_value_list_serialize(_buffer : Void**, n_types : UInt8, indicators : UInt32, virtual_mods : UInt16, group_names : UInt8, n_keys : UInt8, n_key_aliases : UInt8, n_radio_groups : UInt8, which : UInt32, _aux : XkbGetNamesValueList*) : Int32
	fun xcb_xkb_get_names_value_list_sizeof(_buffer : Void*, n_types : UInt8, indicators : UInt32, virtual_mods : UInt16, group_names : UInt8, n_keys : UInt8, n_key_aliases : UInt8, n_radio_groups : UInt8, which : UInt32) : Int32
	fun xcb_xkb_get_names_value_list_type_names(s : XkbGetNamesValueList*) : Atom*
		fun xcb_xkb_get_names_value_list_type_names_end(r : XkbGetNamesReply*, s : XkbGetNamesValueList*) : GenericIterator
	fun xcb_xkb_get_names_value_list_type_names_length(r : XkbGetNamesReply*, s : XkbGetNamesValueList*) : Int32
	fun xcb_xkb_get_names_value_list_unpack(_buffer : Void*, n_types : UInt8, indicators : UInt32, virtual_mods : UInt16, group_names : UInt8, n_keys : UInt8, n_key_aliases : UInt8, n_radio_groups : UInt8, which : UInt32, _aux : XkbGetNamesValueList*) : Int32
	fun xcb_xkb_get_names_value_list_virtual_mod_names(s : XkbGetNamesValueList*) : Atom*
		fun xcb_xkb_get_names_value_list_virtual_mod_names_end(r : XkbGetNamesReply*, s : XkbGetNamesValueList*) : GenericIterator
	fun xcb_xkb_get_names_value_list_virtual_mod_names_length(r : XkbGetNamesReply*, s : XkbGetNamesValueList*) : Int32
	fun xcb_xkb_get_state(c : Connection, device_spec : XkbDeviceSpec) : XkbGetStateCookie
	fun xcb_xkb_get_state_reply(c : Connection, cookie : XkbGetStateCookie, e : GenericError**) : XkbGetStateReply*
		fun xcb_xkb_get_state_unchecked(c : Connection, device_spec : XkbDeviceSpec) : XkbGetStateCookie
	fun xcb_xkb_id_spec_end(i : XkbIdSpecIterator) : GenericIterator
	fun xcb_xkb_id_spec_next(i : XkbIdSpecIterator*)
	# Return the iterator pointing to the last element
	fun xcb_xkb_indicator_map_end(i : XkbIndicatorMapIterator) : GenericIterator
	fun xcb_xkb_indicator_map_next(i : XkbIndicatorMapIterator*)
	fun xcb_xkb_key_alias_end(i : XkbKeyAliasIterator) : GenericIterator
	fun xcb_xkb_key_alias_next(i : XkbKeyAliasIterator*)
	fun xcb_xkb_key_end(i : XkbKeyIterator) : GenericIterator
	fun xcb_xkb_key_mod_map_end(i : XkbKeyModMapIterator) : GenericIterator
	fun xcb_xkb_key_mod_map_next(i : XkbKeyModMapIterator*)
	fun xcb_xkb_key_name_end(i : XkbKeyNameIterator) : GenericIterator
	fun xcb_xkb_key_name_next(i : XkbKeyNameIterator*)
	fun xcb_xkb_key_next(i : XkbKeyIterator*)
	fun xcb_xkb_key_sym_map_end(i : XkbKeySymMapIterator) : GenericIterator
	fun xcb_xkb_key_sym_map_next(i : XkbKeySymMapIterator*)
	fun xcb_xkb_key_sym_map_sizeof(_buffer : Void*) : Int32
	fun xcb_xkb_key_sym_map_syms(r : XkbKeySymMap*) : Keysym*
		fun xcb_xkb_key_sym_map_syms_end(r : XkbKeySymMap*) : GenericIterator
	fun xcb_xkb_key_sym_map_syms_length(r : XkbKeySymMap*) : Int32
	fun xcb_xkb_key_type_end(i : XkbKeyTypeIterator) : GenericIterator
	fun xcb_xkb_key_type_map(r : XkbKeyType*) : XkbKtMapEntry*
		fun xcb_xkb_key_type_map_iterator(r : XkbKeyType*) : XkbKtMapEntryIterator
	fun xcb_xkb_key_type_map_length(r : XkbKeyType*) : Int32
	fun xcb_xkb_key_type_next(i : XkbKeyTypeIterator*)
	fun xcb_xkb_key_type_preserve(r : XkbKeyType*) : XkbModDef*
		fun xcb_xkb_key_type_preserve_iterator(r : XkbKeyType*) : XkbModDefIterator
	fun xcb_xkb_key_type_preserve_length(r : XkbKeyType*) : Int32
	fun xcb_xkb_key_type_sizeof(_buffer : Void*) : Int32
	fun xcb_xkb_key_v_mod_map_end(i : XkbKeyVModMapIterator) : GenericIterator
	fun xcb_xkb_key_v_mod_map_next(i : XkbKeyVModMapIterator*)
	fun xcb_xkb_kt_map_entry_end(i : XkbKtMapEntryIterator) : GenericIterator
	fun xcb_xkb_kt_map_entry_next(i : XkbKtMapEntryIterator*)
	fun xcb_xkb_kt_set_map_entry_end(i : XkbKtSetMapEntryIterator) : GenericIterator
	fun xcb_xkb_kt_set_map_entry_next(i : XkbKtSetMapEntryIterator*)
	fun xcb_xkb_latch_lock_state(c : Connection, device_spec : XkbDeviceSpec, affect_mod_locks : UInt8, mod_locks : UInt8, lock_group : UInt8, group_lock : UInt8, affect_mod_latches : UInt8, latch_group : UInt8, group_latch : UInt16) : VoidCookie
	fun xcb_xkb_latch_lock_state_checked(c : Connection, device_spec : XkbDeviceSpec, affect_mod_locks : UInt8, mod_locks : UInt8, lock_group : UInt8, group_lock : UInt8, affect_mod_latches : UInt8, latch_group : UInt8, group_latch : UInt16) : VoidCookie
	fun xcb_xkb_led_class_spec_end(i : XkbLedClassSpecIterator) : GenericIterator
	fun xcb_xkb_led_class_spec_next(i : XkbLedClassSpecIterator*)
	fun xcb_xkb_list_components(c : Connection, device_spec : XkbDeviceSpec, max_names : UInt16) : XkbListComponentsCookie
	fun xcb_xkb_list_components_compat_maps_iterator(r : XkbListComponentsReply*) : XkbListingIterator
	fun xcb_xkb_list_components_compat_maps_length(r : XkbListComponentsReply*) : Int32
	fun xcb_xkb_list_components_geometries_iterator(r : XkbListComponentsReply*) : XkbListingIterator
	fun xcb_xkb_list_components_geometries_length(r : XkbListComponentsReply*) : Int32
	fun xcb_xkb_list_components_keycodes_iterator(r : XkbListComponentsReply*) : XkbListingIterator
	fun xcb_xkb_list_components_keycodes_length(r : XkbListComponentsReply*) : Int32
	fun xcb_xkb_list_components_keymaps_iterator(r : XkbListComponentsReply*) : XkbListingIterator
	fun xcb_xkb_list_components_keymaps_length(r : XkbListComponentsReply*) : Int32
	fun xcb_xkb_list_components_reply(c : Connection, cookie : XkbListComponentsCookie, e : GenericError**) : XkbListComponentsReply*
		fun xcb_xkb_list_components_sizeof(_buffer : Void*) : Int32
	fun xcb_xkb_list_components_symbols_iterator(r : XkbListComponentsReply*) : XkbListingIterator
	fun xcb_xkb_list_components_symbols_length(r : XkbListComponentsReply*) : Int32
	fun xcb_xkb_list_components_types_iterator(r : XkbListComponentsReply*) : XkbListingIterator
	fun xcb_xkb_list_components_types_length(r : XkbListComponentsReply*) : Int32
	fun xcb_xkb_list_components_unchecked(c : Connection, device_spec : XkbDeviceSpec, max_names : UInt16) : XkbListComponentsCookie
	fun xcb_xkb_listing_end(i : XkbListingIterator) : GenericIterator
	fun xcb_xkb_listing_next(i : XkbListingIterator*)
	fun xcb_xkb_listing_sizeof(_buffer : Void*) : Int32
	fun xcb_xkb_listing_string(r : XkbListing*) : Char*
		fun xcb_xkb_listing_string_end(r : XkbListing*) : GenericIterator
	fun xcb_xkb_listing_string_length(r : XkbListing*) : Int32
	fun xcb_xkb_lock_behavior_end(i : XkbLockBehaviorIterator) : GenericIterator
	fun xcb_xkb_lock_behavior_next(i : XkbLockBehaviorIterator*)
	fun xcb_xkb_mod_def_end(i : XkbModDefIterator) : GenericIterator
	fun xcb_xkb_mod_def_next(i : XkbModDefIterator*)
	fun xcb_xkb_outline_end(i : XkbOutlineIterator) : GenericIterator
	fun xcb_xkb_outline_next(i : XkbOutlineIterator*)
	fun xcb_xkb_outline_points(r : XkbOutline*) : Point*
		fun xcb_xkb_outline_points_iterator(r : XkbOutline*) : PointIterator
	fun xcb_xkb_outline_points_length(r : XkbOutline*) : Int32
	fun xcb_xkb_outline_sizeof(_buffer : Void*) : Int32
	fun xcb_xkb_overlay_behavior_end(i : XkbOverlayBehaviorIterator) : GenericIterator
	fun xcb_xkb_overlay_behavior_next(i : XkbOverlayBehaviorIterator*)
	fun xcb_xkb_overlay_end(i : XkbOverlayIterator) : GenericIterator
	fun xcb_xkb_overlay_key_end(i : XkbOverlayKeyIterator) : GenericIterator
	fun xcb_xkb_overlay_key_next(i : XkbOverlayKeyIterator*)
	fun xcb_xkb_overlay_next(i : XkbOverlayIterator*)
	fun xcb_xkb_overlay_row_end(i : XkbOverlayRowIterator) : GenericIterator
	fun xcb_xkb_overlay_row_keys(r : XkbOverlayRow*) : XkbOverlayKey*
		fun xcb_xkb_overlay_row_keys_iterator(r : XkbOverlayRow*) : XkbOverlayKeyIterator
	fun xcb_xkb_overlay_row_keys_length(r : XkbOverlayRow*) : Int32
	fun xcb_xkb_overlay_row_next(i : XkbOverlayRowIterator*)
	fun xcb_xkb_overlay_row_sizeof(_buffer : Void*) : Int32
	fun xcb_xkb_overlay_rows_iterator(r : XkbOverlay*) : XkbOverlayRowIterator
	fun xcb_xkb_overlay_rows_length(r : XkbOverlay*) : Int32
	fun xcb_xkb_overlay_sizeof(_buffer : Void*) : Int32
	fun xcb_xkb_per_client_flags(c : Connection, device_spec : XkbDeviceSpec, change : UInt32, value : UInt32, ctrls_to_change : UInt32, auto_ctrls : UInt32, auto_ctrls_values : UInt32) : XkbPerClientFlagsCookie
	fun xcb_xkb_per_client_flags_reply(c : Connection, cookie : XkbPerClientFlagsCookie, e : GenericError**) : XkbPerClientFlagsReply*
		fun xcb_xkb_per_client_flags_unchecked(c : Connection, device_spec : XkbDeviceSpec, change : UInt32, value : UInt32, ctrls_to_change : UInt32, auto_ctrls : UInt32, auto_ctrls_values : UInt32) : XkbPerClientFlagsCookie
	fun xcb_xkb_permament_lock_behavior_end(i : XkbPermamentLockBehaviorIterator) : GenericIterator
	fun xcb_xkb_permament_lock_behavior_next(i : XkbPermamentLockBehaviorIterator*)
	fun xcb_xkb_permament_overlay_behavior_end(i : XkbPermamentOverlayBehaviorIterator) : GenericIterator
	fun xcb_xkb_permament_overlay_behavior_next(i : XkbPermamentOverlayBehaviorIterator*)
	fun xcb_xkb_permament_radio_group_behavior_end(i : XkbPermamentRadioGroupBehaviorIterator) : GenericIterator
	fun xcb_xkb_permament_radio_group_behavior_next(i : XkbPermamentRadioGroupBehaviorIterator*)
	fun xcb_xkb_radio_group_behavior_end(i : XkbRadioGroupBehaviorIterator) : GenericIterator
	fun xcb_xkb_radio_group_behavior_next(i : XkbRadioGroupBehaviorIterator*)
	fun xcb_xkb_row_end(i : XkbRowIterator) : GenericIterator
	fun xcb_xkb_row_keys(r : XkbRow*) : XkbKey*
		fun xcb_xkb_row_keys_iterator(r : XkbRow*) : XkbKeyIterator
	fun xcb_xkb_row_keys_length(r : XkbRow*) : Int32
	fun xcb_xkb_row_next(i : XkbRowIterator*)
	fun xcb_xkb_row_sizeof(_buffer : Void*) : Int32
	fun xcb_xkb_sa_action_message_end(i : XkbSaActionMessageIterator) : GenericIterator
	fun xcb_xkb_sa_action_message_next(i : XkbSaActionMessageIterator*)
	fun xcb_xkb_sa_device_btn_end(i : XkbSaDeviceBtnIterator) : GenericIterator
	fun xcb_xkb_sa_device_btn_next(i : XkbSaDeviceBtnIterator*)
	fun xcb_xkb_sa_device_valuator_end(i : XkbSaDeviceValuatorIterator) : GenericIterator
	fun xcb_xkb_sa_device_valuator_next(i : XkbSaDeviceValuatorIterator*)
	fun xcb_xkb_sa_iso_lock_end(i : XkbSaIsoLockIterator) : GenericIterator
	fun xcb_xkb_sa_iso_lock_next(i : XkbSaIsoLockIterator*)
	fun xcb_xkb_sa_latch_group_end(i : XkbSaLatchGroupIterator) : GenericIterator
	fun xcb_xkb_sa_latch_group_next(i : XkbSaLatchGroupIterator*)
	fun xcb_xkb_sa_latch_mods_end(i : XkbSaLatchModsIterator) : GenericIterator
	fun xcb_xkb_sa_latch_mods_next(i : XkbSaLatchModsIterator*)
	fun xcb_xkb_sa_lock_controls_end(i : XkbSaLockControlsIterator) : GenericIterator
	fun xcb_xkb_sa_lock_controls_next(i : XkbSaLockControlsIterator*)
	fun xcb_xkb_sa_lock_device_btn_end(i : XkbSaLockDeviceBtnIterator) : GenericIterator
	fun xcb_xkb_sa_lock_device_btn_next(i : XkbSaLockDeviceBtnIterator*)
	fun xcb_xkb_sa_lock_group_end(i : XkbSaLockGroupIterator) : GenericIterator
	fun xcb_xkb_sa_lock_group_next(i : XkbSaLockGroupIterator*)
	fun xcb_xkb_sa_lock_mods_end(i : XkbSaLockModsIterator) : GenericIterator
	fun xcb_xkb_sa_lock_mods_next(i : XkbSaLockModsIterator*)
	fun xcb_xkb_sa_lock_ptr_btn_end(i : XkbSaLockPtrBtnIterator) : GenericIterator
	fun xcb_xkb_sa_lock_ptr_btn_next(i : XkbSaLockPtrBtnIterator*)
	fun xcb_xkb_sa_move_ptr_end(i : XkbSaMovePtrIterator) : GenericIterator
	fun xcb_xkb_sa_move_ptr_next(i : XkbSaMovePtrIterator*)
	fun xcb_xkb_sa_no_action_end(i : XkbSaNoActionIterator) : GenericIterator
	fun xcb_xkb_sa_no_action_next(i : XkbSaNoActionIterator*)
	fun xcb_xkb_sa_ptr_btn_end(i : XkbSaPtrBtnIterator) : GenericIterator
	fun xcb_xkb_sa_ptr_btn_next(i : XkbSaPtrBtnIterator*)
	fun xcb_xkb_sa_redirect_key_end(i : XkbSaRedirectKeyIterator) : GenericIterator
	fun xcb_xkb_sa_redirect_key_next(i : XkbSaRedirectKeyIterator*)
	fun xcb_xkb_sa_set_controls_end(i : XkbSaSetControlsIterator) : GenericIterator
	fun xcb_xkb_sa_set_controls_next(i : XkbSaSetControlsIterator*)
	fun xcb_xkb_sa_set_group_end(i : XkbSaSetGroupIterator) : GenericIterator
	fun xcb_xkb_sa_set_group_next(i : XkbSaSetGroupIterator*)
	fun xcb_xkb_sa_set_mods_end(i : XkbSaSetModsIterator) : GenericIterator
	fun xcb_xkb_sa_set_mods_next(i : XkbSaSetModsIterator*)
	fun xcb_xkb_sa_set_ptr_dflt_end(i : XkbSaSetPtrDfltIterator) : GenericIterator
	fun xcb_xkb_sa_set_ptr_dflt_next(i : XkbSaSetPtrDfltIterator*)
	fun xcb_xkb_sa_switch_screen_end(i : XkbSaSwitchScreenIterator) : GenericIterator
	fun xcb_xkb_sa_switch_screen_next(i : XkbSaSwitchScreenIterator*)
	fun xcb_xkb_sa_terminate_end(i : XkbSaTerminateIterator) : GenericIterator
	fun xcb_xkb_sa_terminate_next(i : XkbSaTerminateIterator*)
	fun xcb_xkb_select_events(c : Connection, device_spec : XkbDeviceSpec, affect_which : UInt16, clear : UInt16, select_all : UInt16, affect_map : UInt16, map : UInt16, details : Void*) : VoidCookie
	fun xcb_xkb_select_events_aux(c : Connection, device_spec : XkbDeviceSpec, affect_which : UInt16, clear : UInt16, select_all : UInt16, affect_map : UInt16, map : UInt16, details : XkbSelectEventsDetails*) : VoidCookie
	fun xcb_xkb_select_events_aux_checked(c : Connection, device_spec : XkbDeviceSpec, affect_which : UInt16, clear : UInt16, select_all : UInt16, affect_map : UInt16, map : UInt16, details : XkbSelectEventsDetails*) : VoidCookie
	fun xcb_xkb_select_events_checked(c : Connection, device_spec : XkbDeviceSpec, affect_which : UInt16, clear : UInt16, select_all : UInt16, affect_map : UInt16, map : UInt16, details : Void*) : VoidCookie
	fun xcb_xkb_select_events_details(r : XkbSelectEventsRequest*) : Void*
		fun xcb_xkb_select_events_details_serialize(_buffer : Void**, affect_which : UInt16, clear : UInt16, select_all : UInt16, _aux : XkbSelectEventsDetails*) : Int32
	fun xcb_xkb_select_events_details_sizeof(_buffer : Void*, affect_which : UInt16, clear : UInt16, select_all : UInt16) : Int32
	fun xcb_xkb_select_events_details_unpack(_buffer : Void*, affect_which : UInt16, clear : UInt16, select_all : UInt16, _aux : XkbSelectEventsDetails*) : Int32
	fun xcb_xkb_select_events_sizeof(_buffer : Void*) : Int32
	fun xcb_xkb_set_behavior_end(i : XkbSetBehaviorIterator) : GenericIterator
	fun xcb_xkb_set_behavior_next(i : XkbSetBehaviorIterator*)
	fun xcb_xkb_set_compat_map(c : Connection, device_spec : XkbDeviceSpec, recompute_actions : UInt8, truncate_si : UInt8, groups : UInt8, first_si : UInt16, n_si : UInt16, si : XkbSymInterpret*, group_maps : XkbModDef*) : VoidCookie
	fun xcb_xkb_set_compat_map_checked(c : Connection, device_spec : XkbDeviceSpec, recompute_actions : UInt8, truncate_si : UInt8, groups : UInt8, first_si : UInt16, n_si : UInt16, si : XkbSymInterpret*, group_maps : XkbModDef*) : VoidCookie
	fun xcb_xkb_set_compat_map_group_maps(r : XkbSetCompatMapRequest*) : XkbModDef*
		fun xcb_xkb_set_compat_map_group_maps_iterator(r : XkbSetCompatMapRequest*) : XkbModDefIterator
	fun xcb_xkb_set_compat_map_group_maps_length(r : XkbSetCompatMapRequest*) : Int32
	fun xcb_xkb_set_compat_map_si(r : XkbSetCompatMapRequest*) : XkbSymInterpret*
		fun xcb_xkb_set_compat_map_si_iterator(r : XkbSetCompatMapRequest*) : XkbSymInterpretIterator
	fun xcb_xkb_set_compat_map_si_length(r : XkbSetCompatMapRequest*) : Int32
	fun xcb_xkb_set_compat_map_sizeof(_buffer : Void*) : Int32
	fun xcb_xkb_set_controls(c : Connection, device_spec : XkbDeviceSpec, affect_internal_real_mods : UInt8, internal_real_mods : UInt8, affect_ignore_lock_real_mods : UInt8, ignore_lock_real_mods : UInt8, affect_internal_virtual_mods : UInt16, internal_virtual_mods : UInt16, affect_ignore_lock_virtual_mods : UInt16, ignore_lock_virtual_mods : UInt16, mouse_keys_dflt_btn : UInt8, groups_wrap : UInt8, access_x_options : UInt16, affect_enabled_controls : UInt32, enabled_controls : UInt32, change_controls : UInt32, repeat_delay : UInt16, repeat_interval : UInt16, slow_keys_delay : UInt16, debounce_delay : UInt16, mouse_keys_delay : UInt16, mouse_keys_interval : UInt16, mouse_keys_time_to_max : UInt16, mouse_keys_max_speed : UInt16, mouse_keys_curve : Int16, access_x_timeout : UInt16, access_x_timeout_mask : UInt32, access_x_timeout_values : UInt32, access_x_timeout_options_mask : UInt16, access_x_timeout_options_values : UInt16, per_key_repeat : UInt8*) : VoidCookie
	fun xcb_xkb_set_controls_checked(c : Connection, device_spec : XkbDeviceSpec, affect_internal_real_mods : UInt8, internal_real_mods : UInt8, affect_ignore_lock_real_mods : UInt8, ignore_lock_real_mods : UInt8, affect_internal_virtual_mods : UInt16, internal_virtual_mods : UInt16, affect_ignore_lock_virtual_mods : UInt16, ignore_lock_virtual_mods : UInt16, mouse_keys_dflt_btn : UInt8, groups_wrap : UInt8, access_x_options : UInt16, affect_enabled_controls : UInt32, enabled_controls : UInt32, change_controls : UInt32, repeat_delay : UInt16, repeat_interval : UInt16, slow_keys_delay : UInt16, debounce_delay : UInt16, mouse_keys_delay : UInt16, mouse_keys_interval : UInt16, mouse_keys_time_to_max : UInt16, mouse_keys_max_speed : UInt16, mouse_keys_curve : Int16, access_x_timeout : UInt16, access_x_timeout_mask : UInt32, access_x_timeout_values : UInt32, access_x_timeout_options_mask : UInt16, access_x_timeout_options_values : UInt16, per_key_repeat : UInt8*) : VoidCookie
	fun xcb_xkb_set_debugging_flags(c : Connection, msg_length : UInt16, affect_flags : UInt32, flags : UInt32, affect_ctrls : UInt32, ctrls : UInt32, message : Char*) : XkbSetDebuggingFlagsCookie
	fun xcb_xkb_set_debugging_flags_reply(c : Connection, cookie : XkbSetDebuggingFlagsCookie, e : GenericError**) : XkbSetDebuggingFlagsReply*
		fun xcb_xkb_set_debugging_flags_sizeof(_buffer : Void*) : Int32
	fun xcb_xkb_set_debugging_flags_unchecked(c : Connection, msg_length : UInt16, affect_flags : UInt32, flags : UInt32, affect_ctrls : UInt32, ctrls : UInt32, message : Char*) : XkbSetDebuggingFlagsCookie
	fun xcb_xkb_set_device_info(c : Connection, device_spec : XkbDeviceSpec, first_btn : UInt8, n_btns : UInt8, change : UInt16, n_device_led_f_bs : UInt16, btn_actions : XkbAction*, leds : XkbDeviceLedInfo*) : VoidCookie
	fun xcb_xkb_set_device_info_btn_actions(r : XkbSetDeviceInfoRequest*) : XkbAction*
		fun xcb_xkb_set_device_info_btn_actions_iterator(r : XkbSetDeviceInfoRequest*) : XkbActionIterator
	fun xcb_xkb_set_device_info_btn_actions_length(r : XkbSetDeviceInfoRequest*) : Int32
	fun xcb_xkb_set_device_info_checked(c : Connection, device_spec : XkbDeviceSpec, first_btn : UInt8, n_btns : UInt8, change : UInt16, n_device_led_f_bs : UInt16, btn_actions : XkbAction*, leds : XkbDeviceLedInfo*) : VoidCookie
	fun xcb_xkb_set_device_info_leds_iterator(r : XkbSetDeviceInfoRequest*) : XkbDeviceLedInfoIterator
	fun xcb_xkb_set_device_info_leds_length(r : XkbSetDeviceInfoRequest*) : Int32
	fun xcb_xkb_set_device_info_sizeof(_buffer : Void*) : Int32
	fun xcb_xkb_set_explicit_end(i : XkbSetExplicitIterator) : GenericIterator
	fun xcb_xkb_set_explicit_next(i : XkbSetExplicitIterator*)
	fun xcb_xkb_set_indicator_map(c : Connection, device_spec : XkbDeviceSpec, which : UInt32, maps : XkbIndicatorMap*) : VoidCookie
	fun xcb_xkb_set_indicator_map_checked(c : Connection, device_spec : XkbDeviceSpec, which : UInt32, maps : XkbIndicatorMap*) : VoidCookie
	fun xcb_xkb_set_indicator_map_maps(r : XkbSetIndicatorMapRequest*) : XkbIndicatorMap*
		fun xcb_xkb_set_indicator_map_maps_iterator(r : XkbSetIndicatorMapRequest*) : XkbIndicatorMapIterator
	fun xcb_xkb_set_indicator_map_maps_length(r : XkbSetIndicatorMapRequest*) : Int32
	fun xcb_xkb_set_indicator_map_sizeof(_buffer : Void*) : Int32
	fun xcb_xkb_set_key_type_end(i : XkbSetKeyTypeIterator) : GenericIterator
	fun xcb_xkb_set_key_type_entries(r : XkbSetKeyType*) : XkbKtSetMapEntry*
		fun xcb_xkb_set_key_type_entries_iterator(r : XkbSetKeyType*) : XkbKtSetMapEntryIterator
	fun xcb_xkb_set_key_type_entries_length(r : XkbSetKeyType*) : Int32
	fun xcb_xkb_set_key_type_next(i : XkbSetKeyTypeIterator*)
	fun xcb_xkb_set_key_type_preserve_entries(r : XkbSetKeyType*) : XkbKtSetMapEntry*
		fun xcb_xkb_set_key_type_preserve_entries_iterator(r : XkbSetKeyType*) : XkbKtSetMapEntryIterator
	fun xcb_xkb_set_key_type_preserve_entries_length(r : XkbSetKeyType*) : Int32
	fun xcb_xkb_set_key_type_sizeof(_buffer : Void*) : Int32
	fun xcb_xkb_set_map(c : Connection, device_spec : XkbDeviceSpec, present : UInt16, flags : UInt16, min_key_code : Keycode, max_key_code : Keycode, first_type : UInt8, n_types : UInt8, first_key_sym : Keycode, n_key_syms : UInt8, total_syms : UInt16, first_key_action : Keycode, n_key_actions : UInt8, total_actions : UInt16, first_key_behavior : Keycode, n_key_behaviors : UInt8, total_key_behaviors : UInt8, first_key_explicit : Keycode, n_key_explicit : UInt8, total_key_explicit : UInt8, first_mod_map_key : Keycode, n_mod_map_keys : UInt8, total_mod_map_keys : UInt8, first_v_mod_map_key : Keycode, n_v_mod_map_keys : UInt8, total_v_mod_map_keys : UInt8, virtual_mods : UInt16, values : Void*) : VoidCookie
	fun xcb_xkb_set_map_aux(c : Connection, device_spec : XkbDeviceSpec, present : UInt16, flags : UInt16, min_key_code : Keycode, max_key_code : Keycode, first_type : UInt8, n_types : UInt8, first_key_sym : Keycode, n_key_syms : UInt8, total_syms : UInt16, first_key_action : Keycode, n_key_actions : UInt8, total_actions : UInt16, first_key_behavior : Keycode, n_key_behaviors : UInt8, total_key_behaviors : UInt8, first_key_explicit : Keycode, n_key_explicit : UInt8, total_key_explicit : UInt8, first_mod_map_key : Keycode, n_mod_map_keys : UInt8, total_mod_map_keys : UInt8, first_v_mod_map_key : Keycode, n_v_mod_map_keys : UInt8, total_v_mod_map_keys : UInt8, virtual_mods : UInt16, values : XkbSetMapValues*) : VoidCookie
	fun xcb_xkb_set_map_aux_checked(c : Connection, device_spec : XkbDeviceSpec, present : UInt16, flags : UInt16, min_key_code : Keycode, max_key_code : Keycode, first_type : UInt8, n_types : UInt8, first_key_sym : Keycode, n_key_syms : UInt8, total_syms : UInt16, first_key_action : Keycode, n_key_actions : UInt8, total_actions : UInt16, first_key_behavior : Keycode, n_key_behaviors : UInt8, total_key_behaviors : UInt8, first_key_explicit : Keycode, n_key_explicit : UInt8, total_key_explicit : UInt8, first_mod_map_key : Keycode, n_mod_map_keys : UInt8, total_mod_map_keys : UInt8, first_v_mod_map_key : Keycode, n_v_mod_map_keys : UInt8, total_v_mod_map_keys : UInt8, virtual_mods : UInt16, values : XkbSetMapValues*) : VoidCookie
	fun xcb_xkb_set_map_checked(c : Connection, device_spec : XkbDeviceSpec, present : UInt16, flags : UInt16, min_key_code : Keycode, max_key_code : Keycode, first_type : UInt8, n_types : UInt8, first_key_sym : Keycode, n_key_syms : UInt8, total_syms : UInt16, first_key_action : Keycode, n_key_actions : UInt8, total_actions : UInt16, first_key_behavior : Keycode, n_key_behaviors : UInt8, total_key_behaviors : UInt8, first_key_explicit : Keycode, n_key_explicit : UInt8, total_key_explicit : UInt8, first_mod_map_key : Keycode, n_mod_map_keys : UInt8, total_mod_map_keys : UInt8, first_v_mod_map_key : Keycode, n_v_mod_map_keys : UInt8, total_v_mod_map_keys : UInt8, virtual_mods : UInt16, values : Void*) : VoidCookie
	fun xcb_xkb_set_map_sizeof(_buffer : Void*) : Int32
	fun xcb_xkb_set_map_values(r : XkbSetMapRequest*) : Void*
		fun xcb_xkb_set_map_values_actions(s : XkbSetMapValues*) : XkbAction*
		fun xcb_xkb_set_map_values_actions_count(s : XkbSetMapValues*) : UInt8*
		fun xcb_xkb_set_map_values_actions_count_end(r : XkbSetMapRequest*, s : XkbSetMapValues*) : GenericIterator
	fun xcb_xkb_set_map_values_actions_count_length(r : XkbSetMapRequest*, s : XkbSetMapValues*) : Int32
	fun xcb_xkb_set_map_values_actions_iterator(r : XkbSetMapRequest*, s : XkbSetMapValues*) : XkbActionIterator
	fun xcb_xkb_set_map_values_actions_length(r : XkbSetMapRequest*, s : XkbSetMapValues*) : Int32
	fun xcb_xkb_set_map_values_behaviors(s : XkbSetMapValues*) : XkbSetBehavior*
		fun xcb_xkb_set_map_values_behaviors_iterator(r : XkbSetMapRequest*, s : XkbSetMapValues*) : XkbSetBehaviorIterator
	fun xcb_xkb_set_map_values_behaviors_length(r : XkbSetMapRequest*, s : XkbSetMapValues*) : Int32
	fun xcb_xkb_set_map_values_explicit(s : XkbSetMapValues*) : XkbSetExplicit*
		fun xcb_xkb_set_map_values_explicit_iterator(r : XkbSetMapRequest*, s : XkbSetMapValues*) : XkbSetExplicitIterator
	fun xcb_xkb_set_map_values_explicit_length(r : XkbSetMapRequest*, s : XkbSetMapValues*) : Int32
	fun xcb_xkb_set_map_values_modmap(s : XkbSetMapValues*) : XkbKeyModMap*
		fun xcb_xkb_set_map_values_modmap_iterator(r : XkbSetMapRequest*, s : XkbSetMapValues*) : XkbKeyModMapIterator
	fun xcb_xkb_set_map_values_modmap_length(r : XkbSetMapRequest*, s : XkbSetMapValues*) : Int32
	fun xcb_xkb_set_map_values_serialize(_buffer : Void**, n_types : UInt8, n_key_syms : UInt8, n_key_actions : UInt8, total_actions : UInt16, total_key_behaviors : UInt8, virtual_mods : UInt16, total_key_explicit : UInt8, total_mod_map_keys : UInt8, total_v_mod_map_keys : UInt8, present : UInt16, _aux : XkbSetMapValues*) : Int32
	fun xcb_xkb_set_map_values_sizeof(_buffer : Void*, n_types : UInt8, n_key_syms : UInt8, n_key_actions : UInt8, total_actions : UInt16, total_key_behaviors : UInt8, virtual_mods : UInt16, total_key_explicit : UInt8, total_mod_map_keys : UInt8, total_v_mod_map_keys : UInt8, present : UInt16) : Int32
	fun xcb_xkb_set_map_values_syms_iterator(r : XkbSetMapRequest*, s : XkbSetMapValues*) : XkbKeySymMapIterator
	fun xcb_xkb_set_map_values_syms_length(r : XkbSetMapRequest*, s : XkbSetMapValues*) : Int32
	fun xcb_xkb_set_map_values_types_iterator(r : XkbSetMapRequest*, s : XkbSetMapValues*) : XkbSetKeyTypeIterator
	fun xcb_xkb_set_map_values_types_length(r : XkbSetMapRequest*, s : XkbSetMapValues*) : Int32
	fun xcb_xkb_set_map_values_unpack(_buffer : Void*, n_types : UInt8, n_key_syms : UInt8, n_key_actions : UInt8, total_actions : UInt16, total_key_behaviors : UInt8, virtual_mods : UInt16, total_key_explicit : UInt8, total_mod_map_keys : UInt8, total_v_mod_map_keys : UInt8, present : UInt16, _aux : XkbSetMapValues*) : Int32
	fun xcb_xkb_set_map_values_vmodmap(s : XkbSetMapValues*) : XkbKeyVModMap*
		fun xcb_xkb_set_map_values_vmodmap_iterator(r : XkbSetMapRequest*, s : XkbSetMapValues*) : XkbKeyVModMapIterator
	fun xcb_xkb_set_map_values_vmodmap_length(r : XkbSetMapRequest*, s : XkbSetMapValues*) : Int32
	fun xcb_xkb_set_map_values_vmods(s : XkbSetMapValues*) : UInt8*
		fun xcb_xkb_set_map_values_vmods_end(r : XkbSetMapRequest*, s : XkbSetMapValues*) : GenericIterator
	fun xcb_xkb_set_map_values_vmods_length(r : XkbSetMapRequest*, s : XkbSetMapValues*) : Int32
	# Returns A cookie
	fun xcb_xkb_set_named_indicator(c : Connection, device_spec : XkbDeviceSpec, led_class : XkbLedClassSpec, led_id : XkbIdSpec, indicator : Atom, set_state : UInt8, on : UInt8, set_map : UInt8, create_map : UInt8, map_flags : UInt8, map_which_groups : UInt8, map_groups : UInt8, map_which_mods : UInt8, map_real_mods : UInt8, map_vmods : UInt16, map_ctrls : UInt32) : VoidCookie
	fun xcb_xkb_set_named_indicator_checked(c : Connection, device_spec : XkbDeviceSpec, led_class : XkbLedClassSpec, led_id : XkbIdSpec, indicator : Atom, set_state : UInt8, on : UInt8, set_map : UInt8, create_map : UInt8, map_flags : UInt8, map_which_groups : UInt8, map_groups : UInt8, map_which_mods : UInt8, map_real_mods : UInt8, map_vmods : UInt16, map_ctrls : UInt32) : VoidCookie
	fun xcb_xkb_set_names(c : Connection, device_spec : XkbDeviceSpec, virtual_mods : UInt16, which : UInt32, first_type : UInt8, n_types : UInt8, first_kt_levelt : UInt8, n_kt_levels : UInt8, indicators : UInt32, group_names : UInt8, n_radio_groups : UInt8, first_key : Keycode, n_keys : UInt8, n_key_aliases : UInt8, total_kt_level_names : UInt16, values : Void*) : VoidCookie
	fun xcb_xkb_set_names_aux(c : Connection, device_spec : XkbDeviceSpec, virtual_mods : UInt16, which : UInt32, first_type : UInt8, n_types : UInt8, first_kt_levelt : UInt8, n_kt_levels : UInt8, indicators : UInt32, group_names : UInt8, n_radio_groups : UInt8, first_key : Keycode, n_keys : UInt8, n_key_aliases : UInt8, total_kt_level_names : UInt16, values : XkbSetNamesValues*) : VoidCookie
	fun xcb_xkb_set_names_aux_checked(c : Connection, device_spec : XkbDeviceSpec, virtual_mods : UInt16, which : UInt32, first_type : UInt8, n_types : UInt8, first_kt_levelt : UInt8, n_kt_levels : UInt8, indicators : UInt32, group_names : UInt8, n_radio_groups : UInt8, first_key : Keycode, n_keys : UInt8, n_key_aliases : UInt8, total_kt_level_names : UInt16, values : XkbSetNamesValues*) : VoidCookie
	fun xcb_xkb_set_names_checked(c : Connection, device_spec : XkbDeviceSpec, virtual_mods : UInt16, which : UInt32, first_type : UInt8, n_types : UInt8, first_kt_levelt : UInt8, n_kt_levels : UInt8, indicators : UInt32, group_names : UInt8, n_radio_groups : UInt8, first_key : Keycode, n_keys : UInt8, n_key_aliases : UInt8, total_kt_level_names : UInt16, values : Void*) : VoidCookie
	fun xcb_xkb_set_names_sizeof(_buffer : Void*) : Int32
	fun xcb_xkb_set_names_values(r : XkbSetNamesRequest*) : Void*
		fun xcb_xkb_set_names_values_groups(s : XkbSetNamesValues*) : Atom*
		fun xcb_xkb_set_names_values_groups_end(r : XkbSetNamesRequest*, s : XkbSetNamesValues*) : GenericIterator
	fun xcb_xkb_set_names_values_groups_length(r : XkbSetNamesRequest*, s : XkbSetNamesValues*) : Int32
	fun xcb_xkb_set_names_values_indicator_names(s : XkbSetNamesValues*) : Atom*
		fun xcb_xkb_set_names_values_indicator_names_end(r : XkbSetNamesRequest*, s : XkbSetNamesValues*) : GenericIterator
	fun xcb_xkb_set_names_values_indicator_names_length(r : XkbSetNamesRequest*, s : XkbSetNamesValues*) : Int32
	fun xcb_xkb_set_names_values_key_aliases(s : XkbSetNamesValues*) : XkbKeyAlias*
		fun xcb_xkb_set_names_values_key_aliases_iterator(r : XkbSetNamesRequest*, s : XkbSetNamesValues*) : XkbKeyAliasIterator
	fun xcb_xkb_set_names_values_key_aliases_length(r : XkbSetNamesRequest*, s : XkbSetNamesValues*) : Int32
	fun xcb_xkb_set_names_values_key_names(s : XkbSetNamesValues*) : XkbKeyName*
		fun xcb_xkb_set_names_values_key_names_iterator(r : XkbSetNamesRequest*, s : XkbSetNamesValues*) : XkbKeyNameIterator
	fun xcb_xkb_set_names_values_key_names_length(r : XkbSetNamesRequest*, s : XkbSetNamesValues*) : Int32
	fun xcb_xkb_set_names_values_kt_level_names(s : XkbSetNamesValues*) : Atom*
		fun xcb_xkb_set_names_values_kt_level_names_end(r : XkbSetNamesRequest*, s : XkbSetNamesValues*) : GenericIterator
	fun xcb_xkb_set_names_values_kt_level_names_length(r : XkbSetNamesRequest*, s : XkbSetNamesValues*) : Int32
	fun xcb_xkb_set_names_values_n_levels_per_type(s : XkbSetNamesValues*) : UInt8*
		fun xcb_xkb_set_names_values_n_levels_per_type_end(r : XkbSetNamesRequest*, s : XkbSetNamesValues*) : GenericIterator
	fun xcb_xkb_set_names_values_n_levels_per_type_length(r : XkbSetNamesRequest*, s : XkbSetNamesValues*) : Int32
	fun xcb_xkb_set_names_values_radio_group_names(s : XkbSetNamesValues*) : Atom*
		fun xcb_xkb_set_names_values_radio_group_names_end(r : XkbSetNamesRequest*, s : XkbSetNamesValues*) : GenericIterator
	fun xcb_xkb_set_names_values_radio_group_names_length(r : XkbSetNamesRequest*, s : XkbSetNamesValues*) : Int32
	fun xcb_xkb_set_names_values_serialize(_buffer : Void**, n_types : UInt8, indicators : UInt32, virtual_mods : UInt16, group_names : UInt8, n_keys : UInt8, n_key_aliases : UInt8, n_radio_groups : UInt8, which : UInt32, _aux : XkbSetNamesValues*) : Int32
	fun xcb_xkb_set_names_values_sizeof(_buffer : Void*, n_types : UInt8, indicators : UInt32, virtual_mods : UInt16, group_names : UInt8, n_keys : UInt8, n_key_aliases : UInt8, n_radio_groups : UInt8, which : UInt32) : Int32
	fun xcb_xkb_set_names_values_type_names(s : XkbSetNamesValues*) : Atom*
		fun xcb_xkb_set_names_values_type_names_end(r : XkbSetNamesRequest*, s : XkbSetNamesValues*) : GenericIterator
	fun xcb_xkb_set_names_values_type_names_length(r : XkbSetNamesRequest*, s : XkbSetNamesValues*) : Int32
	fun xcb_xkb_set_names_values_unpack(_buffer : Void*, n_types : UInt8, indicators : UInt32, virtual_mods : UInt16, group_names : UInt8, n_keys : UInt8, n_key_aliases : UInt8, n_radio_groups : UInt8, which : UInt32, _aux : XkbSetNamesValues*) : Int32
	fun xcb_xkb_set_names_values_virtual_mod_names(s : XkbSetNamesValues*) : Atom*
		fun xcb_xkb_set_names_values_virtual_mod_names_end(r : XkbSetNamesRequest*, s : XkbSetNamesValues*) : GenericIterator
	fun xcb_xkb_set_names_values_virtual_mod_names_length(r : XkbSetNamesRequest*, s : XkbSetNamesValues*) : Int32
	fun xcb_xkb_shape_end(i : XkbShapeIterator) : GenericIterator
	fun xcb_xkb_shape_next(i : XkbShapeIterator*)
	fun xcb_xkb_shape_outlines_iterator(r : XkbShape*) : XkbOutlineIterator
	fun xcb_xkb_shape_outlines_length(r : XkbShape*) : Int32
	fun xcb_xkb_shape_sizeof(_buffer : Void*) : Int32
	fun xcb_xkb_si_action_end(i : XkbSiActionIterator) : GenericIterator
	fun xcb_xkb_si_action_next(i : XkbSiActionIterator*)
	fun xcb_xkb_string8_end(i : CharIterator) : GenericIterator
	fun xcb_xkb_string8_next(i : CharIterator*)
	fun xcb_xkb_sym_interpret_end(i : XkbSymInterpretIterator) : GenericIterator
	fun xcb_xkb_sym_interpret_next(i : XkbSymInterpretIterator*)
	fun xcb_xkb_use_extension(c : Connection, wanted_major : UInt16, wanted_minor : UInt16) : XkbUseExtensionCookie
	fun xcb_xkb_use_extension_reply(c : Connection, cookie : XkbUseExtensionCookie, e : GenericError**) : XkbUseExtensionReply*
		fun xcb_xkb_use_extension_unchecked(c : Connection, wanted_major : UInt16, wanted_minor : UInt16) : XkbUseExtensionCookie
end
