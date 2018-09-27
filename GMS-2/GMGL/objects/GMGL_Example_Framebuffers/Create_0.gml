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
gmgl_create_window_centered(800,600,"Example - Framebuffers & Post-Processing");
glfw_set_window_icon("GMGL/gmglicon.png");

gl_enable(GL_DEPTH_TEST);
gl_enable(GL_BLEND);
gl_blend_func(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);

shaderProgram = gmgl_shader_create(shader_example_framebuffer_vs(),shader_example_framebuffer_fs());
shaderScreenProgram = gmgl_shader_create(shader_example_framebuffer_screen_vs(), shader_example_framebuffer_screen_fs());

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

var quadVertices = [
	-1, -1,  0,  0,
	 1, -1,  1,  0,
	 1,  1,  1,  1,
	 
	-1, -1,  0,  0,
	 1,  1,  1,  1,
	-1,  1,  0,  1,
];
vcount = array_length_1d(quadVertices);
quadVbuff = buffer_create(vcount*buffer_sizeof(buffer_f32), buffer_fixed, 4);
for (var i = 0; i < vcount; ++i) {
	buffer_write(quadVbuff, buffer_f32, quadVertices[i]);
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

//quad vao
quadVAO = gl_gen_vertex_array();
quadVBO = gl_gen_buffer();
gl_bind_vertex_array(quadVAO);
gl_bind_buffer(GL_ARRAY_BUFFER, quadVBO);
gl_buffer_data(GL_ARRAY_BUFFER, buffer_get_size(quadVbuff),buffer_get_address(quadVbuff),GL_STATIC_DRAW);
gl_enable_vertex_attrib_array(0);
gl_vertex_attrib_pointer(0, 2, GL_FLOAT, GL_FALSE, 4, 0);
gl_enable_vertex_attrib_array(1);
gl_vertex_attrib_pointer(1, 2, GL_FLOAT, GL_FALSE, 4, 2);

cubeTexture = gmgl_load_texture("GMGL/container.jpg");
planeTexture = gmgl_load_texture("GMGL/container2.png");
grassTexture = gmgl_load_texture("GMGL/grass.png");
windowTexture = gmgl_load_texture("GMGL/blending_transparent_window.png");

gl_use_program(shaderProgram);
gmgl_shader_set_int(shaderProgram, "texture1", 0);

gl_use_program(shaderScreenProgram);
gmgl_shader_set_int(shaderScreenProgram, "screenTexture", 0);

framebuffer = gl_gen_framebuffer();
gl_bind_framebuffer(GL_FRAMEBUFFER, framebuffer);

textureColorBuffer = gl_gen_texture();
gl_bind_texture(GL_TEXTURE_2D, textureColorBuffer);
gl_tex_image2D(GL_TEXTURE_2D, 0, GL_RGB, 800, 600, 0, GL_RGB, GL_UNSIGNED_BYTE, noone);
gl_tex_parameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
gl_tex_parameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
gl_framebuffer_texture2D(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0, GL_TEXTURE_2D, textureColorBuffer, 0);

renderbuffer = gl_gen_renderbuffer();
gl_bind_renderbuffer(GL_RENDERBUFFER, renderbuffer);
gl_renderbuffer_storage(GL_RENDERBUFFER, GL_DEPTH24_STENCIL8, 800, 600);
gl_framebuffer_renderbuffer(GL_FRAMEBUFFER, GL_DEPTH_STENCIL_ATTACHMENT, GL_RENDERBUFFER, renderbuffer);

gl_bind_framebuffer(GL_FRAMEBUFFER, noone);
gl_bind_renderbuffer(GL_RENDERBUFFER, noone);

// Uncomment the line below to see the final render is a single quad (two triangles)
//gl_polygon_mode(GL_FRONT_AND_BACK, GL_LINE);

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