@[Link("libsn")]
lib LibSn
	struct SnMemVTable
		malloc : (Int32 -> Void*)
		realloc : (Void*, Int32 -> Void*)
		free : (Void* -> Void)
		calloc : (Int32, Int32 -> Void*)
		try_malloc : (Int32 -> Void*)
		try_realloc : (Void*, Int32 -> Void*)
		padding1 : SnPaddingFunc
		padding2 : SnPaddingFunc
	end

	type SnLauncheeContext = Void*
		type SnLauncherContext = Void*
		type SnMonitorContext = Void*
		type SnMonitorEvent = Void*
		type SnStartupSequence = Void*
		type Connection = Void*

		alias SnDisplay = Int32
	alias SnDisplayErrorTrapPop = (SnDisplay*, Int32* -> Void)
	alias SnDisplayErrorTrapPush = (SnDisplay*, Int32* -> Void)
	alias SnMonitorEventFunc = (SnMonitorEvent, Void* -> Void)
	alias SnPaddingFunc = (-> Void)
	alias SnUtf8ValidateFunc = (Char*, Int32 -> Int32)
	alias SnXcbDisplayErrorTrapPop = (SnDisplay*, Connection -> Void)
	alias SnXcbDisplayErrorTrapPush = (SnDisplay*, Connection -> Void)

	enum SnMonitorEventType
		SnMonitorEventInitiated = 0
		SnMonitorEventCompleted = 1
		SnMonitorEventChanged   = 2
		SnMonitorEventCanceled  = 3
	end

	fun sn_display_error_trap_pop(display : SnDisplay*)
	fun sn_display_error_trap_push(display : SnDisplay*)
	fun sn_display_get_x_connection(display : SnDisplay*) : Connection
	fun sn_display_get_x_display : Int32*
		fun sn_display_new(xdisplay : Int32*, push_trap_func : SnDisplayErrorTrapPush, pop_trap_func : SnDisplayErrorTrapPop) : SnDisplay*
		fun sn_display_process_event : Int32
	fun sn_display_ref(display : SnDisplay*)
	fun sn_display_unref(display : SnDisplay*)
	fun sn_free(mem : Void*)
	fun sn_launchee_context_complete(context : SnLauncheeContext)
	fun sn_launchee_context_get_id_has_timestamp(context : SnLauncheeContext) : Int32
	fun sn_launchee_context_get_startup_id(context : SnLauncheeContext) : Char*
		fun sn_launchee_context_get_timestamp : Int32
	fun sn_launchee_context_new(display : SnDisplay*, screen : Int32, startup_id : Char*) : SnLauncheeContext
	fun sn_launchee_context_new_from_environment(display : SnDisplay*, screen : Int32) : SnLauncheeContext
	fun sn_launchee_context_ref(context : SnLauncheeContext)
	fun sn_launchee_context_setup_window(context : SnLauncheeContext, xwindow : Int32)
	fun sn_launchee_context_unref(context : SnLauncheeContext)
	fun sn_launcher_context_complete(context : SnLauncherContext)
	fun sn_launcher_context_get_initiated : Int32
	fun sn_launcher_context_get_initiated_time(context : SnLauncherContext, tv_sec : Int64*, tv_usec : Int64*)
	fun sn_launcher_context_get_last_active_time(context : SnLauncherContext, tv_sec : Int64*, tv_usec : Int64*)
	fun sn_launcher_context_get_startup_id(context : SnLauncherContext) : Char*
		fun sn_launcher_context_initiate(context : SnLauncherContext, launcher_name : Char*, launchee_name : Char*, timestamp : Int32)
	fun sn_launcher_context_new(display : SnDisplay*, screen : Int32) : SnLauncherContext
	fun sn_launcher_context_ref(context : SnLauncherContext)
	fun sn_launcher_context_set_application_id(context : SnLauncherContext, desktop_file : Char*)
	fun sn_launcher_context_set_binary_name(context : SnLauncherContext, name : Char*)
	fun sn_launcher_context_set_description(context : SnLauncherContext, description : Char*)
	fun sn_launcher_context_set_extra_property(context : SnLauncherContext, name : Char*, value : Char*)
	fun sn_launcher_context_set_icon_name(context : SnLauncherContext, name : Char*)
	fun sn_launcher_context_set_name(context : SnLauncherContext, name : Char*)
	fun sn_launcher_context_set_wmclass(context : SnLauncherContext, klass : Char*)
	fun sn_launcher_context_set_workspace(context : SnLauncherContext, workspace : Int32)
	fun sn_launcher_context_setup_child_process(context : SnLauncherContext)
	fun sn_launcher_context_unref(context : SnLauncherContext)
	fun sn_malloc(n_bytes : Int32) : Void*
		fun sn_malloc0(n_bytes : Int32) : Void*
		fun sn_mem_is_system_malloc : Int32
	fun sn_mem_set_vtable(vtable : SnMemVTable*)
	fun sn_monitor_context_new(display : SnDisplay*, screen : Int32, event_func : SnMonitorEventFunc, event_func_data : Void*, free_data_func : Int32) : SnMonitorContext
	fun sn_monitor_context_ref(context : SnMonitorContext)
	fun sn_monitor_context_unref(context : SnMonitorContext)
	fun sn_monitor_event_copy(event : SnMonitorEvent) : SnMonitorEvent
	fun sn_monitor_event_get_context(event : SnMonitorEvent) : SnMonitorContext
	fun sn_monitor_event_get_startup_sequence(event : SnMonitorEvent) : SnStartupSequence
	fun sn_monitor_event_get_type(event : SnMonitorEvent) : SnMonitorEventType
	fun sn_monitor_event_ref(event : SnMonitorEvent)
	fun sn_monitor_event_unref(event : SnMonitorEvent)
	fun sn_realloc(mem : Void*, n_bytes : Int32) : Void*
		fun sn_set_utf8_validator(validate_func : SnUtf8ValidateFunc)
	fun sn_startup_sequence_complete(sequence : SnStartupSequence)
	fun sn_startup_sequence_get_application_id(sequence : SnStartupSequence) : Char*
		fun sn_startup_sequence_get_binary_name(sequence : SnStartupSequence) : Char*
		fun sn_startup_sequence_get_completed : Int32
	fun sn_startup_sequence_get_description(sequence : SnStartupSequence) : Char*
		fun sn_startup_sequence_get_icon_name(sequence : SnStartupSequence) : Char*
		fun sn_startup_sequence_get_id(sequence : SnStartupSequence) : Char*
		fun sn_startup_sequence_get_initiated_time(sequence : SnStartupSequence, tv_sec : Int64*, tv_usec : Int64*)
	fun sn_startup_sequence_get_last_active_time(sequence : SnStartupSequence, tv_sec : Int64*, tv_usec : Int64*)
	fun sn_startup_sequence_get_name(sequence : SnStartupSequence) : Char*
		fun sn_startup_sequence_get_screen(sequence : SnStartupSequence) : Int32
	fun sn_startup_sequence_get_timestamp : Int32
	fun sn_startup_sequence_get_wmclass(sequence : SnStartupSequence) : Char*
		fun sn_startup_sequence_get_workspace(sequence : SnStartupSequence) : Int32
	fun sn_startup_sequence_ref(sequence : SnStartupSequence)
	fun sn_startup_sequence_unref(sequence : SnStartupSequence)
	fun sn_try_malloc(n_bytes : Int32) : Void*
		fun sn_try_realloc(mem : Void*, n_bytes : Int32) : Void*
		fun sn_xcb_display_new(xconnection : Connection, push_trap_func : SnXcbDisplayErrorTrapPush, pop_trap_func : SnXcbDisplayErrorTrapPop) : SnDisplay*
		fun sn_xcb_display_process_event : Int32
end
