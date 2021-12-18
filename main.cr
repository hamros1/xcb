require "./**"

default_screen = uninitialized Int32
dpy = LibXCB.xcb_connect(nil, pointerof(default_screen))
screen = LibXCB.xcb_setup_roots_iterator(LibXCB.xcb_get_setup(dpy)).data.value
root = screen.root

puts screen
