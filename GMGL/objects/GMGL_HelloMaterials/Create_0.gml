alarm_set(0,GMGL_ACTIVE_CHECK_TIME * game_get_speed(gamespeed_fps));

draw_enable_drawevent(false);

var scr_width = 1600;
var scr_height = 900;
cubePos = [0,0,0];
lightPos = [1.2,1,2];
lightColor = [1,1,1];
lightSpecular = 0.5;

matAmbient = [1.0, 0.5, 0.31];
matDiffuse = [1.0, 0.5, 0.31];
matSpecular = 0.5;
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


gmgl_init();

gmgl_window_hint(GMGL_CONTEXT_VERSION_MAJOR,3);
gmgl_window_hint(GMGL_CONTEXT_VERSION_MINOR,3);

gmgl_create_window(scr_width,scr_height,"Demo - Basic Materials");

gmgl_enable(GMGL_DEPTH_TEST);

var vertexShader = gmgl_create_shader(GMGL_VERTEX_SHADER, vertex_shader_materials());
var fragmentShader = gmgl_create_shader(GMGL_FRAGMENT_SHADER, fragment_shader_materials());
shaderMaterial = gmgl_create_program();
gmgl_attach_shader(shaderMaterial,vertexShader);
gmgl_attach_shader(shaderMaterial,fragmentShader);
gmgl_link_program(shaderMaterial);
gmgl_delete_shader(vertexShader);
gmgl_delete_shader(fragmentShader);

vertexShader = gmgl_create_shader(GMGL_VERTEX_SHADER, vertex_shader_basic_lamp());
fragmentShader = gmgl_create_shader(GMGL_FRAGMENT_SHADER, fragment_shader_basic_lamp());
shaderLamp = gmgl_create_program();
gmgl_attach_shader(shaderLamp,vertexShader);
gmgl_attach_shader(shaderLamp,fragmentShader);
gmgl_link_program(shaderLamp);
gmgl_delete_shader(vertexShader);
gmgl_delete_shader(fragmentShader);

var vertices = [
	-0.5, -0.5, -0.5,  0.0,  0.0, -1.0,
	 0.5, -0.5, -0.5,  0.0,  0.0, -1.0,
	 0.5,  0.5, -0.5,  0.0,  0.0, -1.0,
	 0.5,  0.5, -0.5,  0.0,  0.0, -1.0,
	-0.5,  0.5, -0.5,  0.0,  0.0, -1.0,
	-0.5, -0.5, -0.5,  0.0,  0.0, -1.0,

	-0.5, -0.5,  0.5,  0.0,  0.0,  1.0,
	 0.5, -0.5,  0.5,  0.0,  0.0,  1.0,
	 0.5,  0.5,  0.5,  0.0,  0.0,  1.0,
	 0.5,  0.5,  0.5,  0.0,  0.0,  1.0,
	-0.5,  0.5,  0.5,  0.0,  0.0,  1.0,
	-0.5, -0.5,  0.5,  0.0,  0.0,  1.0,

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

var vcount = array_length_1d(vertices);
vbuff = buffer_create(vcount*buffer_sizeof(buffer_u32),buffer_fixed,4);
for (var i = 0; i < vcount; ++i) {
	buffer_write(vbuff,buffer_f32,vertices[i]);
}

cubevao = gmgl_gen_vertex_array();
vbo = gmgl_gen_buffer();

gmgl_bind_buffer(GMGL_ARRAY_BUFFER,vbo);
gmgl_buffer_data(GMGL_ARRAY_BUFFER,buffer_get_size(vbuff),buffer_get_address(vbuff),GMGL_STATIC_DRAW);

gmgl_bind_vertex_array(cubevao);

gmgl_vertex_attrib_pointer(0,3,GMGL_FALSE,6,0);
gmgl_enable_vertex_attrib_array(0);

gmgl_vertex_attrib_pointer(1,3,GMGL_FALSE,6,3);
gmgl_enable_vertex_attrib_array(1);


lightvao = gmgl_gen_vertex_array();
gmgl_bind_vertex_array(lightvao);

gmgl_bind_buffer(GMGL_ARRAY_BUFFER, vbo);

gmgl_vertex_attrib_pointer(0,3,GMGL_FALSE,6,0);
gmgl_enable_vertex_attrib_array(0);

//uniforms
u_matAmbient = gmgl_get_uniform_location(shaderMaterial,"material.ambient");
u_matDiffuse = gmgl_get_uniform_location(shaderMaterial,"material.diffuse");
u_matSpecular = gmgl_get_uniform_location(shaderMaterial,"material.specular");
u_matShininess = gmgl_get_uniform_location(shaderMaterial,"material.shininess");

u_lightPos = gmgl_get_uniform_location(shaderMaterial,"light.position");
u_lightAmbient = gmgl_get_uniform_location(shaderMaterial,"light.ambient");
u_lightDiffuse = gmgl_get_uniform_location(shaderMaterial,"light.diffuse");
u_lightSpecular = gmgl_get_uniform_location(shaderMaterial,"light.specular");

u_viewPos = gmgl_get_uniform_location(shaderMaterial,"viewPos");











