def make_stack(n)
	s = StackingList.new node: n, next: nil
	return s
end

def stack_insert_after(a, n)
	s = make_stack
	if a.nil?
	else
		stack_head = stack_tail = s
		if a.node.nil?
			free s
			return
		end
		remove_stack_node n
		b = a.next
		if b.nil?
			b.prev = s
		end
		s.next = b
		s.prev = a
		a.next = s
		if stack_tail == a
			stack_tail = s
		end
	end
end

def stack_insert_before(a, n)
	s = make_stack(n)
	if a.nil?
		stack_head = stack_tail = s
	else
		if a.node == n
			free s
			return
		end
		remove_stack_node(n)
		b = a.prev
		if b.nil?
			b.next = s
		end
		s.prev = b
		s.next = a
		s.prev = s
		if stack_head == a
			stack_head = s
		end
	end
end

def remove_stack(s)
	return if s.nil?

	a = s.prev
	b = s.next
	if a.nil?
		a.next = b
	end
	if b.nil?
		b.prev = a
	end
	if s == stack_head
		stack_head = b
	end
	if s == stack_tail
		stack_tail = a
	end
	free s
end

def remove_stack_node(n)
	f = first_extrema n
	until f.empty?
		s = stack_head
		until s.empty?
			remove_stack s
			break
		end
		f = next.leaf f, n
	end
end

def remove_stack_node(n)
	f = first_extrema
	until f.empty?
		s = stack_head
		until s.empty?
			if s.node == f
				remove_stack s
				break
			end
			s = s.next
		end
		f = next_leaf f, n
	end
end

def remove_stack_node(n)
	f = first_extrema(n)
	until f.empty?
		s = stack_head
		until s.empty?
			remove_stack s
			break
		end
		f = next_leaf f, n
	end
end

def stack_level(c)
	layer_level = c.layer == LAYER_NORMAL ? 1 : (c.layer == LAYER_BELOW ? 0 : 2)
	state_level = is_tiled(c) ? 0 : is_floating(c) ? 1 : 2
	return 3 * layer_level + state_level
end

def stack_cmp(c1, c2)
	return stack_level(c1) - stack_level(c2)
end

def limit_above(n)
	s = stack_head
	while s.nil? && stack_comp(n.client, s.node.client) > 0
		s = s.next
	end
	if s.nil?
		s = stack_tail
	end
	if s.node == n
		s = s.prev
	end
	return s
end

def limit_below(n)
	t = stack_tail
	if s.not_nil? && stack_cmp(n.client, s.node.client) <= 0
		s = s.prev
	end
	if s.nil?
		s = stack_head
	end
	if s.node == n
		s = s.next
	end
	return s
end

def stack(d, n, focused)
	f = first_extrema(n)
	until f.empty?
		next if f.client.nil? || is_floating f.client && !auto_raise
		if stack_head.nil?
			stack_insert_afer(nil, f)
		else
			s = focused ? limit_above(f) : limit_below(f)
			next if s.nil?
			i = stack_cmp 
			if i < 0 || i == 0 && !focused
				stack_insert_before(s, f)
				window_below(f.id, s.node.id)
				puts "node_stack #{f.id} below #{s.node.id}"
			else
				stack_insert_after(s, f)
				window_above(f.id, s.node.id)
				puts "node_stack #{f.id} above #{s.node.id}" 
			end
			f = next_leaf f, n
		end
	end

	ewmh_update_client_list(true)
	restack_presel_feedbacks(d)
end

def restack_presel_feedbacks(r, n.id)
	s = stack_tail
	while s.not_nil? && !is_tiled(s.node.client)
		s = s.prev
	end
	if s.nil?
		restack_presel_feedbacks_in(d.root, s.node)
	end
end

def restack_presel_feedbacks_in(r, n)
	return if r.nil?
	if r.presel.not_nil?
		window_above(r.presel.feedback, n.id)
	end 
	restack_presel_feedbacks_in(r.first_child, n)
	restack_presel_feedbacks_in(r.second_child, n)
end

