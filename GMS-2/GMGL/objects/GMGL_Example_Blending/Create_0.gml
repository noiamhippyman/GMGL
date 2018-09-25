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
gmgl_create_window_centered(800,600,"Example - Blending");
glfw_set_window_icon("GMGL/gmglicon.png");

gl_enable(GL_DEPTH_TEST);
gl_enable(GL_BLEND);
gl_blend_func(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);

/*
	Create shaders
	
	For simplicity I decided to make this function actually do three things behind the scenes
	When doing this with C/C++ you would create the shader, set the source and then compile the shader.
	
	Creating a vertex shader would look like this:
	GLuint shader = glCreateShader(GL_VERTEX_SHADER);
	glShaderSource(shader, 1, &vertexShaderSource, nullptr);
	glCompileShader(shader);
	
	gl_create_shader also does a quick error check to see if the compilation failed.
	That's an extra five or six lines of code. There's already of ton of code to write
	so this is just a nice convenience.
	
	If it fails the function returns GMGL_FAIL otherwise it returns the shader ID.
*/
var vertShader = gl_create_shader(GL_VERTEX_SHADER,shader_example_blending_vs());
var fragShader = gl_create_shader(GL_FRAGMENT_SHADER,shader_example_blending_fs());

/*
	Create shader program
	
	The shaders by themselves are useless. You still need to create a program.
	Then attach any shaders you want to the program and finally link the program.
*/
shaderProgram = gl_create_program();
gl_attach_shader(shaderProgram,vertShader);
gl_attach_shader(shaderProgram,fragShader);
gl_link_program(shaderProgram);

/*
	Delete shaders
	
	After linking a program you don't need the shaders anymore. 
	You can delete them when you don't need them anymore.
*/
gl_delete_shader(vertShader);
gl_delete_shader(fragShader);


// Create three cubeVertices
var cubeVertices = [
	//Positions			//UV
	-0.5, -0.5, -0.5,  0.0, 0.0,
	 0.5, -0.5, -0.5,  1.0, 0.0,
	 0.5,  0.5, -0.5,  1.0, 1.0,
	 0.5,  0.5, -0.5,  1.0, 1.0,
	-0.5,  0.5, -0.5,  0.0, 1.0,
	-0.5, -0.5, -0.5,  0.0, 0.0,

	-0.5, -0.5,  0.5,  0.0, 0.0,
	 0.5, -0.5,  0.5,  1.0, 0.0,
	 0.5,  0.5,  0.5,  1.0, 1.0,
	 0.5,  0.5,  0.5,  1.0, 1.0,
	-0.5,  0.5,  0.5,  0.0, 1.0,
	-0.5, -0.5,  0.5,  0.0, 0.0,

	-0.5,  0.5,  0.5,  1.0, 0.0,
	-0.5,  0.5, -0.5,  1.0, 1.0,
	-0.5, -0.5, -0.5,  0.0, 1.0,
	-0.5, -0.5, -0.5,  0.0, 1.0,
	-0.5, -0.5,  0.5,  0.0, 0.0,
	-0.5,  0.5,  0.5,  1.0, 0.0,

	 0.5,  0.5,  0.5,  1.0, 0.0,
	 0.5,  0.5, -0.5,  1.0, 1.0,
	 0.5, -0.5, -0.5,  0.0, 1.0,
	 0.5, -0.5, -0.5,  0.0, 1.0,
	 0.5, -0.5,  0.5,  0.0, 0.0,
	 0.5,  0.5,  0.5,  1.0, 0.0,

	-0.5, -0.5, -0.5,  0.0, 1.0,
	 0.5, -0.5, -0.5,  1.0, 1.0,
	 0.5, -0.5,  0.5,  1.0, 0.0,
	 0.5, -0.5,  0.5,  1.0, 0.0,
	-0.5, -0.5,  0.5,  0.0, 0.0,
	-0.5, -0.5, -0.5,  0.0, 1.0,

	-0.5,  0.5, -0.5,  0.0, 1.0,
	 0.5,  0.5, -0.5,  1.0, 1.0,
	 0.5,  0.5,  0.5,  1.0, 0.0,
	 0.5,  0.5,  0.5,  1.0, 0.0,
	-0.5,  0.5,  0.5,  0.0, 0.0,
	-0.5,  0.5, -0.5,  0.0, 1.0
];
var vcount = array_length_1d(cubeVertices);
cubeVbuff = buffer_create(vcount*buffer_sizeof(buffer_f32),buffer_fixed,4);
for (var i = 0; i < vcount; ++i) {
	buffer_write(cubeVbuff,buffer_f32,cubeVertices[i]);
}

var planeVertices = [
	// positions		// texture Coords 
	 5.0, -0.5,  5.0,	2.0, 0.0,
	-5.0, -0.5,  5.0,	0.0, 0.0,
	-5.0, -0.5, -5.0,	0.0, 2.0,

	 5.0, -0.5,  5.0,	2.0, 0.0,
	-5.0, -0.5, -5.0,	0.0, 2.0,
	 5.0, -0.5, -5.0,	2.0, 2.0
];
vcount = array_length_1d(planeVertices);
planeVbuff = buffer_create(vcount*buffer_sizeof(buffer_f32), buffer_fixed, 4);
for (var i = 0; i < vcount; ++i) {
	buffer_write(planeVbuff, buffer_f32, planeVertices[i]);
}


