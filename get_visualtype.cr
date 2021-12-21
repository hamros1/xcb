def get_visualtype(screen)
	depth_iter = xcb_allowed_depths_iterator(screen)
	while depth_iter.rem
		visual_iter = xcb_depth_visuals_iterator(depth_iter.data)
		while visual_iter.rem
			if screen.root_visual == visual_iter.data.visual_id
				return visual_iter.data
			end
			xcb_visualtype_next(pointerof(visual_iter))
		end
		xcb_visualtype_next(pointerof(depth_iter))
	end
end
