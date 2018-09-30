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
gmgl_create_window_centered(800,600,"Example - Multiple Lights");
glfw_set_window_icon("GMGL/gmglicon.png");

gl_enable(GL_DEPTH_TEST);

var vs = gl_create_shader(GL_VERTEX_SHADER, shader_example_multiple_lights_vs());
var fs = gl_create_shader(GL_FRAGMENT_SHADER, shader_example_multiple_lights_fs());
shaderLighting = gl_create_program();
gl_attach_shader(shaderLighting, vs);
gl_attach_shader(shaderLighting, fs);
gl_link_program(shaderLighting);
gl_delete_shader(vs);
gl_delete_shader(fs);

vs = gl_create_shader(GL_VERTEX_SHADER, shader_example_lamp_vs());
fs = gl_create_shader(GL_FRAGMENT_SHADER, shader_example_lamp_fs());
shaderLamp = gl_create_program();
gl_attach_shader(shaderLamp, vs);
gl_attach_shader(shaderLamp, fs);
gl_link_program(shaderLamp);
gl_delete_shader(vs);
gl_delete_shader(fs);

var vertices = [
	// positions          // normals           // texture coords
	-0.5, -0.5, -0.5,  0.0,  0.0, -1.0,  0.0,  0.0,
	 0.5, -0.5, -0.5,  0.0,  0.0, -1.0,  1.0,  0.0,
	 0.5,  0.5, -0.5,  0.0,  0.0, -1.0,  1.0,  1.0,
	 0.5,  0.5, -0.5,  0.0,  0.0, -1.0,  1.0,  1.0,
	-0.5,  0.5, -0.5,  0.0,  0.0, -1.0,  0.0,  1.0,
	-0.5, -0.5, -0.5,  0.0,  0.0, -1.0,  0.0,  0.0,

	-0.5, -0.5,  0.5,  0.0,  0.0,  1.0,  0.0,  0.0,
	 0.5, -0.5,  0.5,  0.0,  0.0,  1.0,  1.0,  0.0,
	 0.5,  0.5,  0.5,  0.0,  0.0,  1.0,  1.0,  1.0,
	 0.5,  0.5,  0.5,  0.0,  0.0,  1.0,  1.0,  1.0,
	-0.5,  0.5,  0.5,  0.0,  0.0,  1.0,  0.0,  1.0,
	-0.5, -0.5,  0.5,  0.0,  0.0,  1.0,  0.0,  0.0,

	-0.5,  0.5,  0.5, -1.0,  0.0,  0.0,  1.0,  0.0,
	-0.5,  0.5, -0.5, -1.0,  0.0,  0.0,  1.0,  1.0,
	-0.5, -0.5, -0.5, -1.0,  0.0,  0.0,  0.0,  1.0,
	-0.5, -0.5, -0.5, -1.0,  0.0,  0.0,  0.0,  1.0,
	-0.5, -0.5,  0.5, -1.0,  0.0,  0.0,  0.0,  0.0,
	-0.5,  0.5,  0.5, -1.0,  0.0,  0.0,  1.0,  0.0,

	 0.5,  0.5,  0.5,  1.0,  0.0,  0.0,  1.0,  0.0,
	 0.5,  0.5, -0.5,  1.0,  0.0,  0.0,  1.0,  1.0,
	 0.5, -0.5, -0.5,  1.0,  0.0,  0.0,  0.0,  1.0,
	 0.5, -0.5, -0.5,  1.0,  0.0,  0.0,  0.0,  1.0,
	 0.5,  0.5,  0.5,  1.0,  0.0,  0.0,  1.0,  0.0,
	 0.5, -0.5,  0.5,  1.0,  0.0,  0.0,  0.0,  0.0,

	-0.5, -0.5, -0.5,  0.0, -1.0,  0.0,  0.0,  1.0,
	 0.5, -0.5, -0.5,  0.0, -1.0,  0.0,  1.0,  1.0,
	 0.5, -0.5,  0.5,  0.0, -1.0,  0.0,  1.0,  0.0,
	 0.5, -0.5,  0.5,  0.0, -1.0,  0.0,  1.0,  0.0,
	-0.5, -0.5,  0.5,  0.0, -1.0,  0.0,  0.0,  0.0,
	-0.5, -0.5, -0.5,  0.0, -1.0,  0.0,  0.0,  1.0,

	-0.5,  0.5, -0.5,  0.0,  1.0,  0.0,  0.0,  1.0,
	 0.5,  0.5, -0.5,  0.0,  1.0,  0.0,  1.0,  1.0,
	 0.5,  0.5,  0.5,  0.0,  1.0,  0.0,  1.0,  0.0,
	 0.5,  0.5,  0.5,  0.0,  1.0,  0.0,  1.0,  0.0,
	-0.5,  0.5,  0.5,  0.0,  1.0,  0.0,  0.0,  0.0,
	-0.5,  0.5, -0.5,  0.0,  1.0,  0.0,  0.0,  1.0
];
var vcount = array_length_1d(vertices);
vbuff = buffer_create(vcount * buffer_sizeof(buffer_f32), buffer_fixed, 4);
buffer_seek(vbuff, buffer_seek_start, 0);
for (var i = 0; i < vcount; ++i) {
	buffer_write(vbuff, buffer_f32, vertices[i]);
}

