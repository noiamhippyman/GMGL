alarm_set(0,GMGL_ACTIVE_CHECK_TIME * game_get_speed(gamespeed_fps));

draw_enable_drawevent(false);

var scr_width = 800;
var scr_height = 600;
cubePos = [0,0,0];
lightPos = [1.2,1,2];
lightColor = [1,1,1];
lightSpecular = 1;

matShininess = 32;

cameraPos = [0,0,3];
cameraFront = [0,0,-1];
cameraUp = [0,1,0];
cameraSpeed = 2.5;
cameraYaw = -90;
cameraPitch = 0;
cameraRoll = 0;
cameraLastX = 0;
cameraLastY = 0;
cameraFirstMouse = true;

modelMatrixBuffer = buffer_create(16*buffer_sizeof(buffer_f32),buffer_fixed,4);

var view = gmgl_matrix_build(0,0,-3,0,0,0,1,1,1);
viewMatrixBuffer = buffer_create(16*buffer_sizeof(buffer_f32),buffer_fixed,4);
buffer_seek(viewMatrixBuffer,buffer_seek_start,0);
for (var i = 0; i < 16; ++i) {
	buffer_write(viewMatrixBuffer,buffer_f32,view[i]);
}

var proj = matrix_build_projection_perspective_fov(45,scr_width/scr_height,0.1,1000.0);
projMatrixBuffer = buffer_create(16*buffer_sizeof(buffer_f32),buffer_fixed,4);
buffer_seek(projMatrixBuffer,buffer_seek_start,0);
for (var i = 0; i < 16; ++i) {
	buffer_write(projMatrixBuffer,buffer_f32,proj[i]);
}


glfw_init();

glfw_window_hint(GLFW_CONTEXT_VERSION_MAJOR,3);
glfw_window_hint(GLFW_CONTEXT_VERSION_MINOR,3);

gmgl_create_window_centered(scr_width,scr_height,"Demo - Using Lighting Maps");

gl_enable(GL_DEPTH_TEST);

var vertexShader = gl_create_shader(GL_VERTEX_SHADER, vertex_shader_light_maps());
var fragmentShader = gl_create_shader(GL_FRAGMENT_SHADER, fragment_shader_light_maps());
shaderMaterial = gl_create_program();
gl_attach_shader(shaderMaterial,vertexShader);
gl_attach_shader(shaderMaterial,fragmentShader);
gl_link_program(shaderMaterial);
gl_delete_shader(vertexShader);
gl_delete_shader(fragmentShader);

vertexShader = gl_create_shader(GL_VERTEX_SHADER, vertex_shader_basic_lamp());
fragmentShader = gl_create_shader(GL_FRAGMENT_SHADER, fragment_shader_basic_lamp());
shaderLamp = gl_create_program();
gl_attach_shader(shaderLamp,vertexShader);
gl_attach_shader(shaderLamp,fragmentShader);
gl_link_program(shaderLamp);
gl_delete_shader(vertexShader);
gl_delete_shader(fragmentShader);

var vertices = [
	// positions       // normals        // uv
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
	 0.5, -0.5,  0.5,  1.0,  0.0,  0.0,  0.0,  0.0,
	 0.5,  0.5,  0.5,  1.0,  0.0,  0.0,  1.0,  0.0,

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
vbuff = buffer_create(vcount*buffer_sizeof(buffer_u32),buffer_fixed,4);
for (var i = 0; i < vcount; ++i) {
	buffer_write(vbuff,buffer_f32,vertices[i]);
}

cubevao = gl_gen_vertex_array();
vbo = gl_gen_buffer();

gl_bind_buffer(GL_ARRAY_BUFFER,vbo);
gl_buffer_data(GL_ARRAY_BUFFER,buffer_get_size(vbuff),buffer_get_address(vbuff),GL_STATIC_DRAW);

gl_bind_vertex_array(cubevao);

gl_vertex_attrib_pointer(0,3,GMGL_FALSE,8,0);
gl_enable_vertex_attrib_array(0);

gl_vertex_attrib_pointer(1,3,GMGL_FALSE,8,3);
gl_enable_vertex_attrib_array(1);

gl_vertex_attrib_pointer(2,2,GMGL_FALSE,8,6);
gl_enable_vertex_attrib_array(2);


lightvao = gl_gen_vertex_array();
gl_bind_vertex_array(lightvao);

gl_bind_buffer(GL_ARRAY_BUFFER, vbo);

gl_vertex_attrib_pointer(0,3,GMGL_FALSE,8,0);
gl_enable_vertex_attrib_array(0);


diffuseMap = gmgl_load_texture("container2.png");
specularMap = gmgl_load_texture("container2_specular.png");

//uniforms
//u_matAmbient = gl_get_uniform_location(shaderMaterial,"material.ambient");
u_matDiffuse = gl_get_uniform_location(shaderMaterial,"material.diffuse");
u_matSpecular = gl_get_uniform_location(shaderMaterial,"material.specular");
u_matShininess = gl_get_uniform_location(shaderMaterial,"material.shininess");

u_lightPos = gl_get_uniform_location(shaderMaterial,"light.position");
u_lightAmbient = gl_get_uniform_location(shaderMaterial,"light.ambient");
u_lightDiffuse = gl_get_uniform_location(shaderMaterial,"light.diffuse");
u_lightSpecular = gl_get_uniform_location(shaderMaterial,"light.specular");

u_viewPos = gl_get_uniform_location(shaderMaterial,"viewPos");


gl_use_program(shaderMaterial);
gl_uniform1i(u_matDiffuse, 0);
gl_uniform1i(u_matSpecular, 1);