var transparentVertices = [
	//position			//uv
	-0.5, -0.5, 0,		0.0, 0.0,
	 0.5, -0.5, 0,		1.0, 0.0,
	 0.5,  0.5, 0,		1.0, 1.0,
	 0.5,  0.5, 0,		1.0, 1.0,
	-0.5,  0.5, 0,		0.0, 1.0,
	-0.5, -0.5, 0,		0.0, 0.0
];
vcount = array_length_1d(transparentVertices);
transVbuff = buffer_create(vcount*buffer_sizeof(buffer_f32), buffer_fixed, 4);
for (var i = 0; i < vcount; ++i) {
	buffer_write(transVbuff, buffer_f32, transparentVertices[i]);
}


//cube vao
cubeVAO = gl_gen_vertex_array();
cubeVBO = gl_gen_buffer();
gl_bind_vertex_array(cubeVAO);
gl_bind_buffer(GL_ARRAY_BUFFER, cubeVBO);
gl_buffer_data(GL_ARRAY_BUFFER, buffer_get_size(cubeVbuff),buffer_get_address(cubeVbuff),GL_STATIC_DRAW);
gl_enable_vertex_attrib_array(0);
gl_vertex_attrib_pointer(0, 3, GL_FLOAT, GL_FALSE, 5, 0);
gl_enable_vertex_attrib_array(1);
gl_vertex_attrib_pointer(1, 2, GL_FLOAT, GL_FALSE, 5, 3);

//plane vao
planeVAO = gl_gen_vertex_array();
planeVBO = gl_gen_buffer();
gl_bind_vertex_array(planeVAO);
gl_bind_buffer(GL_ARRAY_BUFFER, planeVBO);
gl_buffer_data(GL_ARRAY_BUFFER, buffer_get_size(planeVbuff),buffer_get_address(planeVbuff),GL_STATIC_DRAW);
gl_enable_vertex_attrib_array(0);
gl_vertex_attrib_pointer(0, 3, GL_FLOAT, GL_FALSE, 5, 0);
gl_enable_vertex_attrib_array(1);
gl_vertex_attrib_pointer(1, 2, GL_FLOAT, GL_FALSE, 5, 3);

//transparent vao
transVAO = gl_gen_vertex_array();
transVBO = gl_gen_buffer();
gl_bind_vertex_array(transVAO);
gl_bind_buffer(GL_ARRAY_BUFFER, transVBO);
gl_buffer_data(GL_ARRAY_BUFFER, buffer_get_size(transVbuff),buffer_get_address(transVbuff),GL_STATIC_DRAW);
gl_enable_vertex_attrib_array(0);
gl_vertex_attrib_pointer(0, 3, GL_FLOAT, GL_FALSE, 5, 0);
gl_enable_vertex_attrib_array(1);
gl_vertex_attrib_pointer(1, 2, GL_FLOAT, GL_FALSE, 5, 3);

cubeTexture = gmgl_load_texture("GMGL/container.jpg");
planeTexture = gmgl_load_texture("GMGL/container2.png");
grassTexture = gmgl_load_texture("GMGL/grass.png");
windowTexture = gmgl_load_texture("GMGL/blending_transparent_window.png");

modelMatrixBuffer = buffer_create(16*buffer_sizeof(buffer_f32),buffer_fixed,4);
viewMatrixBuffer = buffer_create(16*buffer_sizeof(buffer_f32),buffer_fixed,4);
projMatrixBuffer = buffer_create(16*buffer_sizeof(buffer_f32),buffer_fixed,4);

vegetation = [
	[-1.5,0,-0.48],
	[1.5,0,0.51],
	[0,0,0.7],
	[-0.3,0,-2.3],
	[0.5,0,-0.6]
];

windows = [
	[-1.5,0,-0.51],
	[1.5,0,0.55],
	[0,0,0.8],
	[-0.3,0,-2.4],
	[0.5,0,-0.7]
];

blendedObjects = [
	[-1.5,0,-0.48, grassTexture],
	[1.5,0,0.51, grassTexture],
	[0,0,0.7, grassTexture],
	[-0.3,0,-2.3, grassTexture],
	[0.5,0,-0.6, grassTexture],
	
	[-1.5,0,-0.46, windowTexture],
	[1.5,0,0.53, windowTexture],
	[0,0,0.72, windowTexture],
	[-0.3,0,-2.25, windowTexture],
	[0.5,0,-0.56, windowTexture]
];

gl_use_program(shaderProgram);
gmgl_shader_set_int(shaderProgram, "texture", 0);

// Let's make a camera to control with some user input
cameraPos = [0,0,3];//x, y, z
cameraRot = [-90,0,0];//yaw, pitch, roll
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

//used to sort objects by distance
blendSortedQueue = ds_priority_create();