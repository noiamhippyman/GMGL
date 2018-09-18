alarm_set(0,GMGL_ACTIVE_CHECK_TIME * game_get_speed(gamespeed_fps));

draw_enable_drawevent(false);

glfw_init();

glfw_window_hint(GLFW_CONTEXT_VERSION_MAJOR,3);
glfw_window_hint(GLFW_CONTEXT_VERSION_MINOR,3);

gmgl_create_window_centered(800,600,"Demo - Using Transforms");

var vertexShader = gl_create_shader(GL_VERTEX_SHADER,vertex_shader_transforms());
var fragmentShader = gl_create_shader(GL_FRAGMENT_SHADER,fragment_shader_transforms());
program = gl_create_program();
gl_attach_shader(program,vertexShader);
gl_attach_shader(program,fragmentShader);
gl_link_program(program);
gl_delete_shader(vertexShader);
gl_delete_shader(fragmentShader);

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

vao = gl_gen_vertex_array();
vbo = gl_gen_buffer();
ebo = gl_gen_buffer();

gl_bind_vertex_array(vao);

gl_bind_buffer(GL_ARRAY_BUFFER,vbo);
gl_buffer_data(GL_ARRAY_BUFFER,buffer_get_size(vbuff),buffer_get_address(vbuff),GL_STATIC_DRAW);

gl_bind_buffer(GL_ELEMENT_ARRAY_BUFFER,ebo);
gl_buffer_data(GL_ELEMENT_ARRAY_BUFFER,buffer_get_size(ibuff),buffer_get_address(ibuff),GL_STATIC_DRAW);

gl_vertex_attrib_pointer(0,3,GL_FLOAT,GMGL_FALSE,8,0);
gl_enable_vertex_attrib_array(0);
gl_vertex_attrib_pointer(1,3,GL_FLOAT,GMGL_FALSE,8,3);
gl_enable_vertex_attrib_array(1);
gl_vertex_attrib_pointer(2,2,GL_FLOAT,GMGL_FALSE,8,6);
gl_enable_vertex_attrib_array(2);

texture1 = gl_gen_texture();
gl_bind_texture(GL_TEXTURE_2D, texture1);
gl_tex_parameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_REPEAT);
gl_tex_parameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_REPEAT);
gl_tex_parameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
gl_tex_parameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);

var image = gmgl_load_image("container.jpg");
gl_texImage2D(GL_TEXTURE_2D, 0, GL_RGB, 0, GL_RGB, GL_UNSIGNED_BYTE, image);
gl_generate_mipmap(GL_TEXTURE_2D);
gmgl_free_image(image);

texture2 = gl_gen_texture();
gl_bind_texture(GL_TEXTURE_2D, texture2);
gl_tex_parameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_REPEAT);
gl_tex_parameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_REPEAT);
gl_tex_parameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
gl_tex_parameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);

image = gmgl_load_image("awesomeface.png");
gl_texImage2D(GL_TEXTURE_2D, 0, GL_RGB, 0, GL_RGBA, GL_UNSIGNED_BYTE, image);
gl_generate_mipmap(GL_TEXTURE_2D);
gmgl_free_image(image);

gl_bind_buffer(GL_ARRAY_BUFFER,0);
gl_bind_vertex_array(0);


gl_use_program(program);
gl_uniform1i(gl_get_uniform_location(program,"texture1"), 0);
gl_uniform1i(gl_get_uniform_location(program,"texture2"), 1);


matrixBuffer = buffer_create(16*buffer_sizeof(buffer_f32),buffer_fixed,4);

