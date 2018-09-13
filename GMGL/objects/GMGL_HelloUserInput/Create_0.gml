alarm_set(0,GMGL_ACTIVE_CHECK_TIME * game_get_speed(gamespeed_fps));

draw_enable_drawevent(false);

gmgl_init();

gmgl_window_hint(GMGL_CONTEXT_VERSION_MAJOR,3);
gmgl_window_hint(GMGL_CONTEXT_VERSION_MINOR,3);

var scr_width = 1600;
var scr_height = 900;

gmgl_create_window(scr_width,scr_height,"Demo - Using Inputs (keyboard, mouse, joystick)");

gmgl_enable(GMGL_DEPTH_TEST);

var vertexShader = gmgl_create_shader(GMGL_VERTEX_SHADER,vertex_shader_cube());
var fragmentShader = gmgl_create_shader(GMGL_FRAGMENT_SHADER,fragment_shader_cube());
program = gmgl_create_program();
gmgl_attach_shader(program,vertexShader);
gmgl_attach_shader(program,fragmentShader);
gmgl_link_program(program);
gmgl_delete_shader(vertexShader);
gmgl_delete_shader(fragmentShader);

var vertices = [
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

var vcount = array_length_1d(vertices);
vbuff = buffer_create(vcount*buffer_sizeof(buffer_u32),buffer_fixed,4);
for (var i = 0; i < vcount; ++i) {
	buffer_write(vbuff,buffer_f32,vertices[i]);
}

vao = gmgl_gen_vertex_array();
vbo = gmgl_gen_buffer();

gmgl_bind_vertex_array(vao);

gmgl_bind_buffer(GMGL_ARRAY_BUFFER,vbo);
gmgl_buffer_data(GMGL_ARRAY_BUFFER,buffer_get_size(vbuff),buffer_get_address(vbuff),GMGL_STATIC_DRAW);

gmgl_vertex_attrib_pointer(0,3,GMGL_FALSE,5,0);
gmgl_enable_vertex_attrib_array(0);
gmgl_vertex_attrib_pointer(1,2,GMGL_FALSE,5,3);
gmgl_enable_vertex_attrib_array(1);

texture1 = gmgl_gen_texture();
gmgl_bind_texture(GMGL_TEXTURE_2D, texture1);
gmgl_tex_parameteri(GMGL_TEXTURE_2D, GMGL_TEXTURE_WRAP_S, GMGL_REPEAT);
gmgl_tex_parameteri(GMGL_TEXTURE_2D, GMGL_TEXTURE_WRAP_T, GMGL_REPEAT);
gmgl_tex_parameteri(GMGL_TEXTURE_2D, GMGL_TEXTURE_MIN_FILTER, GMGL_LINEAR);
gmgl_tex_parameteri(GMGL_TEXTURE_2D, GMGL_TEXTURE_MAG_FILTER, GMGL_LINEAR);

var image = gmgl_load_image("container.jpg");
gmgl_texImage2D(GMGL_TEXTURE_2D, 0, GMGL_RGB,0,GMGL_RGB,image);
gmgl_generate_mipmap(GMGL_TEXTURE_2D);
gmgl_free_image(image);

texture2 = gmgl_gen_texture();
gmgl_bind_texture(GMGL_TEXTURE_2D, texture2);
gmgl_tex_parameteri(GMGL_TEXTURE_2D, GMGL_TEXTURE_WRAP_S, GMGL_REPEAT);
gmgl_tex_parameteri(GMGL_TEXTURE_2D, GMGL_TEXTURE_WRAP_T, GMGL_REPEAT);
gmgl_tex_parameteri(GMGL_TEXTURE_2D, GMGL_TEXTURE_MIN_FILTER, GMGL_LINEAR);
gmgl_tex_parameteri(GMGL_TEXTURE_2D, GMGL_TEXTURE_MAG_FILTER, GMGL_LINEAR);

image = gmgl_load_image("awesomeface.png");
gmgl_texImage2D(GMGL_TEXTURE_2D, 0, GMGL_RGB,0,GMGL_RGBA,image);
gmgl_generate_mipmap(GMGL_TEXTURE_2D);
gmgl_free_image(image);

gmgl_bind_buffer(GMGL_ARRAY_BUFFER,0);
gmgl_bind_vertex_array(0);


gmgl_use_program(program);
gmgl_uniform1i(gmgl_get_uniform_location(program,"texture1"), 0);
gmgl_uniform1i(gmgl_get_uniform_location(program,"texture2"), 1);
uModel = gmgl_get_uniform_location(program,"model");
uView = gmgl_get_uniform_location(program,"view");
uProj = gmgl_get_uniform_location(program,"projection");

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


modelPositions = [
	[0,0,0],
	[2,5,-15],
	[-1.5,-2.2,-2.5],
	[-3.8,-2,-12.3],
	[2.4,-0.4,-3.5],
	[-1.7,3,-7.5],
	[1.3,-2,-2.5],
	[1.5,2,-2.5],
	[1.5,0.2,-1.5],
	[-1.3,1,-1.5]
];


cameraPos = [0,0,3];
cameraFront = [0,0,-1];
cameraUp = [0,1,0];
cameraSpeed = 2.5;
cameraYaw = -90;
cameraPitch = 0;
cameraRoll = 0;
cameraLastX = scr_width / 2;
cameraLastY = scr_height / 2;
cameraFirstMouse = true;