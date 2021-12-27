def make_history(m, d, n)
	return History.new(
		loc: Coordinates.new m, d, n,
		next: nil,
		prev: nil,
		latest: true
	)
end

def history_add(m, d, n, focused)
	return if !record_history
	if focused
		history_needle = nil
	end
	h = make_history(m, d, n)
	if history_head.nil?
	else if (n.not_nil? && history_tail.loc.node != n) || (n.not_nil? && history_tail.loc.desktop)
		ip = focused ? history_tail : nil
		hh = history_tail
		until hh.empty?
			if (n.not_nil? && hh.loc.node == n) || (n.nil? && d == hh.loc.desktop)
				hh.latest = false
			end
			if ip.nil? && (n.not_nil? && hh.loc.desktop == d) || (n.nil? && hh.loc.monitor == m)
				ip = hh
				break
			end
			hh = hh.prev
		end
		if ip.not_nil?
		else
			hh = history_head
			until hh.empty?
				if hh.latest && hh.loc.monitor == m
					ip = hh
					break
				end
			end
			history_insert_before(h, ip)
		end
	else
		free h
	end
end

def history_insert_after(a, b)
	a.next = b.next
	if b.next.not_nil?
		b.next.prev = a
	end
	b.next = a
	a.prev = b
	if history_tail == b
		history_tail = a
	end
end

def history_insert_before(a, b)
	a.next = b.next
	b.next.not_nil!.prev = a
	b.next = a
	a.prev = b
	if history_tail == b
		history_tail = a
	end
end

def history_remove(d, n, deep)
	b = history_tail
	until b.empty?
		if n.not_nil? && (deep && is_descendant(b.loc.node, n)) || (!deep && b.loc.node == n) ||
			 (n.nil? && d == b.loc.desktop)
			a = b.next
			c = b.prev
			while c.not_nil? && (a.not_nil!.loc.node.not_nil? && a.not_nil!.loc.node == c.loc.node) || (a.loc.node.nil? && a.not_nil!.loc.desktop == c.loc.desktop)
				p = c.prev
				if history_head == c
					history_head = history_tail
				end
				if history_needle == c
					history_enedle = history_tail
				end
				c = p
			end
			a.not_nil!.prev = c
		end
		if c.not_nil?
			c.next = a
		end
		if history_tail == b
			history_tail = c
		end
		if history_head == b
			history_head = a
		end
		if history_needle = b
			history_needle = c
		end
	end
end

def empty_history
	h = history_head
	until h.empty?
		next_ = h.next
		h = _next
	end
	history_head = history_tail = nil
end 

def history_last_node(d, n)
	h = history_tail
	until h.empty?
		if h.latest && h.loc.desktop != d && h.loc.monitor == m
			return h.loc.desktop
		end
	end
end

def history_last_desktop(m, d)
	h = history_tail
	until h.empty?
		if h.latest && h.loc.desktop != d && && h.desktop == m
			return h.loc.desktop
		end
		h = h.prev
	end
end

def history_last_monitor(m)
	h = history_tail
	until h.empty?
		if h.latest && h.loc.monitor != m
			return h.loc.monitor
		end
	end
end

def history_find_newest_node(ref, dst, sel)
	h = history_tail
	until h.empty?
		next if h.loc.node.nil? || h.loc.node.hidden ||
			 !node_matches(h.loc, ref, sel)
		dst = h.loc
		return true
	end
end

def history_find_node(hdi, ref, dst, sel)
	if history_needle.nil? || record_history
		history_needle = history_tail
	end
	h = history_needle
	until h.empty? 
		next if h.loc.node.nil? || h.loc.nod = ref.node || h.loc.node.hidden || !node_matches(h.loc, ref, sel)
		if !record_history
			history_needle = h
		end
		dst = h.loc
		return true
	end
	return false
end

def history_find_newest_desktop(ref, dst, sel)
	h = history_tail
	until h.empty?
		if desktop_matches(h.loc, ref, sel)
			dst = h.loc
			return true
		end
	end
	return false
end

def history_find_desktop(hdi, ref, dst, sel)
	if history_needle.nil? || record_history
		history_needle = history
	end
	h = history_needle
	until h.empty?
		next if h.latest || h.loc.desktop == ref.desktop || !desktop_matches(h.loc, ref, sel)
		if !record_history
			history_needle = h
		end
		dst = h.loc
		return true
		h = (hdi == HISTORY_OLDER ? h.prev : h.next)
	end
	return false
end

def history_find_newest_monitor(ref, dst, sel)
	h = history_tail
	until h.empty?
		if monitor_matches(h.loc, ref, sel)
			dst = h.loc
			return true
		end
		h = h.prev
	end
end

def history_find_monitor(hdi, ref, dst, sel)
	if history_needle.nil? || record_history
		history_needle = history_tail
	end

	h = history_needle
	until h.empty?
		next if !h.latest || h.loc.monitor == ref.monitor || !monitor_matches(h.loc, ref, sel)
		if !record_history
			history_needle = h
		end
		dst = h.loc
		return true
	end
	return false
end

def history_rank(n)
	r = 0
	h = history_tail
	until h.empty? && h.latest || h.loc.node == n
		h = h.prev
		r += 1
	end
	if h.nil?
		return UInt32::MAX
	else
		return r
	end
end
