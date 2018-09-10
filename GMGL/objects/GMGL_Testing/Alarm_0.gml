///if gmgl has been shutdown end GMS process
if (!gmgl_is_active()) {
	game_end();
} else {

	//if gmgl is still running reset this timer
	alarm_set(0,game_get_speed(gamespeed_fps) * gmgl_downtime_timer);
}

show_debug_message("GMGL activity check");