/*
	Disabling the draw event basically turns off the GM window
	If you don't run this you'll have two windows open
*/
// Let's make a camera to control with some user input
cameraPos = [0,0,-3];//x, y, z
cameraRot = [90,0,0];//yaw, pitch, roll
cameraFront = vector_normalize([
	dcos(cameraRot[0]) * dcos(cameraRot[1]),
	dsin(cameraRot[1]),
	dsin(cameraRot[0]) * dcos(cameraRot[1])
]);
cameraUp = [0,1,0];
cameraSpeed = 2.5;
cameraLastX = 400;
cameraLastY = 300;
cameraFirstMouse = true;
cameraFOV = 45;

global.gmgl_mouse_pos = [0,0];
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
gmgl_create_window_centered(800,600,"Example - Uniform Buffers");
glfw_set_window_icon("GMGL/gmglicon.png");

gl_enable(GL_DEPTH_TEST);

shaderRed = gmgl_shader_create(shader_example_advglsl_vs(), shader_example_red_fs());
shaderGreen = gmgl_shader_create(shader_example_advglsl_vs(), shader_example_green_fs());
shaderBlue = gmgl_shader_create(shader_example_advglsl_vs(), shader_example_blue_fs());
shaderYellow = gmgl_shader_create(shader_example_advglsl_vs(), shader_example_yellow_fs());

var cubeVertices = [
	// positions         
	-0.5, -0.5, -0.5, 
	 0.5, -0.5, -0.5,  
	 0.5,  0.5, -0.5,  
	 0.5,  0.5, -0.5,  
	-0.5,  0.5, -0.5, 
	-0.5, -0.5, -0.5, 

	-0.5, -0.5,  0.5, 
	 0.5, -0.5,  0.5,  
	 0.5,  0.5,  0.5,  
	 0.5,  0.5,  0.5,  
	-0.5,  0.5,  0.5, 
	-0.5, -0.5,  0.5, 

	-0.5,  0.5,  0.5, 
	-0.5,  0.5, -0.5, 
	-0.5, -0.5, -0.5, 
	-0.5, -0.5, -0.5, 
	-0.5, -0.5,  0.5, 
	-0.5,  0.5,  0.5, 

	 0.5,  0.5,  0.5,  
	 0.5,  0.5, -0.5,  
	 0.5, -0.5, -0.5,  
	 0.5, -0.5, -0.5,  
	 0.5, -0.5,  0.5,  
	 0.5,  0.5,  0.5,  

	-0.5, -0.5, -0.5, 
	 0.5, -0.5, -0.5,  
	 0.5, -0.5,  0.5,  
	 0.5, -0.5,  0.5,  
	-0.5, -0.5,  0.5, 
	-0.5, -0.5, -0.5, 

	-0.5,  0.5, -0.5, 
	 0.5,  0.5, -0.5,  
	 0.5,  0.5,  0.5,  
	 0.5,  0.5,  0.5,  
	-0.5,  0.5,  0.5, 
	-0.5,  0.5, -0.5
];
var vcount = array_length_1d(cubeVertices);
cubeVbuff = buffer_create(vcount * buffer_sizeof(buffer_f32), buffer_fixed, 4);
buffer_seek(cubeVbuff, buffer_seek_start, 0);
for (var i = 0; i < vcount; ++i) {
	buffer_write(cubeVbuff, buffer_f32, cubeVertices[i]);
}

cubeVAO = gl_gen_vertex_array();
cubeVBO = gl_gen_buffer();
gl_bind_vertex_array(cubeVAO);
gl_bind_buffer(GL_ARRAY_BUFFER, cubeVBO);
gl_buffer_data(GL_ARRAY_BUFFER, buffer_get_size(cubeVbuff), buffer_get_address(cubeVbuff), GL_STATIC_DRAW);
gl_enable_vertex_attrib_array(0);
gl_vertex_attrib_pointer(0, 3, GL_FLOAT, GL_FALSE, 3 * buffer_sizeof(buffer_f32), 0);

uniformBlockIndexRed = gl_get_uniform_block_index(shaderRed, "Matrices");
uniformBlockIndexGreen = gl_get_uniform_block_index(shaderGreen, "Matrices");
uniformBlockIndexBlue = gl_get_uniform_block_index(shaderBlue, "Matrices");
uniformBlockIndexYellow = gl_get_uniform_block_index(shaderYellow, "Matrices");
gl_uniform_block_binding(shaderRed, uniformBlockIndexRed, 0);
gl_uniform_block_binding(shaderGreen, uniformBlockIndexGreen, 0);
gl_uniform_block_binding(shaderBlue, uniformBlockIndexBlue, 0);
gl_uniform_block_binding(shaderYellow, uniformBlockIndexYellow, 0);

uboMatrices = gl_gen_buffer();
//uboData = buffer_create(2 * (buffer_sizeof(buffer_f32) * 16), buffer_fixed, 4);
gl_bind_buffer(GL_UNIFORM_BUFFER, uboMatrices);
gl_buffer_data(GL_UNIFORM_BUFFER, 2 * (buffer_sizeof(buffer_f32) * 16), noone, GL_STATIC_DRAW);
gl_bind_buffer(GL_UNIFORM_BUFFER, noone);
gl_bind_buffer_range(GL_UNIFORM_BUFFER, 0, uboMatrices, 0, 2 * (buffer_sizeof(buffer_f32) * 16));

var proj = matrix_build_projection_perspective_fov(cameraFOV,800/600,0.1,100.0);
projMatrixBuffer = buffer_create(16*buffer_sizeof(buffer_f32),buffer_fixed,4);
buffer_seek(projMatrixBuffer,buffer_seek_start,0);
for (var i = 0; i < 16; ++i) {
	buffer_write(projMatrixBuffer,buffer_f32,proj[i]);
}
gl_bind_buffer(GL_UNIFORM_BUFFER, uboMatrices);
gl_buffer_sub_data(GL_UNIFORM_BUFFER, 0, buffer_get_size(projMatrixBuffer), buffer_get_address(projMatrixBuffer));
gl_bind_buffer(GL_UNIFORM_BUFFER, noone);

modelMatrixBuffer = buffer_create(16*buffer_sizeof(buffer_f32),buffer_fixed,4);
viewMatrixBuffer = buffer_create(16*buffer_sizeof(buffer_f32),buffer_fixed,4);