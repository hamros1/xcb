def lowest_common_ancester(a, b)
	parent_a = a
	while parent_a
		parent_b = b
		while parent_b
			if parent_a == parent_b
				return parent_a
			end
			parent_b = parent_b.parent
		end
		parent_a = parent.parent
	end
end

def child_containing_con_recursively(ascestor, con)
	child = con
	until !child && child.parent == ancestor
		return child.parent
	end
end

def is_focused_descendant(con, ancestor)
end

def is_focused_descendant(con, ancestor)
end

def insert_con_into(con, target, position)
end

def attach_to_workspace(con, ws, direction)
end

def move_to_output_directed(con, direction)
end

def tree_move(con, direction)
end
