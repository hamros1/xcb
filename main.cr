require "./**"

ewmh = Pointer.malloc(1, LibXCB::EwmhConnection)

default_screen = uninitialized Int32
dpy = LibXCB.xcb_connect(nil, pointerof(default_screen))

screen = LibXCB.xcb_setup_roots_iterator(LibXCB.xcb_get_setup(dpy)).data
screen = screen.value

root = screen.root

screen_width = screen.width_in_pixels
screen_height = screen.height_in_pixels

values = [LibXCB::XCB_EVENT_MASK_SUBSTRUCTURE_NOTIFY |LibXCB::XCB_EVENT_MASK_SUBSTRUCTURE_REDIRECT | LibXCB::XCB_EVENT_MASK_BUTTON_PRESS | LibXCB::XCB_EVENT_MASK_ENTER_WINDOW | LibXCB::XCB_EVENT_MASK_LEAVE_WINDOW | LibXCB::XCB_EVENT_MASK_STRUCTURE_NOTIFY | LibXCB::XCB_EVENT_MASK_PROPERTY_CHANGE]

LibXCB.xcb_change_window_attributes_checked(dpy, root, LibXCB::XCB_CW_EVENT_MASK | LibXCB::XCB_CW_CURSOR, values)

