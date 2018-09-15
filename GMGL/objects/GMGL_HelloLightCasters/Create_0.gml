alarm_set(0,GMGL_ACTIVE_CHECK_TIME * game_get_speed(gamespeed_fps));

draw_enable_drawevent(false);

scr_width = 1600;
scr_height = 900;

cameraPos = [0,0,-3];
cameraUp = [0,1,0];
cameraSpeed = 2.5;
cameraYaw = 90;
cameraPitch = 0;
cameraRoll = 0;
cameraFront = vector_normalize([
	dcos(cameraYaw) * dcos(cameraPitch),
	dsin(cameraPitch),
	dsin(cameraYaw) * dcos(cameraPitch)
]);
cameraLastX = 0;
cameraLastY = 0;
cameraFirstMouse = true;

modelMatrixBuffer = buffer_create(16*buffer_sizeof(buffer_f32),buffer_fixed,4);
viewMatrixBuffer = buffer_create(16*buffer_sizeof(buffer_f32),buffer_fixed,4);
projMatrixBuffer = buffer_create(16*buffer_sizeof(buffer_f32),buffer_fixed,4);

gmgl_init();

gmgl_window_hint(GMGL_CONTEXT_VERSION_MAJOR,3);
gmgl_window_hint(GMGL_CONTEXT_VERSION_MINOR,3);

gmgl_create_window(scr_width,scr_height,"Demo - Different Light Casters");

gmgl_enable(GMGL_DEPTH_TEST);

var vertexShader = gmgl_create_shader(GMGL_VERTEX_SHADER, vertex_shader_light_casters());
var fragmentShader = gmgl_create_shader(GMGL_FRAGMENT_SHADER, fragment_shader_light_casters());
shaderMaterial = gmgl_create_program();
gmgl_attach_shader(shaderMaterial,vertexShader);
gmgl_attach_shader(shaderMaterial,fragmentShader);
gmgl_link_program(shaderMaterial);
gmgl_delete_shader(vertexShader);
gmgl_delete_shader(fragmentShader);

vertexShader = gmgl_create_shader(GMGL_VERTEX_SHADER, vertex_shader_basic_lamp_2());
fragmentShader = gmgl_create_shader(GMGL_FRAGMENT_SHADER, fragment_shader_basic_lamp_2());
shaderLamp = gmgl_create_program();
gmgl_attach_shader(shaderLamp,vertexShader);
gmgl_attach_shader(shaderLamp,fragmentShader);
gmgl_link_program(shaderLamp);
gmgl_delete_shader(vertexShader);
gmgl_delete_shader(fragmentShader);

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

cubePositions = [
	[ 0.0,  0.0,  0.0],
	[ 2.0,  5.0, -15.0],
	[-1.5, -2.2, -2.5],
	[-3.8, -2.0, -12.3],
	[ 2.4, -0.4, -3.5],
	[-1.7,  3.0, -7.5],
	[ 1.3, -2.0, -2.5],
	[ 1.5,  2.0, -2.5],
	[ 1.5,  0.2, -1.5],
	[-1.3,  1.0, -1.5]
];
// positions of the point lights
pointLightPositions = [
	[ 0.7,  0.2,  -2.0],
	[ 2.3, -3.3, 4.0],
	[-4.0,  2.0, 12.0],
	[ 0.0,  0.0, 3.0]
];

pointLightColors = [
	[1,0,0],
	[0,1,0],
	[0,0,1],
	[1,1,0]
];

var vcount = array_length_1d(vertices);
vbuff = buffer_create(vcount*buffer_sizeof(buffer_u32),buffer_fixed,4);
for (var i = 0; i < vcount; ++i) {
	buffer_write(vbuff,buffer_f32,vertices[i]);
}

vbo = gmgl_gen_buffer();
gmgl_bind_buffer(GMGL_ARRAY_BUFFER,vbo);
gmgl_buffer_data(GMGL_ARRAY_BUFFER,buffer_get_size(vbuff),buffer_get_address(vbuff),GMGL_STATIC_DRAW);

cubevao = gmgl_gen_vertex_array();
gmgl_bind_vertex_array(cubevao);
gmgl_vertex_attrib_pointer(0,3,GMGL_FALSE,8,0);
gmgl_enable_vertex_attrib_array(0);
gmgl_vertex_attrib_pointer(1,3,GMGL_FALSE,8,3);
gmgl_enable_vertex_attrib_array(1);
gmgl_vertex_attrib_pointer(2,2,GMGL_FALSE,8,6);
gmgl_enable_vertex_attrib_array(2);

lightvao = gmgl_gen_vertex_array();
gmgl_bind_vertex_array(lightvao);
gmgl_vertex_attrib_pointer(0,3,GMGL_FALSE,8,0);
gmgl_enable_vertex_attrib_array(0);

diffuseMap = gmgl_load_texture("container2.png");
specularMap = gmgl_load_texture("container2_specular.png");

gmgl_use_program(shaderMaterial);
gmgl_shader_set_int(shaderMaterial,"material.diffuse",0);
gmgl_shader_set_int(shaderMaterial,"material.specular",1);