vbo = gl_gen_buffer();
gl_bind_buffer(GL_ARRAY_BUFFER, vbo);
gl_buffer_data(GL_ARRAY_BUFFER, buffer_get_size(vbuff), buffer_get_address(vbuff), GL_STATIC_DRAW);

cubeVAO = gl_gen_vertex_array();
gl_bind_vertex_array(cubeVAO);
gl_vertex_attrib_pointer(0, 3, GL_FLOAT, GL_FALSE, 8 * buffer_sizeof(buffer_f32), 0);
gl_enable_vertex_attrib_array(0);
gl_vertex_attrib_pointer(1, 3, GL_FLOAT, GL_FALSE, 8 * buffer_sizeof(buffer_f32), 3 * buffer_sizeof(buffer_f32));
gl_enable_vertex_attrib_array(1);
gl_vertex_attrib_pointer(2, 2, GL_FLOAT, GL_FALSE, 8 * buffer_sizeof(buffer_f32), 6 * buffer_sizeof(buffer_f32));
gl_enable_vertex_attrib_array(2);

lampVAO = gl_gen_vertex_array();
gl_bind_vertex_array(lampVAO);
gl_vertex_attrib_pointer(0, 3, GL_FLOAT, GL_FALSE, 8 * buffer_sizeof(buffer_f32), 0);
gl_enable_vertex_attrib_array(0);

diffuseMap = gmgl_texture_load("GMGL/container2.png");
specularMap = gmgl_texture_load("GMGL/container2_specular.png");

gl_use_program(shaderLighting);
gmgl_shader_set_int(shaderLighting, "material.diffuse", 0);
gmgl_shader_set_int(shaderLighting, "material.specular", 1);


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

dirLightDir = [-0.2, -1.0, -0.3];
dirLightAmbient = [0.05, 0.05, 0.05];
dirLightDiffuse = [0.4, 0.4, 0.4];
dirLightSpecular = [0.5, 0.5, 0.5];

pointLightPositions = [
	[0.5, 0.5, -1],
	[-0.5, -0.5, -1],
	[0.5, -0.5, 1],
	[-0.5, 0.5, 1],
];

spotLightAmbient = [0,0,0];
spotLightDiffuse = [1,1,1];
spotLightSpecular = [1,1,1];
spotLightConstant = 1;
spotLightLinear = 0.09;
spotLightQuadratic = 0.032;
spotLightCutoff = dcos(12.5);
spotLightOuterCutoff = dcos(15);