/// @desc gmgl_set_window_pos
var width = argument0;
var height = argument1;
var title = argument2;
gmgl_create_window(width,height,title);
gmgl_set_window_pos((display_get_width()-width) / 2, (display_get_height()-height)/2);