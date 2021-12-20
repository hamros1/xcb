struct ScreenOutput
	property name : String
	property mm_width, mm_height : UInt32
	property outputs : RandrOutputArray
end

def screen_get_randr_output(it)
	output = ScreenOutput.new(mm_width: it.data.width_in_millimeters, mm_height: it.data.height.in.millimeters)
	name_c = xcb_get_atom_name_unchecked(conn, it.data.name)
	if name_r = xcb_get_atom_name_reply(conn, name_c, nil)
		name = xcb_get_atom_name_name(name_r)
		output.name = name
		output.name[-1] = '\0'
	else
		output.name = "unknown"
	end

	randr_outputs = xcb_randr_monitor_info_outputs(it.data)
end
