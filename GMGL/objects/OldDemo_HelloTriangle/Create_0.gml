alarm_set(0,GMGL_ACTIVE_CHECK_TIME * game_get_speed(gamespeed_fps));

draw_enable_drawevent(false);

gmgl_init();

gmgl_window_hint(GLFW_CONTEXT_VERSION_MAJOR,3);
gmgl_window_hint(GLFW_CONTEXT_VERSION_MINOR,3);

gmgl_create_window_centered(800,600,"Demo - Hello Triangle");

var vertexShader = gmgl_create_shader(GL_VERTEX_SHADER,vertex_shader());
var fragmentShader = gmgl_create_shader(GL_FRAGMENT_SHADER,fragment_shader());
program = gmgl_create_program();
gmgl_attach_shader(program,vertexShader);
gmgl_attach_shader(program,fragmentShader);
gmgl_link_program(program);
gmgl_delete_shader(vertexShader);
gmgl_delete_shader(fragmentShader);

var v = [
	-0.5,-0.5, 0.0,
	 0.5,-0.5, 0.0,
	 0.0, 0.5, 0.0
];
var vcount = array_length_1d(v);
vbuff = buffer_create(vcount*buffer_sizeof(buffer_u32),buffer_fixed,4);
for (var i = 0; i < vcount; ++i) {
	buffer_write(vbuff,buffer_f32,v[i]);
}

vao = gmgl_gen_vertex_array();
vbo = gmgl_gen_buffer();

gmgl_bind_vertex_array(vao);

gmgl_bind_buffer(GL_ARRAY_BUFFER,vbo);
gmgl_buffer_data(GL_ARRAY_BUFFER,buffer_get_size(vbuff),buffer_get_address(vbuff),GL_STATIC_DRAW);

gmgl_vertex_attrib_pointer(0,3,GMGL_FALSE,3,0);
gmgl_enable_vertex_attrib_array(0);

gmgl_bind_buffer(GL_ARRAY_BUFFER,0);
gmgl_bind_vertex_array(0);





