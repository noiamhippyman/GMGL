/// @desc gmgl_init(major,minor,width,height,title);
/// @arg major,minor,width,height,title
var major = argument0;
var minor = argument1;
var width = argument2;
var height = argument3;
var title = argument4;
draw_enable_drawevent(false);
glfw_init();
glfw_window_hint(GLFW_CONTEXT_VERSION_MAJOR, major);
glfw_window_hint(GLFW_CONTEXT_VERSION_MINOR, minor);
glfw_window_hint(GLFW_OPENGL_PROFILE, GLFW_OPENGL_CORE_PROFILE);
glfw_window_hint(GLFW_SAMPLES, 4);
gmgl_create_window_centered(width,height,title);
gl_enable(GL_DEPTH_TEST);