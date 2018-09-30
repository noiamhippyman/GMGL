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

//AA
glfw_window_hint(GLFW_SAMPLES, 8);

gmgl_create_window_centered(800,600,"Example - Practical Instancing");
glfw_set_window_icon("GMGL/gmglicon.png");

gl_enable(GL_DEPTH_TEST);

//AA
gl_enable(GL_MULTISAMPLE);

asteroidShader = gmgl_shader_create(shader_example_asteroids_vs(),shader_example_asteroids_fs());
planetShader = gmgl_shader_create(shader_example_planet_vs(),shader_example_planet_fs());

var asteroidVertices = [
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
var vcount = array_length_1d(asteroidVertices);
asteroidVbuff = buffer_create(vcount*buffer_sizeof(buffer_f32),buffer_fixed,4);
for (var i = 0; i < vcount; ++i) {
	buffer_write(asteroidVbuff,buffer_f32,asteroidVertices[i]);
}

var planetVertices = [
	//Positions			//UV
	-2.0, -2.0, -2.0,  0.0, 0.0,
	 2.0, -2.0, -2.0,  1.0, 0.0,
	 2.0,  2.0, -2.0,  1.0, 1.0,
	 2.0,  2.0, -2.0,  1.0, 1.0,
	-2.0,  2.0, -2.0,  0.0, 1.0,
	-2.0, -2.0, -2.0,  0.0, 0.0,

	-2.0, -2.0,  2.0,  0.0, 0.0,
	 2.0, -2.0,  2.0,  1.0, 0.0,
	 2.0,  2.0,  2.0,  1.0, 1.0,
	 2.0,  2.0,  2.0,  1.0, 1.0,
	-2.0,  2.0,  2.0,  0.0, 1.0,
	-2.0, -2.0,  2.0,  0.0, 0.0,

	-2.0,  2.0,  2.0,  1.0, 0.0,
	-2.0,  2.0, -2.0,  1.0, 1.0,
	-2.0, -2.0, -2.0,  0.0, 1.0,
	-2.0, -2.0, -2.0,  0.0, 1.0,
	-2.0, -2.0,  2.0,  0.0, 0.0,
	-2.0,  2.0,  2.0,  1.0, 0.0,

	 2.0,  2.0,  2.0,  1.0, 0.0,
	 2.0,  2.0, -2.0,  1.0, 1.0,
	 2.0, -2.0, -2.0,  0.0, 1.0,
	 2.0, -2.0, -2.0,  0.0, 1.0,
	 2.0, -2.0,  2.0,  0.0, 0.0,
	 2.0,  2.0,  2.0,  1.0, 0.0,

	-2.0, -2.0, -2.0,  0.0, 1.0,
	 2.0, -2.0, -2.0,  1.0, 1.0,
	 2.0, -2.0,  2.0,  1.0, 0.0,
	 2.0, -2.0,  2.0,  1.0, 0.0,
	-2.0, -2.0,  2.0,  0.0, 0.0,
	-2.0, -2.0, -2.0,  0.0, 1.0,

	-2.0,  2.0, -2.0,  0.0, 1.0,
	 2.0,  2.0, -2.0,  1.0, 1.0,
	 2.0,  2.0,  2.0,  1.0, 0.0,
	 2.0,  2.0,  2.0,  1.0, 0.0,
	-2.0,  2.0,  2.0,  0.0, 0.0,
	-2.0,  2.0, -2.0,  0.0, 1.0
];
vcount = array_length_1d(planetVertices);
planetVbuff = buffer_create(vcount*buffer_sizeof(buffer_f32),buffer_fixed,4);
for (var i = 0; i < vcount; ++i) {
	buffer_write(planetVbuff,buffer_f32,planetVertices[i]);
}


asteroidAmount = 100000;
modelMatricesBuffer = buffer_create(asteroidAmount * (buffer_sizeof(buffer_f32)*16), buffer_fixed, 4);
var radius = 150;
var offset = 25;
for (var i = 0; i < asteroidAmount; ++i) {
	
	var angle = i / asteroidAmount * 360;
	var displacement = random(2 * offset * 100) / 100 - offset;
	var mx = sin(angle) * radius + displacement;
	displacement = random(2 * offset * 100) / 100 - offset;
	var my = displacement * 0.4;
	displacement = random(2 * offset * 100) / 100 - offset;
	var mz = cos(angle) * radius + displacement;
	var scale = random(20) / 100 + 0.05;
	var rotAngle = random(360);
	
	var matrix = matrix_build(
		mx,my,mz,
		rotAngle*0.4, rotAngle*0.6, rotAngle*0.8,
		scale, scale, scale
	);
	
	for (var j = 0; j < 16; ++j) {
		buffer_write(modelMatricesBuffer, buffer_f32, matrix[j]);
	}
}

instanceVBO = gl_gen_buffer();
gl_bind_buffer(GL_ARRAY_BUFFER, instanceVBO);
gl_buffer_data(GL_ARRAY_BUFFER, buffer_get_size(modelMatricesBuffer), buffer_get_address(modelMatricesBuffer), GL_STATIC_DRAW);


planetVAO = gl_gen_vertex_array();
planetVBO = gl_gen_buffer();
gl_bind_vertex_array(planetVAO);
gl_bind_buffer(GL_ARRAY_BUFFER, planetVBO);
gl_buffer_data(GL_ARRAY_BUFFER, buffer_get_size(planetVbuff), buffer_get_address(planetVbuff), GL_STATIC_DRAW);
gl_enable_vertex_attrib_array(0);
gl_vertex_attrib_pointer(0, 3, GL_FLOAT, GL_FALSE, 5 * buffer_sizeof(buffer_f32), 0);
gl_enable_vertex_attrib_array(1);
gl_vertex_attrib_pointer(1, 2, GL_FLOAT, GL_FALSE, 5 * buffer_sizeof(buffer_f32), 3 * buffer_sizeof(buffer_f32));
gl_bind_vertex_array(noone);


asteroidVAO = gl_gen_vertex_array();
asteroidVBO = gl_gen_buffer();
gl_bind_vertex_array(asteroidVAO);
gl_bind_buffer(GL_ARRAY_BUFFER, asteroidVBO);
gl_buffer_data(GL_ARRAY_BUFFER, buffer_get_size(asteroidVbuff), buffer_get_address(asteroidVbuff), GL_STATIC_DRAW);
gl_enable_vertex_attrib_array(0);
gl_vertex_attrib_pointer(0, 3, GL_FLOAT, GL_FALSE, 5 * buffer_sizeof(buffer_f32), 0);
gl_enable_vertex_attrib_array(1);
gl_vertex_attrib_pointer(1, 2, GL_FLOAT, GL_FALSE, 5 * buffer_sizeof(buffer_f32), 3 * buffer_sizeof(buffer_f32));

gl_bind_vertex_array(asteroidVAO);
gl_bind_buffer(GL_ARRAY_BUFFER, instanceVBO);
gl_enable_vertex_attrib_array(3);
gl_vertex_attrib_pointer(3, 4, GL_FLOAT, GL_FALSE, (buffer_sizeof(buffer_f32)*16), 0);
gl_enable_vertex_attrib_array(4);
gl_vertex_attrib_pointer(4, 4, GL_FLOAT, GL_FALSE, (buffer_sizeof(buffer_f32)*16), (buffer_sizeof(buffer_f32)*4));
gl_enable_vertex_attrib_array(5);
gl_vertex_attrib_pointer(5, 4, GL_FLOAT, GL_FALSE, (buffer_sizeof(buffer_f32)*16), 2 * (buffer_sizeof(buffer_f32)*4));
gl_enable_vertex_attrib_array(6);
gl_vertex_attrib_pointer(6, 4, GL_FLOAT, GL_FALSE, (buffer_sizeof(buffer_f32)*16), 3 * (buffer_sizeof(buffer_f32)*4));
gl_bind_buffer(GL_ARRAY_BUFFER, noone);

gl_vertex_attrib_divisor(3, 1);
gl_vertex_attrib_divisor(4, 1);
gl_vertex_attrib_divisor(5, 1);
gl_vertex_attrib_divisor(6, 1);

gl_bind_vertex_array(noone);

texture = gmgl_texture_load("GMGL/container.jpg");

gl_use_program(planetShader);
gmgl_shader_set_int(planetShader, "texture_diffuse1", 0);
gl_use_program(asteroidShader);
gmgl_shader_set_int(asteroidShader, "texture_diffuse1", 0);

modelMatrixBuffer = buffer_create(16*buffer_sizeof(buffer_f32),buffer_fixed,4);
viewMatrixBuffer = buffer_create(16*buffer_sizeof(buffer_f32),buffer_fixed,4);
projMatrixBuffer = buffer_create(16*buffer_sizeof(buffer_f32),buffer_fixed,4);

// Let's make a camera to control with some user input
cameraPos = [0,100,-250];//x, y, z
cameraRot = [90,-32.5,0];//yaw, pitch, roll
cameraFront = vector_normalize([
	dcos(cameraRot[0]) * dcos(cameraRot[1]),
	dsin(cameraRot[1]),
	dsin(cameraRot[0]) * dcos(cameraRot[1])
]);
cameraUp = [0,1,0];
cameraSpeed = 50;
cameraLastX = 400;
cameraLastY = 300;
cameraFirstMouse = true;
cameraFOV = 45;
