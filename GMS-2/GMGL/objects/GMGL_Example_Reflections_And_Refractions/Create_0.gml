/*
	Disabling the draw event basically turns off the GM window
	If you don't run this you'll have two windows open
*/
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
gmgl_create_window_centered(800,600,"Example - Cubemaps");
glfw_set_window_icon("GMGL/gmglicon.png");

gl_enable(GL_DEPTH_TEST);

shaderProgram = gmgl_shader_create(shader_example_cubemaps_reflect_refract_vs(), shader_example_cubemaps_reflect_refract_fs());
shaderSkyboxProgram = gmgl_shader_create(shader_example_skybox_vs(), shader_example_skybox_fs());


// Create three vertices
var cubeVertices = [
	// positions          // normals
	-0.5, -0.5, -0.5,  0.0,  0.0, -1.0,
	 0.5, -0.5, -0.5,  0.0,  0.0, -1.0,
	 0.5,  0.5, -0.5,  0.0,  0.0, -1.0,
	 0.5,  0.5, -0.5,  0.0,  0.0, -1.0,
	-0.5,  0.5, -0.5,  0.0,  0.0, -1.0,
	-0.5, -0.5, -0.5,  0.0,  0.0, -1.0,

	-0.5, -0.5,  0.5,  0.0,  0.0, 1.0,
	 0.5, -0.5,  0.5,  0.0,  0.0, 1.0,
	 0.5,  0.5,  0.5,  0.0,  0.0, 1.0,
	 0.5,  0.5,  0.5,  0.0,  0.0, 1.0,
	-0.5,  0.5,  0.5,  0.0,  0.0, 1.0,
	-0.5, -0.5,  0.5,  0.0,  0.0, 1.0,

	-0.5,  0.5,  0.5, -1.0,  0.0,  0.0,
	-0.5,  0.5, -0.5, -1.0,  0.0,  0.0,
	-0.5, -0.5, -0.5, -1.0,  0.0,  0.0,
	-0.5, -0.5, -0.5, -1.0,  0.0,  0.0,
	-0.5, -0.5,  0.5, -1.0,  0.0,  0.0,
	-0.5,  0.5,  0.5, -1.0,  0.0,  0.0,

	 0.5,  0.5,  0.5,  1.0,  0.0,  0.0,
	 0.5,  0.5, -0.5,  1.0,  0.0,  0.0,
	 0.5, -0.5, -0.5,  1.0,  0.0,  0.0,
	 0.5, -0.5, -0.5,  1.0,  0.0,  0.0,
	 0.5, -0.5,  0.5,  1.0,  0.0,  0.0,
	 0.5,  0.5,  0.5,  1.0,  0.0,  0.0,

	-0.5, -0.5, -0.5,  0.0, -1.0,  0.0,
	 0.5, -0.5, -0.5,  0.0, -1.0,  0.0,
	 0.5, -0.5,  0.5,  0.0, -1.0,  0.0,
	 0.5, -0.5,  0.5,  0.0, -1.0,  0.0,
	-0.5, -0.5,  0.5,  0.0, -1.0,  0.0,
	-0.5, -0.5, -0.5,  0.0, -1.0,  0.0,

	-0.5,  0.5, -0.5,  0.0,  1.0,  0.0,
	 0.5,  0.5, -0.5,  0.0,  1.0,  0.0,
	 0.5,  0.5,  0.5,  0.0,  1.0,  0.0,
	 0.5,  0.5,  0.5,  0.0,  1.0,  0.0,
	-0.5,  0.5,  0.5,  0.0,  1.0,  0.0,
	-0.5,  0.5, -0.5,  0.0,  1.0,  0.0
];
var vcount = array_length_1d(cubeVertices);
cubeVbuff = buffer_create(vcount*buffer_sizeof(buffer_f32),buffer_fixed,4);
for (var i = 0; i < vcount; ++i) {
	buffer_write(cubeVbuff,buffer_f32,cubeVertices[i]);
}

