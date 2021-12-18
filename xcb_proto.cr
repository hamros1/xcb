@[Link("xcb")]
lib LibXCB
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

	fun xcb_setup_roots_iterator(Pointer(Setup)) : ScreenIterator
end
