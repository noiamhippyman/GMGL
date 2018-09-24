/// @desc gmgl_create_window_centered(width,height,title);
/// @arg width,height,title
var width = argument0;
var height = argument1;
var title = argument2;
glfw_create_window(width,height,title);
glfw_set_window_pos((display_get_width()-width) / 2, (display_get_height()-height)/2);