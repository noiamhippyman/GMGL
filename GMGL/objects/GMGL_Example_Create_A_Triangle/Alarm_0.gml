/*

	If GMGL has been shutdown, then shutdown GM's process.
	The reason you have to do this is because if you close
	the window it will shutdown GMGL but the GM process
	will just continue running in the background.
	
	If you comment out the alarm_set call in the create event
	you can observe this in the task manager on Windows. While
	running with the window open it will show up in "Apps" and
	when you close the window it will move the process to the 
	bottom of "Background processes".
	
	You could equally just check it in the step event but it's
	unecessary to waste it on every step. You can change the check
	time in the GLFW_defines script

*/

if (!gmgl_is_active()) game_end();
alarm_set(0,GMGL_ACTIVE_CHECK_TIME * game_get_speed(gamespeed_fps));