@[Link("xcb-util-xrm")]
lib LibXCB
	type XrmDatabase = Void*
		fun xcb_xrm_database_combine(source_db : XrmDatabase, target_db : XrmDatabase*, override : Bool)
	fun xcb_xrm_database_free(database : XrmDatabase)
	fun xcb_xrm_database_from_default(conn : Connection) : XrmDatabase
	fun xcb_xrm_database_from_file(filename : Char*) : XrmDatabase
	fun xcb_xrm_database_from_resource_manager(conn : Connection, screen : XcbScreenT*) : XrmDatabase
	fun xcb_xrm_database_from_string(str : Char*) : XrmDatabase
	fun xcb_xrm_database_put_resource(database : XrmDatabase*, resource : Char*, value : Char*)
	fun xcb_xrm_database_put_resource_line(database : XrmDatabase*, line : Char*)
	fun xcb_xrm_database_to_string(database : XrmDatabase) : Char*
		fun xcb_xrm_resource_get_bool(database : XrmDatabase, res_name : Char*, res_class : Char*, out : Bool*) : Int32
	fun xcb_xrm_resource_get_long(database : XrmDatabase, res_name : Char*, res_class : Char*, out : Int64*) : Int32
	fun xcb_xrm_resource_get_string(database : XrmDatabase, res_name : Char*, res_class : Char*, out : Char**) : Int32
end
