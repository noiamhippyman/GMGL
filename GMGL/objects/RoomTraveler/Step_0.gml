if (!gmgl_is_active()) exit;


if (gmgl_key_press(GMGL_KEY_PAGE_DOWN)) {
	if (room == room_last) 
		room_goto(room_first);
	else 
		room_goto_next();
}

if (gmgl_key_press(GMGL_KEY_PAGE_UP)) {
	if (room == room_first) {
		room_goto(room_last);
	} else {
		room_goto_previous();
	}
}