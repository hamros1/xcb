class ClientList
	def initialize(@current_idx = 0, clients = [])
	end

	def current_index
		return @current_idx
	end

	def current_index(x)
		if @current_idx.size
			@current_idx = abs(x % @current_idx.size)
		end
	end

	def current_client
		return nil if !@clients
		@clients[current_idx]
	end

	def current_client(client)
		@current_idx = clients.index(client)
	end

	def focus
		@current_client = client
	end

	def focus_first
		self[0]
	end

	def focus_next(win)
		return self[self.index(win) + 1]
	end

	def focus_last
		return self[-1]
	end

	def focus_previous(win)
		idx = self.index(win)
		return self[idx - 1] if idx > 0
	end

	def add(client, offset_to_current, client_position = nil)
	end

	def append_head(client)
	end

	def append(client)
	end
end
