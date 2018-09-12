gmgl_active_check_timer = 1000;
alarm_set(0,gmgl_active_check_timer * game_get_speed(gamespeed_fps));

draw_enable_drawevent(false);

gmgl_init();

gmgl_window_hint(GMGL_CONTEXT_VERSION_MAJOR,3);
gmgl_window_hint(GMGL_CONTEXT_VERSION_MINOR,3);

gmgl_create_window(800,600,"Demo - Setting up Attributes");

var vertexShader = gmgl_create_shader(GMGL_VERTEX_SHADER,vertex_shader_more_attributes());
var fragmentShader = gmgl_create_shader(GMGL_FRAGMENT_SHADER,fragment_shader_more_attributes());
program = gmgl_create_program();
gmgl_attach_shader(program,vertexShader);
gmgl_attach_shader(program,fragmentShader);
gmgl_link_program(program);
gmgl_delete_shader(vertexShader);
gmgl_delete_shader(fragmentShader);

var v = [
	//Positions			//Colors
	-0.5,-0.5, 0.0,		1.0, 0.0, 0.0,
	 0.5,-0.5, 0.0,		0.0, 1.0, 0.0,
	 0.0, 0.5, 0.0,		0.0, 0.0, 1.0
];
var vcount = array_length_1d(v);
vbuff = buffer_create(vcount*buffer_sizeof(buffer_u32),buffer_fixed,4);
for (var i = 0; i < vcount; ++i) {
	buffer_write(vbuff,buffer_f32,v[i]);
}

vao = gmgl_gen_vertex_array();
vbo = gmgl_gen_buffer();

gmgl_bind_vertex_array(vao);

gmgl_bind_buffer(GMGL_ARRAY_BUFFER,vbo);
gmgl_buffer_data(GMGL_ARRAY_BUFFER,buffer_get_size(vbuff),buffer_get_address(vbuff),GMGL_STATIC_DRAW);

gmgl_vertex_attrib_pointer(0,3,GMGL_FALSE,6,0);
gmgl_enable_vertex_attrib_array(0);
gmgl_vertex_attrib_pointer(1,3,GMGL_FALSE,6,3);
gmgl_enable_vertex_attrib_array(1);

gmgl_bind_buffer(GMGL_ARRAY_BUFFER,0);
gmgl_bind_vertex_array(0);





