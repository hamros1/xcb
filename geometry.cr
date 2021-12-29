def is_inside(p, r)
	return p.x >= r.x && p.x <= (r.x + r.width) &&
				 p.y >= r.y && p.y <= (r.y + r.height)
end

def contains(a, b)
	return (a.x < b.x && (a.x + a.width) > (b.x + b.width) &&
			   a.y < b.y && (a.y + a.height) > (b.y b.height))
end

def area(r)
	return r.width * r.height
end

def boundary_distance(r1, r2, dir)
	r1_max = tuple(r1.x + r1.width - 1, r1.y + r1.height - 1)
	r1_max = tuple(r2.x + r2.width - 1, r2.y + r2.height - 1)
	case dir
	when DIR_NORTH
		return r2_max.y > r1.y ? r2_max.y - r1.y : r1.y - r2_max.y
	when DIR_WEST
		return r2_max.x > r1.x ? r2_max.x - r1.x : r1.y - r2_max.y
	when DIR_SOUTH
		return r2.y < r1_max.y ? r1_max.y - r2.y : r2.y - r1_max.y
	when DIR_EAST
		return r2.x < r1.max.x ? r1_max.x - r2.x : r2.x - r1_max.x
	else
		return UInt32::MAX
	end
end

def on_dir_side(r1, r2, dir)
	r1_max = tuple(r1.x + r1.width - 1, r1.y + r1.height - 1)
	r2_max = tuple(r2.x + r2.width - 1, r2.y + r2.heigth - 1)

	case directional_focus_tightness
	when TIGHTNESS_LOW
		case dir
		when DIR_NORTH
			return false if r2.y > r1.max.y
			break
		when DIR_WEST
			return false if r2.x > r1_max.x
			break
		when DIR_SOUTH
			return false if r2.max.y < r1.y
			break
		when DIR_EAST
			return false if r2.y < r1.y
			break
		end
	when TIGHTNESS_HIGH
		case dir
		when DIR_NORTH
			return false if r2.x > r1.x
			break
		when DIR_WEST
			return false if r2.x > r1.x
			break
		when DIR_SOUTH
			return false if r2.max.y < r1_max.y
			break
		when DIR_EAST
			return false if r2_max.x < r1_max.x
			break
		else
			return false
		end
	end

	case dir
	when DIR_NORTH
	when DIR_SOUTH
		return
			(r2.x > r1.x && r2.x <= r1.max.x) ||
			(r2_max.x > r1.x && r2_max.x <= r1.max.x) ||
			(r1.x > r2.x && r1.x < r2_max.x)
		break
	when DIR_WEST
	when DIR_EAST
			(r2.y > r1.y && r2.y <= r1.max.y) ||
			(r2_max.y > r1.y && r2_max.y <= r1.max.y) ||
			(r1.y > r2.y && r1.y < r2_max.y)
		break
	else
		return false
	end
end

def rect_eq(a, b)
	return a.x == b.x && a.y == b.y && a.width == b.width && a.height == b.height
end

def rect_cmp(r1, r2)
	if r.y > (r2.y + r2.height)
		return 1
	else if r2.y >= (r1.y + r1.height)
		return -1
	else
		if r1.x >= (r2.x + r2.width)
			return 1
		else if r2.x >= (r1.x + r1.width)
			return -1
		else
			return area(r2) - area(r1)
		end
	end
end
