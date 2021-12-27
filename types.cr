struct ICCCMProps
	take_focus : Bool
	input_hint : Bool
	delete_window : Bool
end

struct NodeSelect
	automatic : Bool
	focused : Bool
	active : Bool
	local : Bool
	leaf : Bool
	window : Bool
	tiled : Bool
	psuedo_tiled : Bool
	floating : Bool
	fullscreen : Bool
	hidden : Bool
	sticky : Bool
	private_ : Bool
	locked : Bool
	marked : Bool
	urgent : Bool
	same_class : Bool
	descendant_of : Bool
	ascenstor_of : Bool
	below : Bool
end

struct DesktopSelect
	occupied : Bool
	focused : Bool
	active : Bool
	urgent : Bool
	local : Bool
	tiled : Bool
	monocle : Bool
	user_tiled : Bool
	user_monocle : Bool
end

struct MonitorSelect
	occupied : Bool
	focused : Bool
end

struct IcccmProps
	take_focus : Bool
	input_focus : Bool
	delete_window : Bool
end

struct Client
	class_name : String
	instance_name : String
	name : String
	border_width : UInt32
	urgent : Bool
	shown : Bool
	state : ClientState
	last_state : ClientState
	layer : StackLayer
	last_layer : StackLayer
	floating_rectangle : Rectangle
	tiled_rectangle : Rectangle
	size_hints : SizeHints
	icccm_props : IcccmProps
	wm_flags : WmFlags
end

struct Constraints
	min_width : UInt16
	min_height : UInt16
end

struct Padding
	top : Int32
	right : Int32
	bottom : Int32
	left : Int32
end

struct History
	property loc : Coordinates
	property latest : Bool
	property deque : Deque(History)
end

struct Coordinates
	monitor : Monitor
	desktop : Desktop
end

struct Rule
	property deque : Deque(Rule)
end

struct PendingRule
	fd : Int32
	win : Window
	csq : RuleConsequence
	deque : Deque(PendingRule)
end
