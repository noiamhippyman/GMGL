gmgl_active_check_timer = 1000;
alarm_set(0,gmgl_active_check_timer * game_get_speed(gamespeed_fps));

draw_enable_drawevent(false);

gmgl_init();

gmgl_window_hint(GMGL_CONTEXT_VERSION_MAJOR,3);
gmgl_window_hint(GMGL_CONTEXT_VERSION_MINOR,3);

gmgl_create_window(800,600,"Demo - Using Textures");

var vertexShader = gmgl_create_shader(GMGL_VERTEX_SHADER,vertex_shader_more_attributes1());
var fragmentShader = gmgl_create_shader(GMGL_FRAGMENT_SHADER,fragment_shader_more_attributes1());
program = gmgl_create_program();
gmgl_attach_shader(program,vertexShader);
gmgl_attach_shader(program,fragmentShader);
gmgl_link_program(program);
gmgl_delete_shader(vertexShader);
gmgl_delete_shader(fragmentShader);

var vertices = [
	//Positions			//Colors		//TexCoords
	 0.5,  0.5, 0.0,	1.0, 0.0, 0.0,	1.0, 1.0,
	 0.5, -0.5, 0.0,	0.0, 1.0, 0.0,	1.0, 0.0,
	-0.5, -0.5, 0.0,	0.0, 0.0, 1.0,	0.0, 0.0,
	-0.5,  0.5, 0.0,	1.0, 1.0, 0.0,	0.0, 1.0
];

var indices = [
	0,1,3,//first triangle
	1,2,3 //second triangle
];

var vcount = array_length_1d(vertices);
vbuff = buffer_create(vcount*buffer_sizeof(buffer_u32),buffer_fixed,4);
for (var i = 0; i < vcount; ++i) {
	buffer_write(vbuff,buffer_f32,vertices[i]);
}

var icount = array_length_1d(indices);
ibuff = buffer_create(icount*buffer_sizeof(buffer_u32),buffer_fixed,4);
for (var i = 0; i < icount; ++i) {
	buffer_write(ibuff,buffer_u32,indices[i]);
}

vao = gmgl_gen_vertex_array();
vbo = gmgl_gen_buffer();
ebo = gmgl_gen_buffer();

gmgl_bind_vertex_array(vao);

gmgl_bind_buffer(GMGL_ARRAY_BUFFER,vbo);
gmgl_buffer_data(GMGL_ARRAY_BUFFER,buffer_get_size(vbuff),buffer_get_address(vbuff),GMGL_STATIC_DRAW);

gmgl_bind_buffer(GMGL_ELEMENT_ARRAY_BUFFER,ebo);
gmgl_buffer_data(GMGL_ELEMENT_ARRAY_BUFFER,buffer_get_size(ibuff),buffer_get_address(ibuff),GMGL_STATIC_DRAW);

gmgl_vertex_attrib_pointer(0,3,GMGL_FALSE,8,0);
gmgl_enable_vertex_attrib_array(0);
gmgl_vertex_attrib_pointer(1,3,GMGL_FALSE,8,3);
gmgl_enable_vertex_attrib_array(1);
gmgl_vertex_attrib_pointer(2,2,GMGL_FALSE,8,6);
gmgl_enable_vertex_attrib_array(2);

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




