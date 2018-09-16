//Set alarm to keep track of when GMGL is running or not
alarm_set(0,GMGL_ACTIVE_CHECK_TIME * game_get_speed(gamespeed_fps));

//Disabling the draw event basically turns off the GM window
//If you don't run this you'll have two windows open
draw_enable_drawevent(false);

//Call this to initialize the GMGL extension
//Equivalent to glfwInit()
glfw_init();

//Set GL version to use
/*
	GLFW_CONTEXT_VERSION_MAJOR and GLFW_CONTEXT_VERSION_MINOR 
	are not hard constraints, but creation will fail if the OpenGL 
	version of the created context is less than the one requested. 
	It is therefore perfectly safe to use the default of version 1.0 
	for legacy code and you will still get backwards-compatible 
	contexts of version 3.0 and above when available.
	
	While there is no way to ask the driver for a context of the 
	highest supported version, GLFW will attempt to provide this 
	when you ask for a version 1.0 context, which is the default 
	for these hints.
*/
glfw_window_hint(GLFW_CONTEXT_VERSION_MAJOR, 3);
glfw_window_hint(GLFW_CONTEXT_VERSION_MINOR, 3);
//Set GL profile
/*
	GLFW_OPENGL_PROFILE specifies which OpenGL profile to 
	create the context for. Possible values are one of 
	GLFW_OPENGL_CORE_PROFILE or GLFW_OPENGL_COMPAT_PROFILE, 
	or GLFW_OPENGL_ANY_PROFILE to not request a specific profile. 
	
	If requesting an OpenGL version below 3.2, GLFW_OPENGL_ANY_PROFILE 
	must be used.
*/
glfw_window_hint(GLFW_OPENGL_PROFILE, GLFW_OPENGL_CORE_PROFILE);

//Create the actual window
gmgl_create_window_centered(800,600,"Example - Creating a Window");


