if (!gmgl_is_active()) game_end();
alarm_set(0,gmgl_active_check_timer * game_get_speed(gamespeed_fps));