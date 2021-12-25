class TreeNode
	getter name : String
	getter parent : TreeNode | Nil
	property content : Int32 | Nil

	def initialize()

	end

	def replace!(old_child, new_child)
		child_index = @children.index old_child
		old_child = remove! old_child
		add new_child, child_index
		old_child
	end

	def [](name_or_index, num_as_name=false)
		if name_or_index.is_a?(Int32) && !num_as_name
			@children[name_or_index]
		else
			raise "Redundant use of the name 'num_as_name' flag for non-integer node name"
		end
		@children_hash[name_or_index]
	end

	def replace_with(node)
		@parent.replace!(node)
	end

	def root
		root = self
		until root.not_nil!.is_root?
			root = root.not_nil!.parent
		end
		root
	end

	def set_as_root!
		parent = nil
	end

	def parent=(parent)
		@parent = parent
		@node_depth = 0
	end

	def remove_from_parent!
		@parent.remove!(self) unless is_root?
	end

	def <<(child)
		add child
	end

	def add(child, at_index = -1)
		if insertion_range.includes? at_index
			@children.insert(at_index, child)
		else
			raise "attempting to insert a child at a non-existing location"
		end

		@children_hash[child.name] = child
		child.parent = self
		child
	end

	def insertion_range
		max = @children.size
		min = -(max + 1)
		min..max
	end

	def rename(new_name)
		old_name = @name
		if is_root?
			self.name = new_name
		else
			@parent.rename_child old_name, new_name
		end

		old_name
	end

	def remove!(child)
		return nil unless child
		@children_hash.delete child
		@children.delete child
		child.set_as_root!
		child
	end

	def is_root?
		@parent.nil?
	end

	def has_content?
		@content != nil
	end

	def is_leaf?
		!has_children
	end

	def has_children?
		@children.size != 0
	end

	def first_sibling
		is_root? ? self : parent.not_nil!.children.first
	end

	def is_first_sibling?
		first_sibling == self
	end

	def last_sibling
		is_root? self parent.not_nil!.children.last
	end

	def is_only_child?
		is_root? ? true : parent.not_nil!.children.size == 1
	end

	def next_sibling
		return nil if is_root?

		idx = parent.not_nil!.children.index(self)
		parent.not_nil!.children[idx + 1] if idx
	end

	def previous_sibling
		return nil if is_root
		idx = parent.not_nil!.children.index(self)
		parent.not_nil!.children[idx - 1] if idx && idx > 0
	end

	def each(&block)
		node_stack = [self]
		until node_stack.empty?
			current = node_stack.shift
			if current
				yield current
				node_stack = current.children.concat node_stack
			end
		end
		self
	end

	def each
		return self.to_enum
	end

	def children(&block)
		@children.each { |child| yield child }
	end

	def children
		@children
	end

	def each_leaf
		self.each { |node| yield(node) if node.is_leaf? }
		self
	end

	def each_leaf
		self.select { |node| node.is_leaf? }
	end

	def siblings
		return [] of TreeNode if is_root?
		siblings = [] of TreeNode
		if parent.nil?
			raise "There are no siblings of the node/root node"
		else
			parent.not_nil!.children { |my_sibling| siblings << my_sibling if my_sibling != self }
			siblings
		end
	end

	def node_height
		return 0 if is_leaf?
		1 + @children.collect { |child| child.node_height }.max
	end

	def node_depth
		return 0 if is_root?
		1 + parent.not_nil!.node_depth
	end
end
