@[Link("xcb")
	lib LibXCB
		struct SyncAlarmError
			response_type : UInt8
			error_code : UInt8
			sequence : UInt16
			bad_alarm : UInt32
			minor_opcode : UInt16
			major_opcode : UInt8
		end

		struct SyncAlarmIterator
			data : SyncAlarm*
			rem : Int32
			index : Int32
		end

		struct SyncAlarmNotifyEvent
			response_type : UInt8
			kind : UInt8
			sequence : UInt16
			alarm : SyncAlarm
			counter_value : Int64
			alarm_value : Int64
			timestamp : Timestamp
			state : UInt8
			pad0 : UInt8[3]
		end

		struct SyncAwaitFenceRequest
			major_opcode : UInt8
			minor_opcode : UInt8
			length : UInt16
		end

		struct SyncAwaitRequest
			major_opcode : UInt8
			minor_opcode : UInt8
			length : UInt16
		end

		struct SyncChangeAlarmRequest
			major_opcode : UInt8
			minor_opcode : UInt8
			length : UInt16
			id : SyncAlarm
			value_mask : UInt32
		end

		struct SyncChangeAlarmValueList
			counter : SyncCounter
			value_type : UInt32
			value : Int64
			test_type : UInt32
			delta : Int64
			events : UInt32
		end

		struct SyncChangeCounterRequest
			major_opcode : UInt8
			minor_opcode : UInt8
			length : UInt16
			counter : SyncCounter
			amount : Int64
		end

		struct SyncCounterError
			response_type : UInt8
			error_code : UInt8
			sequence : UInt16
			bad_counter : UInt32
			minor_opcode : UInt16
			major_opcode : UInt8
		end

		struct SyncCounterIterator
			data : SyncCounter*
			rem : Int32
			index : Int32
		end

		struct SyncCounterNotifyEvent
			response_type : UInt8
			kind : UInt8
			sequence : UInt16
			counter : SyncCounter
			wait_value : Int64
			counter_value : Int64
			timestamp : Timestamp
			count : UInt16
			destroyed : UInt8
			pad0 : UInt8
		end

		struct SyncCreateAlarmRequest
			major_opcode : UInt8
			minor_opcode : UInt8
			length : UInt16
			id : SyncAlarm
			value_mask : UInt32
		end

		struct SyncCreateAlarmValueList
			counter : SyncCounter
			value_type : UInt32
			value : Int64
			test_type : UInt32
			delta : Int64
			events : UInt32
		end

		struct SyncCreateCounterRequest
			major_opcode : UInt8
			minor_opcode : UInt8
			length : UInt16
			id : SyncCounter
			initial_value : Int64
		end

		struct SyncCreateFenceRequest
			major_opcode : UInt8
			minor_opcode : UInt8
			length : UInt16
			drawable : Drawable
			fence : SyncFence
			initially_triggered : UInt8
		end

		struct SyncDestroyAlarmRequest
			major_opcode : UInt8
			minor_opcode : UInt8
			length : UInt16
			alarm : SyncAlarm
		end

		struct SyncDestroyCounterRequest
			major_opcode : UInt8
			minor_opcode : UInt8
			length : UInt16
			counter : SyncCounter
		end

		struct SyncDestroyFenceRequest
			major_opcode : UInt8
			minor_opcode : UInt8
			length : UInt16
			fence : SyncFence
		end

		struct SyncFenceIterator
			data : SyncFence*
			rem : Int32
			index : Int32
		end

		struct SyncGetPriorityCookie
			sequence : UInt32
		end

		struct SyncGetPriorityReply
			response_type : UInt8
			pad0 : UInt8
			sequence : UInt16
			length : UInt32
			priority : Int32
		end

		struct SyncGetPriorityRequest
			major_opcode : UInt8
			minor_opcode : UInt8
			length : UInt16
			id : UInt32
		end

		struct SyncInitializeCookie
			sequence : UInt32
		end

		struct SyncInitializeReply
			response_type : UInt8
			pad0 : UInt8
			sequence : UInt16
			length : UInt32
			major_version : UInt8
			minor_version : UInt8
			pad1 : StaticArray(UInt8, 22)
		end

		struct SyncInitializeRequest
			major_opcode : UInt8
			minor_opcode : UInt8
			length : UInt16
			desired_major_version : UInt8
			desired_minor_version : UInt8
		end

		struct Int64Iterator
			data : Int64*
			rem : Int32
			index : Int32
		end

		struct Int64
			hi : Int32
			lo : UInt32
		end

		struct SyncListSystemCountersCookie
			sequence : UInt32
		end

		struct SyncListSystemCountersReply
			response_type : UInt8
			pad0 : UInt8
			sequence : UInt16
			length : UInt32
			counters_len : UInt32
			pad1 : StaticArray(UInt8, 20)
		end

		struct SyncListSystemCountersRequest
			major_opcode : UInt8
			minor_opcode : UInt8
			length : UInt16
		end

		struct SyncQueryAlarmCookie
			sequence : UInt32
		end

		struct SyncQueryAlarmReply
			response_type : UInt8
			pad0 : UInt8
			sequence : UInt16
			length : UInt32
			trigger : SyncTrigger
			delta : Int64
			events : UInt8
			state : UInt8
			pad1 : StaticArray(UInt8, 2)
		end

		struct SyncQueryAlarmRequest
			major_opcode : UInt8
			minor_opcode : UInt8
			length : UInt16
			alarm : SyncAlarm
		end

		struct SyncQueryCounterCookie
			sequence : UInt32
		end

		struct SyncQueryCounterReply
			response_type : UInt8
			pad0 : UInt8
			sequence : UInt16
			length : UInt32
			counter_value : Int64
		end

		struct SyncQueryCounterRequest
			major_opcode : UInt8
			minor_opcode : UInt8
			length : UInt16
			counter : SyncCounter
		end

		struct SyncQueryFenceCookie
			sequence : UInt32
		end

		struct SyncQueryFenceReply
			response_type : UInt8
			pad0 : UInt8
			sequence : UInt16
			length : UInt32
			triggered : UInt8
			pad1 : StaticArray(UInt8, 23)
		end

		struct SyncQueryFenceRequest
			major_opcode : UInt8
			minor_opcode : UInt8
			length : UInt16
			fence : SyncFence
		end

		struct SyncResetFenceRequest
			major_opcode : UInt8
			minor_opcode : UInt8
			length : UInt16
			fence : SyncFence
		end

		struct SyncSetCounterRequest
			major_opcode : UInt8
			minor_opcode : UInt8
			length : UInt16
			counter : SyncCounter
			value : Int64
		end

		struct SyncSetPriorityRequest
			major_opcode : UInt8
			minor_opcode : UInt8
			length : UInt16
			id : UInt32
			priority : Int32
		end

		struct SyncSystemcounterIterator
			data : SyncSystemcounter*
			rem : Int32
			index : Int32
		end

		struct SyncSystemcounter
			counter : SyncCounter
			resolution : Int64
			name_len : UInt16
		end

		struct SyncTriggerFenceRequest
			major_opcode : UInt8
			minor_opcode : UInt8
			length : UInt16
			fence : SyncFence
		end

		struct SyncTriggerIterator
			data : SyncTrigger*
			rem : Int32
			index : Int32
		end

		struct SyncTrigger
			counter : SyncCounter
			wait_type : UInt32
			wait_value : Int64
			test_type : UInt32
		end

		fun xcb_sync_alarm_end(i : SyncAlarmIterator) : GenericIterator
		fun xcb_sync_alarm_next(i : SyncAlarmIterator*)
		fun xcb_sync_await(c : Connection, wait_list_len : UInt32, wait_list : SyncWaitcondition*) : VoidCookie
		fun xcb_sync_await_checked(c : Connection, wait_list_len : UInt32, wait_list : SyncWaitcondition*) : VoidCookie
		fun xcb_sync_await_fence(c : Connection, fence_list_len : UInt32, fence_list : SyncFence*) : VoidCookie
		fun xcb_sync_await_fence_checked(c : Connection, fence_list_len : UInt32, fence_list : SyncFence*) : VoidCookie
		fun xcb_sync_await_fence_fence_list(r : SyncAwaitFenceRequest*) : SyncFence*
			fun sync_await_fence_fence_list_end = xcb_sync_await_fence_fence_list_end(r : SyncAwaitFenceRequest*) : GenericIterator
		fun xcb_sync_await_fence_fence_list_length(r : SyncAwaitFenceRequest*) : Int32
		fun xcb_sync_await_fence_sizeof(_buffer : Void*, fence_list_len : UInt32) : Int32
		fun xcb_sync_await_sizeof(_buffer : Void*, wait_list_len : UInt32) : Int32
		fun xcb_sync_await_wait_list(r : SyncAwaitRequest*) : SyncWaitcondition*
			fun xcb_sync_await_wait_list_iterator(r : SyncAwaitRequest*) : SyncWaitconditionIterator
		fun xcb_sync_await_wait_list_length(r : SyncAwaitRequest*) : Int32
		fun xcb_sync_change_alarm(c : Connection, id : SyncAlarm, value_mask : UInt32, value_list : Void*) : VoidCookie
		fun xcb_sync_change_alarm_aux(c : Connection, id : SyncAlarm, value_mask : UInt32, value_list : SyncChangeAlarmValueList*) : VoidCookie
		fun xcb_sync_change_alarm_aux_checked(c : Connection, id : SyncAlarm, value_mask : UInt32, value_list : SyncChangeAlarmValueList*) : VoidCookie
		fun xcb_sync_change_alarm_checked(c : Connection, id : SyncAlarm, value_mask : UInt32, value_list : Void*) : VoidCookie
		fun xcb_sync_change_alarm_sizeof(_buffer : Void*) : Int32
		fun xcb_sync_change_alarm_value_list(r : SyncChangeAlarmRequest*) : Void*
			fun xcb_sync_change_alarm_value_list_serialize(_buffer : Void**, value_mask : UInt32, _aux : SyncChangeAlarmValueList*) : Int32
		fun xcb_sync_change_alarm_value_list_sizeof(_buffer : Void*, value_mask : UInt32) : Int32
		fun xcb_sync_change_alarm_value_list_unpack(_buffer : Void*, value_mask : UInt32, _aux : SyncChangeAlarmValueList*) : Int32
		fun xcb_sync_change_counter(c : Connection, counter : SyncCounter, amount : Int64) : VoidCookie
		fun xcb_sync_change_counter_checked(c : Connection, counter : SyncCounter, amount : Int64) : VoidCookie
		fun xcb_sync_counter_end(i : SyncCounterIterator) : GenericIterator
		fun xcb_sync_counter_next(i : SyncCounterIterator*)
		fun xcb_sync_create_alarm(c : Connection, id : SyncAlarm, value_mask : UInt32, value_list : Void*) : VoidCookie
		fun xcb_sync_create_alarm_aux(c : Connection, id : SyncAlarm, value_mask : UInt32, value_list : SyncCreateAlarmValueList*) : VoidCookie
		fun xcb_sync_create_alarm_aux_checked(c : Connection, id : SyncAlarm, value_mask : UInt32, value_list : SyncCreateAlarmValueList*) : VoidCookie
		fun xcb_sync_create_alarm_checked(c : Connection, id : SyncAlarm, value_mask : UInt32, value_list : Void*) : VoidCookie
		fun xcb_sync_create_alarm_sizeof(_buffer : Void*) : Int32
		fun xcb_sync_create_alarm_value_list(r : SyncCreateAlarmRequest*) : Void*
			fun xcb_sync_create_alarm_value_list_serialize(_buffer : Void**, value_mask : UInt32, _aux : SyncCreateAlarmValueList*) : Int32
		fun xcb_sync_create_alarm_value_list_sizeof(_buffer : Void*, value_mask : UInt32) : Int32
		fun xcb_sync_create_alarm_value_list_unpack(_buffer : Void*, value_mask : UInt32, _aux : SyncCreateAlarmValueList*) : Int32
		fun xcb_sync_create_counter(c : Connection, id : SyncCounter, initial_value : Int64) : VoidCookie
		fun xcb_sync_create_counter_checked(c : Connection, id : SyncCounter, initial_value : Int64) : VoidCookie
		fun xcb_sync_create_fence(c : Connection, drawable : Drawable, fence : SyncFence, initially_triggered : UInt8) : VoidCookie
		fun xcb_sync_create_fence_checked(c : Connection, drawable : Drawable, fence : SyncFence, initially_triggered : UInt8) : VoidCookie
		fun xcb_sync_destroy_alarm(c : Connection, alarm : SyncAlarm) : VoidCookie
		fun xcb_sync_destroy_alarm_checked(c : Connection, alarm : SyncAlarm) : VoidCookie
		fun xcb_sync_destroy_counter(c : Connection, counter : SyncCounter) : VoidCookie
		fun xcb_sync_destroy_counter_checked(c : Connection, counter : SyncCounter) : VoidCookie
		fun xcb_sync_destroy_fence(c : Connection, fence : SyncFence) : VoidCookie
		fun xcb_sync_destroy_fence_checked(c : Connection, fence : SyncFence) : VoidCookie
		fun xcb_sync_fence_end(i : SyncFenceIterator) : GenericIterator
		fun xcb_sync_fence_next(i : SyncFenceIterator*)
		fun xcb_sync_get_priority(c : Connection, id : UInt32) : SyncGetPriorityCookie
		fun xcb_sync_get_priority_reply(c : Connection, cookie : SyncGetPriorityCookie, e : GenericError**) : SyncGetPriorityReply*
			fun xcb_sync_get_priority_unchecked(c : Connection, id : UInt32) : SyncGetPriorityCookie
		fun xcb_sync_initialize(c : Connection, desired_major_version : UInt8, desired_minor_version : UInt8) : SyncInitializeCookie
		fun xcb_sync_initialize_reply(c : Connection, cookie : SyncInitializeCookie, e : GenericError**) : SyncInitializeReply*
			fun xcb_sync_initialize_unchecked(c : Connection, desired_major_version : UInt8, desired_minor_version : UInt8) : SyncInitializeCookie
		fun xcb_sync_int64_end(i : Int64Iterator) : GenericIterator
		fun xcb_sync_int64_next(i : Int64Iterator*)
		fun xcb_sync_list_system_counters(c : Connection) : SyncListSystemCountersCookie
		fun xcb_sync_list_system_counters_counters_iterator(r : SyncListSystemCountersReply*) : SyncSystemcounterIterator
		fun xcb_sync_list_system_counters_counters_length(r : SyncListSystemCountersReply*) : Int32
		fun xcb_sync_list_system_counters_reply(c : Connection, cookie : SyncListSystemCountersCookie, e : GenericError**) : SyncListSystemCountersReply*
			fun xcb_sync_list_system_counters_sizeof(_buffer : Void*) : Int32
		fun xcb_sync_list_system_counters_unchecked(c : Connection) : SyncListSystemCountersCookie
		fun xcb_sync_query_alarm(c : Connection, alarm : SyncAlarm) : SyncQueryAlarmCookie
		fun xcb_sync_query_alarm_reply(c : Connection, cookie : SyncQueryAlarmCookie, e : GenericError**) : SyncQueryAlarmReply*
			fun xcb_sync_query_alarm_unchecked(c : Connection, alarm : SyncAlarm) : SyncQueryAlarmCookie
		fun xcb_sync_query_counter(c : Connection, counter : SyncCounter) : SyncQueryCounterCookie
		fun xcb_sync_query_counter_reply(c : Connection, cookie : SyncQueryCounterCookie, e : GenericError**) : SyncQueryCounterReply*
			fun xcb_sync_query_counter_unchecked(c : Connection, counter : SyncCounter) : SyncQueryCounterCookie
		fun xcb_sync_query_fence(c : Connection, fence : SyncFence) : SyncQueryFenceCookie
		fun xcb_sync_query_fence_reply(c : Connection, cookie : SyncQueryFenceCookie, e : GenericError**) : SyncQueryFenceReply*
			fun xcb_sync_query_fence_unchecked(c : Connection, fence : SyncFence) : SyncQueryFenceCookie
		fun xcb_sync_reset_fence(c : Connection, fence : SyncFence) : VoidCookie
		fun xcb_sync_reset_fence_checked(c : Connection, fence : SyncFence) : VoidCookie
		fun xcb_sync_set_counter(c : Connection, counter : SyncCounter, value : Int64) : VoidCookie
		fun xcb_sync_set_counter_checked(c : Connection, counter : SyncCounter, value : Int64) : VoidCookie
		fun xcb_sync_set_priority(c : Connection, id : UInt32, priority : Int32) : VoidCookie
		fun xcb_sync_set_priority_checked(c : Connection, id : UInt32, priority : Int32) : VoidCookie
		fun xcb_sync_systemcounter_end(i : SyncSystemcounterIterator) : GenericIterator
		fun xcb_sync_systemcounter_name(r : SyncSystemcounter*) : Char*
			fun xcb_sync_systemcounter_name_end(r : SyncSystemcounter*) : GenericIterator
		fun xcb_sync_systemcounter_name_length(r : SyncSystemcounter*) : Int32
		fun xcb_sync_systemcounter_next(i : SyncSystemcounterIterator*)
		fun xcb_sync_systemcounter_sizeof(_buffer : Void*) : Int32
		fun xcb_sync_trigger_end(i : SyncTriggerIterator) : GenericIterator
		fun xcb_sync_trigger_fence(c : Connection, fence : SyncFence) : VoidCookie
		fun xcb_sync_trigger_fence_checked(c : Connection, fence : SyncFence) : VoidCookie
		fun xcb_sync_trigger_next(i : SyncTriggerIterator*)
		fun xcb_sync_waitcondition_end(i : SyncWaitconditionIterator) : GenericIterator
		fun xcb_sync_waitcondition_next(i : SyncWaitconditionIterator*)
	end
