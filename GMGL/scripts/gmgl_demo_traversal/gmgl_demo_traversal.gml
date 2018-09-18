if (!gmgl_is_active()) exit;

if (gmgl_key_press(GLFW_KEY_ESCAPE)) game_end();

if (gmgl_key_press(GLFW_KEY_PAGE_DOWN)) {
	glfw_terminate();
	if (room == room_last) {
		room_goto(room_first);
	} else {
		room_goto_next();
	}
	exit;
}

if (gmgl_key_press(GLFW_KEY_PAGE_UP)) {
	glfw_terminate();
	if (room == room_first) {
		room_goto(room_last);
	} else {
		room_goto_previous();
	}
}