var skyboxVertices = [
	// positions          
	-75.0,  75.0, -75.0,
	-75.0, -75.0, -75.0,
	 75.0, -75.0, -75.0,
	 75.0, -75.0, -75.0,
	 75.0,  75.0, -75.0,
	-75.0,  75.0, -75.0,

	-75.0, -75.0,  75.0,
	-75.0, -75.0, -75.0,
	-75.0,  75.0, -75.0,
	-75.0,  75.0, -75.0,
	-75.0,  75.0,  75.0,
	-75.0, -75.0,  75.0,

	 75.0, -75.0, -75.0,
	 75.0, -75.0,  75.0,
	 75.0,  75.0,  75.0,
	 75.0,  75.0,  75.0,
	 75.0,  75.0, -75.0,
	 75.0, -75.0, -75.0,

	-75.0, -75.0,  75.0,
	-75.0,  75.0,  75.0,
	 75.0,  75.0,  75.0,
	 75.0,  75.0,  75.0,
	 75.0, -75.0,  75.0,
	-75.0, -75.0,  75.0,

	-75.0,  75.0, -75.0,
	 75.0,  75.0, -75.0,
	 75.0,  75.0,  75.0,
	 75.0,  75.0,  75.0,
	-75.0,  75.0,  75.0,
	-75.0,  75.0, -75.0,

	-75.0, -75.0, -75.0,
	-75.0, -75.0,  75.0,
	 75.0, -75.0, -75.0,
	 75.0, -75.0, -75.0,
	-75.0, -75.0,  75.0,
	 75.0, -75.0,  75.0
];
vcount = array_length_1d(skyboxVertices);
skyboxVbuff = buffer_create(vcount*buffer_sizeof(buffer_f32),buffer_fixed,4);
for (var i = 0; i < vcount; ++i) {
	buffer_write(skyboxVbuff,buffer_f32,skyboxVertices[i]);
}

//cube VAO
cubeVAO = gl_gen_vertex_array();
cubeVBO = gl_gen_buffer();
gl_bind_vertex_array(cubeVAO);
gl_bind_buffer(GL_ARRAY_BUFFER, cubeVBO);
gl_buffer_data(GL_ARRAY_BUFFER, buffer_get_size(cubeVbuff), buffer_get_address(cubeVbuff), GL_STATIC_DRAW);
gl_enable_vertex_attrib_array(0);
gl_vertex_attrib_pointer(0, 3, GL_FLOAT, GL_FALSE, 6, 0);
gl_enable_vertex_attrib_array(1);
gl_vertex_attrib_pointer(1, 3, GL_FLOAT, GL_FALSE, 6, 3);

//skybox VAO
skyboxVAO = gl_gen_vertex_array();
skyboxVBO = gl_gen_buffer();
gl_bind_vertex_array(skyboxVAO);
gl_bind_buffer(GL_ARRAY_BUFFER, skyboxVBO);
gl_buffer_data(GL_ARRAY_BUFFER, buffer_get_size(skyboxVbuff), buffer_get_address(skyboxVbuff), GL_STATIC_DRAW);
gl_enable_vertex_attrib_array(0);
gl_vertex_attrib_pointer(0, 3, GL_FLOAT, GL_FALSE, 3, 0);

cubeTexture = gmgl_load_texture("GMGL/container.jpg");
cubemapTexture = gmgl_load_cubemap([
	"GMGL/skybox/right.jpg",
	"GMGL/skybox/left.jpg",
	"GMGL/skybox/top.jpg",
	"GMGL/skybox/bottom.jpg",
	"GMGL/skybox/front.jpg",
	"GMGL/skybox/back.jpg"
]);

gl_use_program(shaderProgram);
gmgl_shader_set_int(shaderProgram, "skybox", 0);
gl_use_program(shaderSkyboxProgram);
gmgl_shader_set_int(shaderSkyboxProgram, "skybox", 0);

modelMatrixBuffer = buffer_create(16*buffer_sizeof(buffer_f32),buffer_fixed,4);
viewMatrixBuffer = buffer_create(16*buffer_sizeof(buffer_f32),buffer_fixed,4);
projMatrixBuffer = buffer_create(16*buffer_sizeof(buffer_f32),buffer_fixed,4);

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
