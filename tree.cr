def arrange(m, d)
	if !d.root
		return
	end

	rect = m.rectangle

	rect.x += m.padding.left + d.padding.left
	rect.y += m.padding.top + d.padding.top
	rect.width -= m.padding.left + d.padding.left + d.padding.right + m.padding.right
	rect.height -= m.padding.top + d.padding.top + d.padding.bottom + m.padding.bottom

	rect.x += d.window_gap
	rect.y += d.window_gap
	rect.width -= d.window_gap
	rect.height -= d.window_gap

	apply_layout(m, d, d.root, rect, rect)
end
