/*
	Disabling the draw event basically turns off the GM window
	If you don't run this you'll have two windows open
*/
draw_enable_drawevent(false);

// Call this to initialize GLFW
glfw_init();

/*
	Set GL version to use with GLFW window hints
	
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

/*
	Set GL profile
	
	GLFW_OPENGL_PROFILE specifies which OpenGL profile to 
	create the context for. Possible values are one of 
	GLFW_OPENGL_CORE_PROFILE or GLFW_OPENGL_COMPAT_PROFILE, 
	or GLFW_OPENGL_ANY_PROFILE to not request a specific profile. 
	
	If requesting an OpenGL version below 3.2, GLFW_OPENGL_ANY_PROFILE 
	must be used.
*/
glfw_window_hint(GLFW_OPENGL_PROFILE, GLFW_OPENGL_CORE_PROFILE);

/*
	Create the actual window
	
	gmgl_create_window_centered is just a script. 
	Open it to see how to create a window and center it with GLFW functions.
*/
gmgl_create_window_centered(800,600,"Example - Instancing");
glfw_set_window_icon("GMGL/gmglicon.png");

gl_enable(GL_DEPTH_TEST);

shaderProgram = gmgl_shader_create(shader_example_instancing_vs(), shader_example_instancing_fs());

translationBuffer = buffer_create(100 * 2 * buffer_sizeof(buffer_f32), buffer_fixed, 4);
var index = 0;
var offset = 0.1;
for (j = -10; j < 10; j+= 2) {
	for (var i = - 10; i < 10; i += 2) {
		buffer_write(translationBuffer, buffer_f32,i / 10 + offset);
		buffer_write(translationBuffer, buffer_f32,j / 10 + offset);
	}
}

instanceVBO = gl_gen_buffer();
gl_bind_buffer(GL_ARRAY_BUFFER, instanceVBO);
gl_buffer_data(GL_ARRAY_BUFFER, buffer_get_size(translationBuffer), buffer_get_address(translationBuffer), GL_STATIC_DRAW); 

var quadVertices = [
	// positions     // colors
	-0.05,  0.05,  1.0, 0.0, 0.0,
	 0.05, -0.05,  0.0, 1.0, 0.0,
	-0.05, -0.05,  0.0, 0.0, 1.0,

	-0.05,  0.05,  1.0, 0.0, 0.0,
	 0.05, -0.05,  0.0, 1.0, 0.0,
	 0.05,  0.05,  0.0, 1.0, 1.0
];
var vcount = array_length_1d(quadVertices);
quadVbuff = buffer_create(vcount * buffer_sizeof(buffer_f32), buffer_fixed, 4);
buffer_seek(quadVbuff, buffer_seek_start, 0);
for (var i = 0; i < vcount; ++i) {
	buffer_write(quadVbuff, buffer_f32, quadVertices[i]);
}

quadVAO = gl_gen_vertex_array();
quadVBO = gl_gen_buffer();
gl_bind_vertex_array(quadVAO);
gl_bind_buffer(GL_ARRAY_BUFFER, quadVBO);
gl_buffer_data(GL_ARRAY_BUFFER, buffer_get_size(quadVbuff), buffer_get_address(quadVbuff), GL_STATIC_DRAW);
gl_enable_vertex_attrib_array(0);
gl_vertex_attrib_pointer(0, 2, GL_FLOAT, GL_FALSE, 5 * buffer_sizeof(buffer_f32), 0);
gl_enable_vertex_attrib_array(1);
gl_vertex_attrib_pointer(1, 3, GL_FLOAT, GL_FALSE, 5 * buffer_sizeof(buffer_f32), 2 * buffer_sizeof(buffer_f32));

gl_enable_vertex_attrib_array(2);
gl_bind_buffer(GL_ARRAY_BUFFER, instanceVBO);
gl_vertex_attrib_pointer(2, 2, GL_FLOAT, GL_FALSE, 2 * buffer_sizeof(buffer_f32), 0);
gl_bind_buffer(GL_ARRAY_BUFFER, noone);
gl_vertex_attrib_divisor(2, 1);






