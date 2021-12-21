@[Link("xcb")]
lib LibXCB
	struct RandrAddOutputModeRequest
		major_opcode : UInt8
		minor_opcode : UInt8
		length : UInt16
		output : RandrOutput
		mode : RandrMode
	end

	struct RandrBadCrtcError
		response_type : UInt8
		error_code : UInt8
		sequence : UInt16
	end

	struct RandrBadModeError
		response_type : UInt8
		error_code : UInt8
		sequence : UInt16
	end

	struct RandrBadOutputError
		response_type : UInt8
		error_code : UInt8
		sequence : UInt16
	end

	struct RandrBadProviderError
		response_type : UInt8
		error_code : UInt8
		sequence : UInt16
	end

	struct RandrChangeOutputPropertyRequest
		major_opcode : UInt8
		minor_opcode : UInt8
		length : UInt16
		output : RandrOutput
		property : Atom
		type : Atom
		format : UInt8
		mode : UInt8
		pad0 : StaticArray(UInt8, 2)
		num_units : UInt32
	end

	struct RandrChangeProviderPropertyRequest
		major_opcode : UInt8
		minor_opcode : UInt8
		length : UInt16
		provider : RandrProvider
		property : Atom
		type : Atom
		format : UInt8
		mode : UInt8
		pad0 : StaticArray(UInt8, 2)
		num_items : UInt32
	end

	struct RandrConfigureOutputPropertyRequest
		major_opcode : UInt8
		minor_opcode : UInt8
		length : UInt16
		output : RandrOutput
		property : Atom
		pending : UInt8
		range : UInt8
		pad0 : StaticArray(UInt8, 2)
	end

	struct RandrConfigureProviderPropertyRequest
		major_opcode : UInt8
		minor_opcode : UInt8
		length : UInt16
		provider : RandrProvider
		property : Atom
		pending : UInt8
		range : UInt8
		pad0 : StaticArray(UInt8, 2)
	end

	struct RandrCreateLeaseCookie
		sequence : UInt32
	end

	struct RandrCreateLeaseReply
		response_type : UInt8
		nfd : UInt8
		sequence : UInt16
		length : UInt32
		pad0 : StaticArray(UInt8, 24)
	end

	struct RandrCreateLeaseRequest
		major_opcode : UInt8
		minor_opcode : UInt8
		length : UInt16
		window : Window
		lid : RandrLease
		num_crtcs : UInt16
		num_outputs : UInt16
	end

	struct RandrCreateModeCookie
		sequence : UInt32
	end

	struct RandrCreateModeReply
		response_type : UInt8
		pad0 : UInt8
		sequence : UInt16
		length : UInt32
		mode : RandrMode
		pad1 : StaticArray(UInt8, 20)
	end

	struct RandrCreateModeRequest
		major_opcode : UInt8
		minor_opcode : UInt8
		length : UInt16
		window : Window
		mode_info : RandrModeInfo
	end

	struct RandrCrtcChangeIterator
		data : RandrCrtcChange*
		rem : Int32
		index : Int32
	end

	struct RandrCrtcChange
		timestamp : Timestamp
		window : Window
		crtc : RandrCrtc
		mode : RandrMode
		rotation : UInt16
		pad0 : StaticArray(UInt8, 2)
		x : Int16
		y : Int16
		width : UInt16
		height : UInt16
	end

	struct RandrCrtcIterator
		data : RandrCrtc*
		rem : Int32
		index : Int32
	end

	struct RandrDeleteMonitorRequest
		major_opcode : UInt8
		minor_opcode : UInt8
		length : UInt16
		window : Window
		name : Atom
	end

	struct RandrDeleteOutputModeRequest
		major_opcode : UInt8
		minor_opcode : UInt8
		length : UInt16
		output : RandrOutput
		mode : RandrMode
	end

	struct RandrDeleteOutputPropertyRequest
		major_opcode : UInt8
		minor_opcode : UInt8
		length : UInt16
		output : RandrOutput
		property : Atom
	end

	struct RandrDeleteProviderPropertyRequest
		major_opcode : UInt8
		minor_opcode : UInt8
		length : UInt16
		provider : RandrProvider
		property : Atom
	end

	struct RandrDestroyModeRequest
		major_opcode : UInt8
		minor_opcode : UInt8
		length : UInt16
		mode : RandrMode
	end

	struct RandrFreeLeaseRequest
		major_opcode : UInt8
		minor_opcode : UInt8
		length : UInt16
		lid : RandrLease
		terminate : UInt8
	end

	struct RandrGetCrtcGammaCookie
		sequence : UInt32
	end

	struct RandrGetCrtcGammaReply
		response_type : UInt8
		pad0 : UInt8
		sequence : UInt16
		length : UInt32
		size : UInt16
		pad1 : StaticArray(UInt8, 22)
	end

	struct RandrGetCrtcGammaRequest
		major_opcode : UInt8
		minor_opcode : UInt8
		length : UInt16
		crtc : RandrCrtc
	end

	struct RandrGetCrtcGammaSizeCookie
		sequence : UInt32
	end

	struct RandrGetCrtcGammaSizeReply
		response_type : UInt8
		pad0 : UInt8
		sequence : UInt16
		length : UInt32
		size : UInt16
		pad1 : StaticArray(UInt8, 22)
	end

	struct RandrGetCrtcGammaSizeRequest
		major_opcode : UInt8
		minor_opcode : UInt8
		length : UInt16
		crtc : RandrCrtc
	end

	struct RandrGetCrtcInfoCookie
		sequence : UInt32
	end

	struct RandrGetCrtcInfoReply
		response_type : UInt8
		status : UInt8
		sequence : UInt16
		length : UInt32
		timestamp : Timestamp
		x : Int16
		y : Int16
		width : UInt16
		height : UInt16
		mode : RandrMode
		rotation : UInt16
		rotations : UInt16
		num_outputs : UInt16
		num_possible_outputs : UInt16
	end

	struct RandrGetCrtcInfoRequest
		major_opcode : UInt8
		minor_opcode : UInt8
		length : UInt16
		crtc : RandrCrtc
		config_timestamp : Timestamp
	end

	struct RandrGetCrtcransformCookie
		sequence : UInt32
	end

	struct RandrGetCrtcransformReply
		response_type : UInt8
		pad0 : UInt8
		sequence : UInt16
		length : UInt32
		pending_transform : RenderTransform
		has_transforms : UInt8
		pad1 : StaticArray(UInt8, 3)
		current_transform : RenderTransform
		pad2 : StaticArray(UInt8, 4)
		pending_len : UInt16
		pending_nparams : UInt16
		current_len : UInt16
		current_nparams : UInt16
	end

	struct RandrGetCrtcransformRequest
		major_opcode : UInt8
		minor_opcode : UInt8
		length : UInt16
		crtc : RandrCrtc
	end

	struct RandrGetMonitorsCookie
		sequence : UInt32
	end

	struct RandrGetMonitorsReply
		response_type : UInt8
		pad0 : UInt8
		sequence : UInt16
		length : UInt32
		timestamp : Timestamp
		n_monitors : UInt32
		n_outputs : UInt32
		pad1 : StaticArray(UInt8, 12)
	end

	struct RandrGetMonitorsRequest
		major_opcode : UInt8
		minor_opcode : UInt8
		length : UInt16
		window : Window
		get_active : UInt8
	end

	struct RandrGetOutputInfoCookie
		sequence : UInt32
	end

	struct RandrGetOutputInfoReply
		response_type : UInt8
		status : UInt8
		sequence : UInt16
		length : UInt32
		timestamp : Timestamp
		crtc : RandrCrtc
		mm_width : UInt32
		mm_height : UInt32
		connection : UInt8
		subpixel_order : UInt8
		num_crtcs : UInt16
		num_modes : UInt16
		num_preferred : UInt16
		num_clones : UInt16
		name_len : UInt16
	end

	struct RandrGetOutputInfoRequest
		major_opcode : UInt8
		minor_opcode : UInt8
		length : UInt16
		output : RandrOutput
		config_timestamp : Timestamp
	end

	struct RandrGetOutputPrimaryCookie
		sequence : UInt32
	end

	struct RandrGetOutputPrimaryReply
		response_type : UInt8
		pad0 : UInt8
		sequence : UInt16
		length : UInt32
		output : RandrOutput
	end

	struct RandrGetOutputPrimaryRequest
		major_opcode : UInt8
		minor_opcode : UInt8
		length : UInt16
		window : Window
	end

	struct RandrGetOutputPropertyCookie
		sequence : UInt32
	end

	struct RandrGetOutputPropertyReply
		response_type : UInt8
		format : UInt8
		sequence : UInt16
		length : UInt32
		type : Atom
		bytes_after : UInt32
		num_items : UInt32
		pad0 : StaticArray(UInt8, 12)
	end

	struct RandrGetOutputPropertyRequest
		major_opcode : UInt8
		minor_opcode : UInt8
		length : UInt16
		output : RandrOutput
		property : Atom
		type : Atom
		long_offset : UInt32
		long_length : UInt32
		_delete : UInt8
		pending : UInt8
		pad0 : StaticArray(UInt8, 2)
	end

	struct RandrGetPanningCookie
		sequence : UInt32
	end

	struct RandrGetPanningReply
		response_type : UInt8
		status : UInt8
		sequence : UInt16
		length : UInt32
		timestamp : Timestamp
		left : UInt16
		top : UInt16
		width : UInt16
		height : UInt16
		track_left : UInt16
		track_top : UInt16
		track_width : UInt16
		track_height : UInt16
		border_left : Int16
		border_top : Int16
		border_right : Int16
		border_bottom : Int16
	end

	struct RandrGetPanningRequest
		major_opcode : UInt8
		minor_opcode : UInt8
		length : UInt16
		crtc : RandrCrtc
	end

	struct RandrGetProviderInfoCookie
		sequence : UInt32
	end

	struct RandrGetProviderInfoReply
		response_type : UInt8
		status : UInt8
		sequence : UInt16
		length : UInt32
		timestamp : Timestamp
		capabilities : UInt32
		num_crtcs : UInt16
		num_outputs : UInt16
		num_associated_providers : UInt16
		name_len : UInt16
		pad0 : StaticArray(UInt8, 8)
	end

	struct RandrGetProviderInfoRequest
		major_opcode : UInt8
		minor_opcode : UInt8
		length : UInt16
		provider : RandrProvider
		config_timestamp : Timestamp
	end

	struct RandrGetProviderPropertyCookie
		sequence : UInt32
	end

	struct RandrGetProviderPropertyReply
		response_type : UInt8
		format : UInt8
		sequence : UInt16
		length : UInt32
		type : Atom
		bytes_after : UInt32
		num_items : UInt32
		pad0 : StaticArray(UInt8, 12)
	end

	struct RandrGetProviderPropertyRequest
		major_opcode : UInt8
		minor_opcode : UInt8
		length : UInt16
		provider : RandrProvider
		property : Atom
		type : Atom
		long_offset : UInt32
		long_length : UInt32
		_delete : UInt8
		pending : UInt8
		pad0 : StaticArray(UInt8, 2)
	end

	struct RandrGetProvidersCookie
		sequence : UInt32
	end

	struct RandrGetProvidersReply
		response_type : UInt8
		pad0 : UInt8
		sequence : UInt16
		length : UInt32
		timestamp : Timestamp
		num_providers : UInt16
		pad1 : StaticArray(UInt8, 18)
	end

	struct RandrGetProvidersRequest
		major_opcode : UInt8
		minor_opcode : UInt8
		length : UInt16
		window : Window
	end

	struct RandrGetScreenInfoCookie
		sequence : UInt32
	end

	struct RandrGetScreenInfoReply
		response_type : UInt8
		rotations : UInt8
		sequence : UInt16
		length : UInt32
		root : Window
		timestamp : Timestamp
		config_timestamp : Timestamp
		n_sizes : UInt16
		size_id : UInt16
		rotation : UInt16
		rate : UInt16
		n_info : UInt16
		pad0 : StaticArray(UInt8, 2)
	end

	struct RandrGetScreenInfoRequest
		major_opcode : UInt8
		minor_opcode : UInt8
		length : UInt16
		window : Window
	end

	struct RandrGetScreenResourcesCookie
		sequence : UInt32
	end

	struct RandrGetScreenResourcesCurrentCookie
		sequence : UInt32
	end

	struct RandrGetScreenResourcesCurrentReply
		response_type : UInt8
		pad0 : UInt8
		sequence : UInt16
		length : UInt32
		timestamp : Timestamp
		config_timestamp : Timestamp
		num_crtcs : UInt16
		num_outputs : UInt16
		num_modes : UInt16
		names_len : UInt16
		pad1 : StaticArray(UInt8, 8)
	end

	struct RandrGetScreenResourcesCurrentRequest
		major_opcode : UInt8
		minor_opcode : UInt8
		length : UInt16
		window : Window
	end

	struct RandrGetScreenResourcesReply
		response_type : UInt8
		pad0 : UInt8
		sequence : UInt16
		length : UInt32
		timestamp : Timestamp
		config_timestamp : Timestamp
		num_crtcs : UInt16
		num_outputs : UInt16
		num_modes : UInt16
		names_len : UInt16
		pad1 : StaticArray(UInt8, 8)
	end

	struct RandrGetScreenResourcesRequest
		major_opcode : UInt8
		minor_opcode : UInt8
		length : UInt16
		window : Window
	end

	struct RandrGetScreenSizeRangeCookie
		sequence : UInt32
	end

	struct RandrGetScreenSizeRangeReply
		response_type : UInt8
		pad0 : UInt8
		sequence : UInt16
		length : UInt32
		min_width : UInt16
		min_height : UInt16
		max_width : UInt16
		max_height : UInt16
		pad1 : StaticArray(UInt8, 16)
	end

	struct RandrGetScreenSizeRangeRequest
		major_opcode : UInt8
		minor_opcode : UInt8
		length : UInt16
		window : Window
	end

	struct RandrLeaseIterator
		data : RandrLease*
		rem : Int32
		index : Int32
	end

	struct RandrLeaseNotifyIterator
		data : RandrLeaseNotify*
		rem : Int32
		index : Int32
	end

	struct RandrLeaseNotify
		timestamp : Timestamp
		window : Window
		lease : RandrLease
		created : UInt8
		pad0 : StaticArray(UInt8, 15)
	end

	struct RandrListOutputPropertiesCookie
		sequence : UInt32
	end

	struct RandrListOutputPropertiesReply
		response_type : UInt8
		pad0 : UInt8
		sequence : UInt16
		length : UInt32
		num_atoms : UInt16
		pad1 : StaticArray(UInt8, 22)
	end

	struct RandrListOutputPropertiesRequest
		major_opcode : UInt8
		minor_opcode : UInt8
		length : UInt16
		output : RandrOutput
	end

	struct RandrListProviderPropertiesCookie
		sequence : UInt32
	end

	struct RandrListProviderPropertiesReply
		response_type : UInt8
		pad0 : UInt8
		sequence : UInt16
		length : UInt32
		num_atoms : UInt16
		pad1 : StaticArray(UInt8, 22)
	end

	struct RandrListProviderPropertiesRequest
		major_opcode : UInt8
		minor_opcode : UInt8
		length : UInt16
		provider : RandrProvider
	end

	struct RandrModeInfoIterator
		data : RandrModeInfo*
		rem : Int32
		index : Int32
	end

	struct RandrModeInfo
		id : UInt32
		width : UInt16
		height : UInt16
		dot_clock : UInt32
		hsync_start : UInt16
		hsync_end : UInt16
		htotal : UInt16
		hskew : UInt16
		vsync_start : UInt16
		vsync_end : UInt16
		vtotal : UInt16
		name_len : UInt16
		mode_flags : UInt32
	end

	struct RandrModeIterator
		data : RandrMode*
		rem : Int32
		index : Int32
	end

	struct RandrMonitorInfoIterator
		data : RandrMonitorInfo*
		rem : Int32
		index : Int32
	end

	struct RandrMonitorInfo
		name : Atom
		primary : UInt8
		automatic : UInt8
		n_output : UInt16
		x : Int16
		y : Int16
		width : UInt16
		height : UInt16
		width_in_millimeters : UInt32
		height_in_millimeters : UInt32
	end

	struct RandrNotifyDataIterator
		data : RandrNotifyData*
		rem : Int32
		index : Int32
	end

	struct RandrNotifyEvent
		response_type : UInt8
		sub_code : UInt8
		sequence : UInt16
		u : RandrNotifyData
	end

	struct RandrOutputChangeIterator
		data : RandrOutputChange*
		rem : Int32
		index : Int32
	end

	struct RandrOutputChange
		timestamp : Timestamp
		config_timestamp : Timestamp
		window : Window
		output : RandrOutput
		crtc : RandrCrtc
		mode : RandrMode
		rotation : UInt16
		connection : UInt8
		subpixel_order : UInt8
	end

	struct RandrOutputIterator
		data : RandrOutput*
		rem : Int32
		index : Int32
	end

	struct RandrOutputPropertyIterator
		data : RandrOutputProperty*
		rem : Int32
		index : Int32
	end

	struct RandrOutputProperty
		window : Window
		output : RandrOutput
		atom : Atom
		timestamp : Timestamp
		status : UInt8
		pad0 : StaticArray(UInt8, 11)
	end

	struct RandrProviderChangeIterator
		data : RandrProviderChange*
		rem : Int32
		index : Int32
	end

	struct RandrProviderChange
		timestamp : Timestamp
		window : Window
		provider : RandrProvider
		pad0 : StaticArray(UInt8, 16)
	end

	struct RandrProviderIterator
		data : RandrProvider*
		rem : Int32
		index : Int32
	end

	struct RandrProviderPropertyIterator
		data : RandrProviderProperty*
		rem : Int32
		index : Int32
	end

	struct RandrProviderProperty
		window : Window
		provider : RandrProvider
		atom : Atom
		timestamp : Timestamp
		state : UInt8
		pad0 : StaticArray(UInt8, 11)
	end

	struct RandrQueryOutputPropertyCookie
		sequence : UInt32
	end

	struct RandrQueryOutputPropertyReply
		response_type : UInt8
		pad0 : UInt8
		sequence : UInt16
		length : UInt32
		pending : UInt8
		range : UInt8
		immutable : UInt8
		pad1 : StaticArray(UInt8, 21)
	end

	struct RandrQueryOutputPropertyRequest
		major_opcode : UInt8
		minor_opcode : UInt8
		length : UInt16
		output : RandrOutput
		property : Atom
	end

	struct RandrQueryProviderPropertyCookie
		sequence : UInt32
	end

	struct RandrQueryProviderPropertyReply
		response_type : UInt8
		pad0 : UInt8
		sequence : UInt16
		length : UInt32
		pending : UInt8
		range : UInt8
		immutable : UInt8
		pad1 : StaticArray(UInt8, 21)
	end

	struct RandrQueryProviderPropertyRequest
		major_opcode : UInt8
		minor_opcode : UInt8
		length : UInt16
		provider : RandrProvider
		property : Atom
	end

	struct RandrQueryVersionCookie
		sequence : UInt32
	end

	struct RandrQueryVersionReply
		response_type : UInt8
		pad0 : UInt8
		sequence : UInt16
		length : UInt32
		major_version : UInt32
		minor_version : UInt32
		pad1 : StaticArray(UInt8, 16)
	end

	struct RandrQueryVersionRequest
		major_opcode : UInt8
		minor_opcode : UInt8
		length : UInt16
		major_version : UInt32
		minor_version : UInt32
	end

	struct RandrRefreshRatesIterator
		data : RandrRefreshRates*
		rem : Int32
		index : Int32
	end

	struct RandrRefreshRates
		n_rates : UInt16
	end

	struct RandrResourceChangeIterator
		data : RandrResourceChange*
		rem : Int32
		index : Int32
	end

	struct RandrResourceChange
		timestamp : Timestamp
		window : Window
		pad0 : StaticArray(UInt8, 20)
	end

	struct RandrScreenChangeNotifyEvent
		response_type : UInt8
		rotation : UInt8
		sequence : UInt16
		timestamp : Timestamp
		config_timestamp : Timestamp
		root : Window
		request_window : Window
		size_id : UInt16
		subpixel_order : UInt16
		width : UInt16
		height : UInt16
		mwidth : UInt16
		mheight : UInt16
	end

	struct RandrScreenSizeIterator
		data : RandrScreenSize*
		rem : Int32
		index : Int32
	end

	struct RandrScreenSize
		width : UInt16
		height : UInt16
		mwidth : UInt16
		mheight : UInt16
	end

	struct RandrSelectInputRequest
		major_opcode : UInt8
		minor_opcode : UInt8
		length : UInt16
		window : Window
		enable : UInt16
		pad0 : StaticArray(UInt8, 2)
	end

	struct RandrSetCrtcConfigCookie
		sequence : UInt32
	end

	struct RandrSetCrtcConfigReply
		response_type : UInt8
		status : UInt8
		sequence : UInt16
		length : UInt32
		timestamp : Timestamp
		pad0 : StaticArray(UInt8, 20)
	end

	struct RandrSetCrtcConfigRequest
		major_opcode : UInt8
		minor_opcode : UInt8
		length : UInt16
		crtc : RandrCrtc
		timestamp : Timestamp
		config_timestamp : Timestamp
		x : Int16
		y : Int16
		mode : RandrMode
		rotation : UInt16
		pad0 : StaticArray(UInt8, 2)
	end

	struct RandrSetCrtcGammaRequest
		major_opcode : UInt8
		minor_opcode : UInt8
		length : UInt16
		crtc : RandrCrtc
		size : UInt16
		pad0 : StaticArray(UInt8, 2)
	end

	struct RandrSetCrtcransformRequest
		major_opcode : UInt8
		minor_opcode : UInt8
		length : UInt16
		crtc : RandrCrtc
		transform : RenderTransform
		filter_len : UInt16
		pad0 : StaticArray(UInt8, 2)
	end

	struct RandrSetMonitorRequest
		major_opcode : UInt8
		minor_opcode : UInt8
		length : UInt16
		window : Window
	end

	struct RandrSetOutputPrimaryRequest
		major_opcode : UInt8
		minor_opcode : UInt8
		length : UInt16
		window : Window
		output : RandrOutput
	end

	struct RandrSetPanningCookie
		sequence : UInt32
	end

	struct RandrSetPanningReply
		response_type : UInt8
		status : UInt8
		sequence : UInt16
		length : UInt32
		timestamp : Timestamp
	end

	struct RandrSetPanningRequest
		major_opcode : UInt8
		minor_opcode : UInt8
		length : UInt16
		crtc : RandrCrtc
		timestamp : Timestamp
		left : UInt16
		top : UInt16
		width : UInt16
		height : UInt16
		track_left : UInt16
		track_top : UInt16
		track_width : UInt16
		track_height : UInt16
		border_left : Int16
		border_top : Int16
		border_right : Int16
		border_bottom : Int16
	end

	struct RandrSetProviderOffloadSinkRequest
		major_opcode : UInt8
		minor_opcode : UInt8
		length : UInt16
		provider : RandrProvider
		sink_provider : RandrProvider
		config_timestamp : Timestamp
	end

	struct RandrSetProviderOutputSourceRequest
		major_opcode : UInt8
		minor_opcode : UInt8
		length : UInt16
		provider : RandrProvider
		source_provider : RandrProvider
		config_timestamp : Timestamp
	end

	struct RandrSetScreenConfigCookie
		sequence : UInt32
	end

	struct SetScreenConfigReply
		response_type : UInt8
		status : UInt8
		sequence : UInt16
		length : UInt32
		new_timestamp : Timestamp
		config_timestamp : Timestamp
		root : Window
		subpixel_order : UInt16
		pad0 : StaticArray(UInt8, 10)
	end

	struct RandrSetScreenConfigRequest
		major_opcode : UInt8
		minor_opcode : UInt8
		length : UInt16
		window : Window
		timestamp : Timestamp
		config_timestamp : Timestamp
		size_id : UInt16
		rotation : UInt16
		rate : UInt16
		pad0 : StaticArray(UInt8, 2)
	end

	struct RandrSetScreenSizeRequest
		major_opcode : UInt8
		minor_opcode : UInt8
		length : UInt16
		window : Window
		width : UInt16
		height : UInt16
		mm_width : UInt32
		mm_height : UInt32
	end


	fun xcb_randr_add_output_mode(c : Connection*, output : RandrOutput, mode : RandrMode) : VoidCookie
	fun xcb_randr_add_output_mode_checked(c : Connection*, output : RandrOutput, mode : RandrMode) : VoidCookie
	fun xcb_randr_change_output_property(c : Connection*, output : RandrOutput, property : Atom, type : Atom, format : UInt8, mode : UInt8, num_units : UInt32, data : Void*) : VoidCookie
	fun xcb_randr_change_output_property_checked(c : Connection*, output : RandrOutput, property : Atom, type : Atom, format : UInt8, mode : UInt8, num_units : UInt32, data : Void*) : VoidCookie
	fun xcb_randr_change_output_property_data(r : RandrChangeOutputPropertyRequest*) : Void*
		fun xcb_randr_change_output_property_data_end(r : RandrChangeOutputPropertyRequest*) : GenericIterator
	fun xcb_randr_change_output_property_data_length(r : RandrChangeOutputPropertyRequest*) : Int32
	fun xcb_randr_change_output_property_sizeof(_buffer : Void*) : Int32
	fun xcb_randr_change_provider_property(c : Connection*, provider : RandrProvider, property : Atom, type : Atom, format : UInt8, mode : UInt8, num_items : UInt32, data : Void*) : VoidCookie
	fun xcb_randr_change_provider_property_checked(c : Connection*, provider : RandrProvider, property : Atom, type : Atom, format : UInt8, mode : UInt8, num_items : UInt32, data : Void*) : VoidCookie
	fun xcb_randr_change_provider_property_data(r : RandrChangeProviderPropertyRequest*) : Void*
		fun xcb_randr_change_provider_property_data_end(r : RandrChangeProviderPropertyRequest*) : GenericIterator
	fun xcb_randr_change_provider_property_data_length(r : RandrChangeProviderPropertyRequest*) : Int32
	fun xcb_randr_change_provider_property_sizeof(_buffer : Void*) : Int32
	fun xcb_randr_configure_output_property(c : Connection*, output : RandrOutput, property : Atom, pending : UInt8, range : UInt8, values_len : UInt32, values : Int32*) : VoidCookie
	fun xcb_randr_configure_output_property_checked(c : Connection*, output : RandrOutput, property : Atom, pending : UInt8, range : UInt8, values_len : UInt32, values : Int32*) : VoidCookie
	fun xcb_randr_configure_output_property_sizeof(_buffer : Void*, values_len : UInt32) : Int32
	fun xcb_randr_configure_output_property_values(r : RandrConfigureOutputPropertyRequest*) : Int32*
		fun xcb_randr_configure_output_property_values_end(r : RandrConfigureOutputPropertyRequest*) : GenericIterator
	fun xcb_randr_configure_output_property_values_length(r : RandrConfigureOutputPropertyRequest*) : Int32
	fun xcb_randr_configure_provider_property(c : Connection*, provider : RandrProvider, property : Atom, pending : UInt8, range : UInt8, values_len : UInt32, values : Int32*) : VoidCookie
	fun xcb_randr_configure_provider_property_checked(c : Connection*, provider : RandrProvider, property : Atom, pending : UInt8, range : UInt8, values_len : UInt32, values : Int32*) : VoidCookie
	fun xcb_randr_configure_provider_property_sizeof(_buffer : Void*, values_len : UInt32) : Int32
	fun xcb_randr_configure_provider_property_values(r : RandrConfigureProviderPropertyRequest*) : Int32*
		fun xcb_randr_configure_provider_property_values_end(r : RandrConfigureProviderPropertyRequest*) : GenericIterator
	fun xcb_randr_configure_provider_property_values_length(r : RandrConfigureProviderPropertyRequest*) : Int32
	fun xcb_randr_create_lease(c : Connection*, window : Window, lid : RandrLease, num_crtcs : UInt16, num_outputs : UInt16, crtcs : RandrCrtc*, outputs : RandrOutput*) : RandrCreateLeaseCookie
	fun xcb_randr_create_lease_reply(c : Connection*, cookie : RandrCreateLeaseCookie, e : GenericError**) : RandrCreateLeaseReply*
		fun xcb_randr_create_lease_reply_fds(c : Connection*, reply : RandrCreateLeaseReply*) : Int32*
		fun xcb_randr_create_lease_sizeof(_buffer : Void*) : Int32
	fun xcb_randr_create_lease_unchecked(c : Connection*, window : Window, lid : RandrLease, num_crtcs : UInt16, num_outputs : UInt16, crtcs : RandrCrtc*, outputs : RandrOutput*) : RandrCreateLeaseCookie
	fun xcb_randr_create_mode(c : Connection*, window : Window, mode_info : RandrModeInfo, name_len : UInt32, name : LibC::Char*) : RandrCreateModeCookie
	fun xcb_randr_create_mode_reply(c : Connection*, cookie : RandrCreateModeCookie, e : GenericError**) : RandrCreateModeReply*
		fun xcb_randr_create_mode_sizeof(_buffer : Void*, name_len : UInt32) : Int32
	fun xcb_randr_create_mode_unchecked(c : Connection*, window : Window, mode_info : RandrModeInfo, name_len : UInt32, name : LibC::Char*) : RandrCreateModeCookie
	fun xcb_randr_crtc_change_end(i : RandrCrtcChangeIterator) : GenericIterator
	fun xcb_randr_crtc_change_next(i : RandrCrtcChangeIterator*)
	fun xcb_randr_crtc_end(i : RandrCrtcIterator) : GenericIterator
	fun xcb_randr_crtc_next(i : RandrCrtcIterator*)
	fun xcb_randr_delete_monitor(c : Connection*, window : Window, name : Atom) : VoidCookie
	fun xcb_randr_delete_monitor_checked(c : Connection*, window : Window, name : Atom) : VoidCookie
	fun xcb_randr_delete_output_mode(c : Connection*, output : RandrOutput, mode : RandrMode) : VoidCookie
	fun xcb_randr_delete_output_mode_checked(c : Connection*, output : RandrOutput, mode : RandrMode) : VoidCookie
	fun xcb_randr_delete_output_property(c : Connection*, output : RandrOutput, property : Atom) : VoidCookie
	fun xcb_randr_delete_output_property_checked(c : Connection*, output : RandrOutput, property : Atom) : VoidCookie
	fun xcb_randr_delete_provider_property(c : Connection*, provider : RandrProvider, property : Atom) : VoidCookie
	fun xcb_randr_delete_provider_property_checked(c : Connection*, provider : RandrProvider, property : Atom) : VoidCookie
	fun xcb_randr_destroy_mode(c : Connection*, mode : RandrMode) : VoidCookie
	fun xcb_randr_destroy_mode_checked(c : Connection*, mode : RandrMode) : VoidCookie
	fun xcb_randr_free_lease(c : Connection*, lid : RandrLease, terminate : UInt8) : VoidCookie
	fun xcb_randr_free_lease_checked(c : Connection*, lid : RandrLease, terminate : UInt8) : VoidCookie
	fun xcb_randr_get_crtc_gamma(c : Connection*, crtc : RandrCrtc) : RandrGetCrtcGammaCookie
	fun xcb_randr_get_crtc_gamma_blue(r : RandrGetCrtcGammaReply*) : UInt16*
		fun xcb_randr_get_crtc_gamma_blue_end(r : RandrGetCrtcGammaReply*) : GenericIterator
	fun xcb_randr_get_crtc_gamma_blue_length(r : RandrGetCrtcGammaReply*) : Int32
	fun xcb_randr_get_crtc_gamma_green(r : RandrGetCrtcGammaReply*) : UInt16*
		fun xcb_randr_get_crtc_gamma_green_end(r : RandrGetCrtcGammaReply*) : GenericIterator
	fun xcb_randr_get_crtc_gamma_green_length(r : RandrGetCrtcGammaReply*) : Int32
	fun xcb_randr_get_crtc_gamma_red(r : RandrGetCrtcGammaReply*) : UInt16*
		fun xcb_randr_get_crtc_gamma_red_end(r : RandrGetCrtcGammaReply*) : GenericIterator
	fun xcb_randr_get_crtc_gamma_red_length(r : RandrGetCrtcGammaReply*) : Int32
	fun xcb_randr_get_crtc_gamma_reply(c : Connection*, cookie : RandrGetCrtcGammaCookie, e : GenericError**) : RandrGetCrtcGammaReply*
		fun xcb_randr_get_crtc_gamma_size(c : Connection*, crtc : RandrCrtc) : RandrGetCrtcGammaSizeCookie
	fun xcb_randr_get_crtc_gamma_size_reply(c : Connection*, cookie : RandrGetCrtcGammaSizeCookie, e : GenericError**) : RandrGetCrtcGammaSizeReply*
		fun xcb_randr_get_crtc_gamma_size_unchecked(c : Connection*, crtc : RandrCrtc) : RandrGetCrtcGammaSizeCookie
	fun xcb_randr_get_crtc_gamma_sizeof(_buffer : Void*) : Int32
	fun xcb_randr_get_crtc_gamma_unchecked(c : Connection*, crtc : RandrCrtc) : RandrGetCrtcGammaCookie
	fun xcb_randr_get_crtc_info(c : Connection*, crtc : RandrCrtc, config_timestamp : Timestamp) : RandrGetCrtcInfoCookie
	fun xcb_randr_get_crtc_info_outputs(r : RandrGetCrtcInfoReply*) : RandrOutput*
		fun xcb_randr_get_crtc_info_outputs_end(r : RandrGetCrtcInfoReply*) : GenericIterator
	fun xcb_randr_get_crtc_info_outputs_length(r : RandrGetCrtcInfoReply*) : Int32
	fun xcb_randr_get_crtc_info_possible(r : RandrGetCrtcInfoReply*) : RandrOutput*
		fun xcb_randr_get_crtc_info_possible_end(r : RandrGetCrtcInfoReply*) : GenericIterator
	fun xcb_randr_get_crtc_info_possible_length(r : RandrGetCrtcInfoReply*) : Int32
	fun xcb_randr_get_crtc_info_reply(c : Connection*, cookie : RandrGetCrtcInfoCookie, e : GenericError**) : RandrGetCrtcInfoReply*
		fun xcb_randr_get_crtc_info_sizeof(_buffer : Void*) : Int32
	fun xcb_randr_get_crtc_info_unchecked(c : Connection*, crtc : RandrCrtc, config_timestamp : Timestamp) : RandrGetCrtcInfoCookie
	fun xcb_randr_get_crtc_transform(c : Connection*, crtc : RandrCrtc) : RandrGetCrtcransformCookie
	fun xcb_randr_get_crtc_transform_current_filter_name(r : RandrGetCrtcransformReply*) : LibC::Char*
		fun xcb_randr_get_crtc_transform_current_filter_name_end(r : RandrGetCrtcransformReply*) : GenericIterator
	fun xcb_randr_get_crtc_transform_current_filter_name_length(r : RandrGetCrtcransformReply*) : Int32
	fun xcb_randr_get_crtc_transform_current_params(r : RandrGetCrtcransformReply*) : RenderFixed*
		fun xcb_randr_get_crtc_transform_current_params_end(r : RandrGetCrtcransformReply*) : GenericIterator
	fun xcb_randr_get_crtc_transform_current_params_length(r : RandrGetCrtcransformReply*) : Int32
	fun xcb_randr_get_crtc_transform_pending_filter_name(r : RandrGetCrtcransformReply*) : LibC::Char*
		fun xcb_randr_get_crtc_transform_pending_filter_name_end(r : RandrGetCrtcransformReply*) : GenericIterator
	fun xcb_randr_get_crtc_transform_pending_filter_name_length(r : RandrGetCrtcransformReply*) : Int32
	fun xcb_randr_get_crtc_transform_pending_params(r : RandrGetCrtcransformReply*) : RenderFixed*
		fun xcb_randr_get_crtc_transform_pending_params_end(r : RandrGetCrtcransformReply*) : GenericIterator
	fun xcb_randr_get_crtc_transform_pending_params_length(r : RandrGetCrtcransformReply*) : Int32
	fun xcb_randr_get_crtc_transform_reply(c : Connection*, cookie : RandrGetCrtcransformCookie, e : GenericError**) : RandrGetCrtcransformReply*
		fun xcb_randr_get_crtc_transform_sizeof(_buffer : Void*) : Int32
	fun xcb_randr_get_crtc_transform_unchecked(c : Connection*, crtc : RandrCrtc) : RandrGetCrtcransformCookie
	fun xcb_randr_get_monitors(c : Connection*, window : Window, get_active : UInt8) : RandrGetMonitorsCookie
	fun xcb_randr_get_monitors_monitors_iterator(r : RandrGetMonitorsReply*) : RandrMonitorInfoIterator
	fun xcb_randr_get_monitors_monitors_length(r : RandrGetMonitorsReply*) : Int32
	fun xcb_randr_get_monitors_reply(c : Connection*, cookie : RandrGetMonitorsCookie, e : GenericError**) : RandrGetMonitorsReply*
		fun xcb_randr_get_monitors_sizeof(_buffer : Void*) : Int32
	fun xcb_randr_get_monitors_unchecked(c : Connection*, window : Window, get_active : UInt8) : RandrGetMonitorsCookie
	fun xcb_randr_get_output_info(c : Connection*, output : RandrOutput, config_timestamp : Timestamp) : RandrGetOutputInfoCookie
	fun xcb_randr_get_output_info_clones(r : RandrGetOutputInfoReply*) : RandrOutput*
		fun xcb_randr_get_output_info_clones_end(r : RandrGetOutputInfoReply*) : GenericIterator
	fun xcb_randr_get_output_info_clones_length(r : RandrGetOutputInfoReply*) : Int32
	fun xcb_randr_get_output_info_crtcs(r : RandrGetOutputInfoReply*) : RandrCrtc*
		fun xcb_randr_get_output_info_crtcs_end(r : RandrGetOutputInfoReply*) : GenericIterator
	fun xcb_randr_get_output_info_crtcs_length(r : RandrGetOutputInfoReply*) : Int32
	fun xcb_randr_get_output_info_modes(r : RandrGetOutputInfoReply*) : RandrMode*
		fun xcb_randr_get_output_info_modes_end(r : RandrGetOutputInfoReply*) : GenericIterator
	fun xcb_randr_get_output_info_modes_length(r : RandrGetOutputInfoReply*) : Int32
	fun xcb_randr_get_output_info_name(r : RandrGetOutputInfoReply*) : UInt8*
		fun xcb_randr_get_output_info_name_end(r : RandrGetOutputInfoReply*) : GenericIterator
	fun xcb_randr_get_output_info_name_length(r : RandrGetOutputInfoReply*) : Int32
	fun xcb_randr_get_output_info_reply(c : Connection*, cookie : RandrGetOutputInfoCookie, e : GenericError**) : RandrGetOutputInfoReply*
		fun xcb_randr_get_output_info_sizeof(_buffer : Void*) : Int32
	fun xcb_randr_get_output_info_unchecked(c : Connection*, output : RandrOutput, config_timestamp : Timestamp) : RandrGetOutputInfoCookie
	fun xcb_randr_get_output_primary(c : Connection*, window : Window) : RandrGetOutputPrimaryCookie
	fun xcb_randr_get_output_primary_reply(c : Connection*, cookie : RandrGetOutputPrimaryCookie, e : GenericError**) : RandrGetOutputPrimaryReply*
		fun xcb_randr_get_output_primary_unchecked(c : Connection*, window : Window) : RandrGetOutputPrimaryCookie
	fun xcb_randr_get_output_property(c : Connection*, output : RandrOutput, property : Atom, type : Atom, long_offset : UInt32, long_length : UInt32, _delete : UInt8, pending : UInt8) : RandrGetOutputPropertyCookie
	fun xcb_randr_get_output_property_data(r : RandrGetOutputPropertyReply*) : UInt8*
		fun xcb_randr_get_output_property_data_end(r : RandrGetOutputPropertyReply*) : GenericIterator
	fun xcb_randr_get_output_property_data_length(r : RandrGetOutputPropertyReply*) : Int32
	fun xcb_randr_get_output_property_reply(c : Connection*, cookie : RandrGetOutputPropertyCookie, e : GenericError**) : RandrGetOutputPropertyReply*
		fun = xcb_randr_get_output_property_sizeof(_buffer : Void*) : Int32
	fun xcb_randr_get_output_property_unchecked(c : Connection*, output : RandrOutput, property : Atom, type : Atom, long_offset : UInt32, long_length : UInt32, _delete : UInt8, pending : UInt8) : RandrGetOutputPropertyCookie
	fun xcb_randr_get_panning(c : Connection*, crtc : RandrCrtc) : RandrGetPanningCookie
	fun xcb_randr_get_panning_reply(c : Connection*, cookie : RandrGetPanningCookie, e : GenericError**) : RandrGetPanningReply*
		fun xcb_randr_get_panning_unchecked(c : Connection*, crtc : RandrCrtc) : RandrGetPanningCookie
	fun xcb_randr_get_provider_info(c : Connection*, provider : RandrProvider, config_timestamp : Timestamp) : RandrGetProviderInfoCookie
	fun xcb_randr_get_provider_info_associated_capability(r : RandrGetProviderInfoReply*) : UInt32*
		fun xcb_randr_get_provider_info_associated_capability_end(r : RandrGetProviderInfoReply*) : GenericIterator
	fun xcb_randr_get_provider_info_associated_capability_length(r : RandrGetProviderInfoReply*) : Int32
	fun xcb_randr_get_provider_info_associated_providers(r : RandrGetProviderInfoReply*) : RandrProvider*
		fun xcb_randr_get_provider_info_associated_providers_end(r : RandrGetProviderInfoReply*) : GenericIterator
	fun xcb_randr_get_provider_info_associated_providers_length(r : RandrGetProviderInfoReply*) : Int32
	fun xcb_randr_get_provider_info_crtcs(r : RandrGetProviderInfoReply*) : RandrCrtc*
		fun xcb_randr_get_provider_info_crtcs_end(r : RandrGetProviderInfoReply*) : GenericIterator
	fun xcb_randr_get_provider_info_crtcs_length(r : RandrGetProviderInfoReply*) : Int32
	fun xcb_randr_get_provider_info_name(r : RandrGetProviderInfoReply*) : LibC::Char*
		fun xcb_randr_get_provider_info_name_end(r : RandrGetProviderInfoReply*) : GenericIterator
	fun xcb_randr_get_provider_info_name_length(r : RandrGetProviderInfoReply*) : Int32
	fun xcb_randr_get_provider_info_outputs(r : RandrGetProviderInfoReply*) : RandrOutput*
		fun xcb_randr_get_provider_info_outputs_end(r : RandrGetProviderInfoReply*) : GenericIterator
	fun xcb_randr_get_provider_info_outputs_length(r : RandrGetProviderInfoReply*) : Int32
	fun xcb_randr_get_provider_info_reply(c : Connection*, cookie : RandrGetProviderInfoCookie, e : GenericError**) : RandrGetProviderInfoReply*
		fun xcb_randr_get_provider_info_sizeof(_buffer : Void*) : Int32
	fun xcb_randr_get_provider_info_unchecked(c : Connection*, provider : RandrProvider, config_timestamp : Timestamp) : RandrGetProviderInfoCookie
	fun xcb_randr_get_provider_property(c : Connection*, provider : RandrProvider, property : Atom, type : Atom, long_offset : UInt32, long_length : UInt32, _delete : UInt8, pending : UInt8) : RandrGetProviderPropertyCookie
	fun xcb_randr_get_provider_property_data(r : RandrGetProviderPropertyReply*) : Void*
		fun xcb_randr_get_provider_property_data_end(r : RandrGetProviderPropertyReply*) : GenericIterator
	fun xcb_randr_get_provider_property_data_length(r : RandrGetProviderPropertyReply*) : Int32
	fun xcb_randr_get_provider_property_reply(c : Connection*, cookie : RandrGetProviderPropertyCookie, e : GenericError**) : RandrGetProviderPropertyReply*
		fun xcb_randr_get_provider_property_sizeof(_buffer : Void*) : Int32
	fun xcb_randr_get_provider_property_unchecked(c : Connection*, provider : RandrProvider, property : Atom, type : Atom, long_offset : UInt32, long_length : UInt32, _delete : UInt8, pending : UInt8) : RandrGetProviderPropertyCookie
	fun xcb_randr_get_providers(c : Connection*, window : Window) : RandrGetProvidersCookie
	fun xcb_randr_get_providers_providers(r : RandrGetProvidersReply*) : RandrProvider*
		fun xcb_randr_get_providers_providers_end(r : RandrGetProvidersReply*) : GenericIterator
	fun xcb_randr_get_providers_providers_length(r : RandrGetProvidersReply*) : Int32
	fun xcb_randr_get_providers_reply(c : Connection*, cookie : RandrGetProvidersCookie, e : GenericError**) : RandrGetProvidersReply*
		fun xcb_randr_get_providers_sizeof(_buffer : Void*) : Int32
	fun xcb_randr_get_providers_unchecked(c : Connection*, window : Window) : RandrGetProvidersCookie
	fun xcb_randr_get_screen_info(c : Connection*, window : Window) : RandrGetScreenInfoCookie
	fun xcb_randr_get_screen_info_rates_iterator(r : RandrGetScreenInfoReply*) : RandrRefreshRatesIterator
	fun xcb_randr_get_screen_info_rates_length(r : RandrGetScreenInfoReply*) : Int32
	fun xcb_randr_get_screen_info_reply(c : Connection*, cookie : RandrGetScreenInfoCookie, e : GenericError**) : RandrGetScreenInfoReply*
		fun xcb_randr_get_screen_info_sizeof(_buffer : Void*) : Int32
	fun xcb_randr_get_screen_info_sizes(r : RandrGetScreenInfoReply*) : RandrScreenSize*
		fun xcb_randr_get_screen_info_sizes_iterator(r : RandrGetScreenInfoReply*) : RandrScreenSizeIterator
	fun xcb_randr_get_screen_info_sizes_length(r : RandrGetScreenInfoReply*) : Int32
	fun xcb_randr_get_screen_info_unchecked(c : Connection*, window : Window) : RandrGetScreenInfoCookie
	fun xcb_randr_get_screen_resources(c : Connection*, window : Window) : RandrGetScreenResourcesCookie
	fun xcb_randr_get_screen_resources_crtcs(r : RandrGetScreenResourcesReply*) : RandrCrtc*
		fun xcb_randr_get_screen_resources_crtcs_end(r : RandrGetScreenResourcesReply*) : GenericIterator
	fun xcb_randr_get_screen_resources_crtcs_length(r : RandrGetScreenResourcesReply*) : Int32
	fun xcb_randr_get_screen_resources_current(c : Connection*, window : Window) : RandrGetScreenResourcesCurrentCookie
	fun xcb_randr_get_screen_resources_current_crtcs(r : RandrGetScreenResourcesCurrentReply*) : RandrCrtc*
		fun xcb_randr_get_screen_resources_current_crtcs_end(r : RandrGetScreenResourcesCurrentReply*) : GenericIterator
	fun xcb_randr_get_screen_resources_current_crtcs_length(r : RandrGetScreenResourcesCurrentReply*) : Int32
	fun xcb_randr_get_screen_resources_current_modes(r : RandrGetScreenResourcesCurrentReply*) : RandrModeInfo*
		fun xcb_randr_get_screen_resources_current_modes_iterator(r : RandrGetScreenResourcesCurrentReply*) : RandrModeInfoIterator
	fun xcb_randr_get_screen_resources_current_modes_length(r : RandrGetScreenResourcesCurrentReply*) : Int32
	fun xcb_randr_get_screen_resources_current_names(r : RandrGetScreenResourcesCurrentReply*) : UInt8*
		fun xcb_randr_get_screen_resources_current_names_end(r : RandrGetScreenResourcesCurrentReply*) : GenericIterator
	fun xcb_randr_get_screen_resources_current_names_length(r : RandrGetScreenResourcesCurrentReply*) : Int32
	fun xcb_randr_get_screen_resources_current_outputs(r : RandrGetScreenResourcesCurrentReply*) : RandrOutput*
		fun xcb_randr_get_screen_resources_current_outputs_end(r : RandrGetScreenResourcesCurrentReply*) : GenericIterator
	fun xcb_randr_get_screen_resources_current_outputs_length(r : RandrGetScreenResourcesCurrentReply*) : Int32
	fun xcb_randr_get_screen_resources_current_reply(c : Connection*, cookie : RandrGetScreenResourcesCurrentCookie, e : GenericError**) : RandrGetScreenResourcesCurrentReply*
		fun xcb_randr_get_screen_resources_current_sizeof(_buffer : Void*) : Int32
	fun xcb_randr_get_screen_resources_current_unchecked(c : Connection*, window : Window) : RandrGetScreenResourcesCurrentCookie
	fun xcb_randr_get_screen_resources_modes(r : RandrGetScreenResourcesReply*) : RandrModeInfo*
		fun xcb_randr_get_screen_resources_modes_iterator(r : RandrGetScreenResourcesReply*) : RandrModeInfoIterator
	fun xcb_randr_get_screen_resources_modes_length(r : RandrGetScreenResourcesReply*) : Int32
	fun xcb_randr_get_screen_resources_names(r : RandrGetScreenResourcesReply*) : UInt8*
		fun xcb_randr_get_screen_resources_names_end(r : RandrGetScreenResourcesReply*) : GenericIterator
	fun xcb_randr_get_screen_resources_names_length(r : RandrGetScreenResourcesReply*) : Int32
	fun xcb_randr_get_screen_resources_outputs(r : RandrGetScreenResourcesReply*) : RandrOutput*
		fun xcb_randr_get_screen_resources_outputs_end(r : RandrGetScreenResourcesReply*) : GenericIterator
	fun xcb_randr_get_screen_resources_outputs_length(r : RandrGetScreenResourcesReply*) : Int32
	fun xcb_randr_get_screen_resources_reply(c : Connection*, cookie : RandrGetScreenResourcesCookie, e : GenericError**) : RandrGetScreenResourcesReply*
		fun xcb_randr_get_screen_resources_sizeof(_buffer : Void*) : Int32
	fun xcb_randr_get_screen_resources_unchecked(c : Connection*, window : Window) : RandrGetScreenResourcesCookie
	fun xcb_randr_get_screen_size_range(c : Connection*, window : Window) : RandrGetScreenSizeRangeCookie
	fun xcb_randr_get_screen_size_range_reply(c : Connection*, cookie : RandrGetScreenSizeRangeCookie, e : GenericError**) : RandrGetScreenSizeRangeReply*
		fun xcb_randr_get_screen_size_range_unchecked(c : Connection*, window : Window) : RandrGetScreenSizeRangeCookie
	fun xcb_randr_lease_end(i : RandrLeaseIterator) : GenericIterator
	fun xcb_randr_lease_next(i : RandrLeaseIterator*)
	fun xcb_randr_lease_notify_end(i : RandrLeaseNotifyIterator) : GenericIterator
	fun xcb_randr_lease_notify_next(i : RandrLeaseNotifyIterator*)
	fun xcb_randr_list_output_properties(c : Connection*, output : RandrOutput) : RandrListOutputPropertiesCookie
	fun xcb_randr_list_output_properties_atoms(r : RandrListOutputPropertiesReply*) : Atom*
		fun xcb_randr_list_output_properties_atoms_end(r : RandrListOutputPropertiesReply*) : GenericIterator
	fun xcb_randr_list_output_properties_atoms_length(r : RandrListOutputPropertiesReply*) : Int32
	fun xcb_randr_list_output_properties_reply(c : Connection*, cookie : RandrListOutputPropertiesCookie, e : GenericError**) : RandrListOutputPropertiesReply*
		fun xcb_randr_list_output_properties_sizeof(_buffer : Void*) : Int32
	fun xcb_randr_list_output_properties_unchecked(c : Connection*, output : RandrOutput) : RandrListOutputPropertiesCookie
	fun xcb_randr_list_provider_properties(c : Connection*, provider : RandrProvider) : RandrListProviderPropertiesCookie
	fun xcb_randr_list_provider_properties_atoms(r : RandrListProviderPropertiesReply*) : Atom*
		fun xcb_randr_list_provider_properties_atoms_end(r : RandrListProviderPropertiesReply*) : GenericIterator
	fun xcb_randr_list_provider_properties_atoms_length(r : RandrListProviderPropertiesReply*) : Int32
	fun = xcb_randr_list_provider_properties_reply(c : Connection*, cookie : RandrListProviderPropertiesCookie, e : GenericError**) : RandrListProviderPropertiesReply*
		fun xcb_randr_list_provider_properties_sizeof(_buffer : Void*) : Int32
	fun xcb_randr_list_provider_properties_unchecked(c : Connection*, provider : RandrProvider) : RandrListProviderPropertiesCookie
	fun xcb_randr_mode_end(i : RandrModeIterator) : GenericIterator
	fun xcb_randr_mode_info_end(i : RandrModeInfoIterator) : GenericIterator
	fun xcb_randr_mode_info_next(i : RandrModeInfoIterator*)
	fun xcb_randr_mode_next(i : RandrModeIterator*)
	fun xcb_randr_monitor_info_end(i : RandrMonitorInfoIterator) : GenericIterator
	fun xcb_randr_monitor_info_next(i : RandrMonitorInfoIterator*)
	fun xcb_randr_monitor_info_outputs(r : RandrMonitorInfo*) : RandrOutput*
		fun xcb_randr_monitor_info_outputs_end(r : RandrMonitorInfo*) : GenericIterator
	fun xcb_randr_monitor_info_outputs_length(r : RandrMonitorInfo*) : Int32
	fun xcb_randr_monitor_info_sizeof(_buffer : Void*) : Int32
	fun xcb_randr_notify_data_end(i : RandrNotifyDataIterator) : GenericIterator
	fun xcb_randr_notify_data_next(i : RandrNotifyDataIterator*)
	fun xcb_randr_output_change_end(i : RandrOutputChangeIterator) : GenericIterator
	fun xcb_randr_output_change_next(i : RandrOutputChangeIterator*)
	fun xcb_randr_output_end(i : RandrOutputIterator) : GenericIterator
	fun xcb_randr_output_next(i : RandrOutputIterator*)
	fun xcb_randr_output_property_end(i : RandrOutputPropertyIterator) : GenericIterator
	fun xcb_randr_output_property_next(i : RandrOutputPropertyIterator*)
	fun xcb_randr_provider_change_end(i : RandrProviderChangeIterator) : GenericIterator
	fun xcb_randr_provider_change_next(i : RandrProviderChangeIterator*)
	fun xcb_randr_provider_end(i : RandrProviderIterator) : GenericIterator
	fun xcb_randr_provider_next(i : RandrProviderIterator*)
	fun xcb_randr_provider_property_end(i : RandrProviderPropertyIterator) : GenericIterator
	fun xcb_randr_provider_property_next(i : RandrProviderPropertyIterator*)
	fun xcb_randr_query_output_property(c : Connection*, output : RandrOutput, property : Atom) : RandrQueryOutputPropertyCookie
	fun xcb_randr_query_output_property_reply(c : Connection*, cookie : RandrQueryOutputPropertyCookie, e : GenericError**) : RandrQueryOutputPropertyReply*
		fun xcb_randr_query_output_property_sizeof(_buffer : Void*) : Int32
	fun xcb_randr_query_output_property_unchecked(c : Connection*, output : RandrOutput, property : Atom) : RandrQueryOutputPropertyCookie
	fun xcb_randr_query_output_property_valid_values(r : RandrQueryOutputPropertyReply*) : Int32*
		fun xcb_randr_query_output_property_valid_values_end(r : RandrQueryOutputPropertyReply*) : GenericIterator
	fun xcb_randr_query_output_property_valid_values_length(r : RandrQueryOutputPropertyReply*) : Int32
	fun xcb_randr_query_provider_property(c : Connection*, provider : RandrProvider, property : Atom) : RandrQueryProviderPropertyCookie
	fun xcb_randr_query_provider_property_reply(c : Connection*, cookie : RandrQueryProviderPropertyCookie, e : GenericError**) : RandrQueryProviderPropertyReply*
		fun xcb_randr_query_provider_property_sizeof(_buffer : Void*) : Int32
	fun xcb_randr_query_provider_property_unchecked(c : Connection*, provider : RandrProvider, property : Atom) : RandrQueryProviderPropertyCookie
	fun xcb_randr_query_provider_property_valid_values(r : RandrQueryProviderPropertyReply*) : Int32*
		fun xcb_randr_query_provider_property_valid_values_end(r : RandrQueryProviderPropertyReply*) : GenericIterator
	fun xcb_randr_query_provider_property_valid_values_length(r : RandrQueryProviderPropertyReply*) : Int32
	fun xcb_randr_query_version(c : Connection*, major_version : UInt32, minor_version : UInt32) : RandrQueryVersionCookie
	fun xcb_randr_query_version_reply(c : Connection*, cookie : RandrQueryVersionCookie, e : GenericError**) : RandrQueryVersionReply*
		fun xcb_randr_query_version_unchecked(c : Connection*, major_version : UInt32, minor_version : UInt32) : RandrQueryVersionCookie
	fun xcb_randr_refresh_rates_end(i : RandrRefreshRatesIterator) : GenericIterator
	fun xcb_randr_refresh_rates_next(i : RandrRefreshRatesIterator*)
	fun xcb_randr_refresh_rates_rates(r : RandrRefreshRates*) : UInt16*
		fun xcb_randr_refresh_rates_rates_end(r : RandrRefreshRates*) : GenericIterator
	fun xcb_randr_refresh_rates_rates_length(r : RandrRefreshRates*) : Int32
	fun xcb_randr_refresh_rates_sizeof(_buffer : Void*) : Int32
	fun xcb_randr_resource_change_end(i : RandrResourceChangeIterator) : GenericIterator
	fun xcb_randr_resource_change_next(i : RandrResourceChangeIterator*)
	fun xcb_randr_screen_size_end(i : RandrScreenSizeIterator) : GenericIterator
	fun xcb_randr_screen_size_next(i : RandrScreenSizeIterator*)
	fun xcb_randr_select_input(c : Connection*, window : Window, enable : UInt16) : VoidCookie
	fun xcb_randr_select_input_checked(c : Connection*, window : Window, enable : UInt16) : VoidCookie
	fun xcb_randr_set_crtc_config(c : Connection*, crtc : RandrCrtc, timestamp : Timestamp, config_timestamp : Timestamp, x : Int16, y : Int16, mode : RandrMode, rotation : UInt16, outputs_len : UInt32, outputs : RandrOutput*) : RandrSetCrtcConfigCookie
	fun xcb_randr_set_crtc_config_reply(c : Connection*, cookie : RandrSetCrtcConfigCookie, e : GenericError**) : RandrSetCrtcConfigReply*
		fun xcb_randr_set_crtc_config_sizeof(_buffer : Void*, outputs_len : UInt32) : Int32
	fun xcb_randr_set_crtc_config_unchecked(c : Connection*, crtc : RandrCrtc, timestamp : Timestamp, config_timestamp : Timestamp, x : Int16, y : Int16, mode : RandrMode, rotation : UInt16, outputs_len : UInt32, outputs : RandrOutput*) : RandrSetCrtcConfigCookie
	fun xcb_randr_set_crtc_gamma(c : Connection*, crtc : RandrCrtc, size : UInt16, red : UInt16*, green : UInt16*, blue : UInt16*) : VoidCookie
	fun xcb_randr_set_crtc_gamma_blue(r : RandrSetCrtcGammaRequest*) : UInt16*
		fun xcb_randr_set_crtc_gamma_blue_end(r : RandrSetCrtcGammaRequest*) : GenericIterator
	fun xcb_randr_set_crtc_gamma_blue_length(r : RandrSetCrtcGammaRequest*) : Int32
	fun xcb_randr_set_crtc_gamma_checked(c : Connection*, crtc : RandrCrtc, size : UInt16, red : UInt16*, green : UInt16*, blue : UInt16*) : VoidCookie
	fun xcb_randr_set_crtc_gamma_green(r : RandrSetCrtcGammaRequest*) : UInt16*
		fun xcb_randr_set_crtc_gamma_green_end(r : RandrSetCrtcGammaRequest*) : GenericIterator
	fun xcb_randr_set_crtc_gamma_green_length(r : RandrSetCrtcGammaRequest*) : Int32
	fun xcb_randr_set_crtc_gamma_red(r : RandrSetCrtcGammaRequest*) : UInt16*
		fun xcb_randr_set_crtc_gamma_red_end(r : RandrSetCrtcGammaRequest*) : GenericIterator
	fun xcb_randr_set_crtc_gamma_red_length(r : RandrSetCrtcGammaRequest*) : Int32
	fun xcb_randr_set_crtc_gamma_sizeof(_buffer : Void*) : Int32
	fun xcb_randr_set_crtc_transform(c : Connection*, crtc : RandrCrtc, transform : RenderTransform, filter_len : UInt16, filter_name : LibC::Char*, filter_params_len : UInt32, filter_params : RenderFixed*) : VoidCookie
	fun xcb_randr_set_crtc_transform_checked(c : Connection*, crtc : RandrCrtc, transform : RenderTransform, filter_len : UInt16, filter_name : LibC::Char*, filter_params_len : UInt32, filter_params : RenderFixed*) : VoidCookie
	fun xcb_randr_set_crtc_transform_filter_name(r : RandrSetCrtcransformRequest*) : LibC::Char*
		fun xcb_randr_set_crtc_transform_filter_name_end(r : RandrSetCrtcransformRequest*) : GenericIterator
	fun xcb_randr_set_crtc_transform_filter_name_length(r : RandrSetCrtcransformRequest*) : Int32
	fun xcb_randr_set_crtc_transform_filter_params(r : RandrSetCrtcransformRequest*) : RenderFixed*
		fun xcb_randr_set_crtc_transform_filter_params_end(r : RandrSetCrtcransformRequest*) : GenericIterator
	fun xcb_randr_set_crtc_transform_filter_params_length(r : RandrSetCrtcransformRequest*) : Int32
	fun xcb_randr_set_crtc_transform_sizeof(_buffer : Void*, filter_params_len : UInt32) : Int32
	fun xcb_randr_set_monitor(c : Connection*, window : Window, monitorinfo : RandrMonitorInfo*) : VoidCookie
	fun xcb_randr_set_monitor_checked(c : Connection*, window : Window, monitorinfo : RandrMonitorInfo*) : VoidCookie
	fun xcb_randr_set_monitor_monitorinfo(r : RandrSetMonitorRequest*) : RandrMonitorInfo*
		fun xcb_randr_set_monitor_sizeof(_buffer : Void*) : Int32
	fun xcb_randr_set_output_primary(c : Connection*, window : Window, output : RandrOutput) : VoidCookie
	fun xcb_randr_set_output_primary_checked(c : Connection*, window : Window, output : RandrOutput) : VoidCookie
	fun xcb_randr_set_panning(c : Connection*, crtc : RandrCrtc, timestamp : Timestamp, left : UInt16, top : UInt16, width : UInt16, height : UInt16, track_left : UInt16, track_top : UInt16, track_width : UInt16, track_height : UInt16, border_left : Int16, border_top : Int16, border_right : Int16, border_bottom : Int16) : RandrSetPanningCookie
	fun xcb_randr_set_panning_reply(c : Connection*, cookie : RandrSetPanningCookie, e : GenericError**) : RandrSetPanningReply*
		fun xcb_randr_set_panning_unchecked(c : Connection*, crtc : RandrCrtc, timestamp : Timestamp, left : UInt16, top : UInt16, width : UInt16, height : UInt16, track_left : UInt16, track_top : UInt16, track_width : UInt16, track_height : UInt16, border_left : Int16, border_top : Int16, border_right : Int16, border_bottom : Int16) : RandrSetPanningCookie
	fun xcb_randr_set_provider_offload_sink(c : Connection*, provider : RandrProvider, sink_provider : RandrProvider, config_timestamp : Timestamp) : VoidCookie
	fun xcb_randr_set_provider_offload_sink_checked(c : Connection*, provider : RandrProvider, sink_provider : RandrProvider, config_timestamp : Timestamp) : VoidCookie
	fun xcb_randr_set_provider_output_source(c : Connection*, provider : RandrProvider, source_provider : RandrProvider, config_timestamp : Timestamp) : VoidCookie
	fun xcb_randr_set_provider_output_source_checked(c : Connection*, provider : RandrProvider, source_provider : RandrProvider, config_timestamp : Timestamp) : VoidCookie
	fun xcb_randr_set_screen_config(c : Connection*, window : Window, timestamp : Timestamp, config_timestamp : Timestamp, size_id : UInt16, rotation : UInt16, rate : UInt16) : RandrSetScreenConfigCookie
	fun xcb_randr_set_screen_config_reply(c : Connection*, cookie : RandrSetScreenConfigCookie, e : GenericError**) : SetScreenConfigReply*
		fun xcb_randr_set_screen_config_unchecked(c : Connection*, window : Window, timestamp : Timestamp, config_timestamp : Timestamp, size_id : UInt16, rotation : UInt16, rate : UInt16) : RandrSetScreenConfigCookie
	fun xcb_randr_set_screen_size(c : Connection*, window : Window, width : UInt16, height : UInt16, mm_width : UInt32, mm_height : UInt32) : VoidCookie
	fun xcb_randr_set_screen_size_checked(c : Connection*, window : Window, width : UInt16, height : UInt16, mm_width : UInt32, mm_height : UInt32) : VoidCookie
end
