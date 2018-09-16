alarm_set(0,GMGL_ACTIVE_CHECK_TIME * game_get_speed(gamespeed_fps));

draw_enable_drawevent(false);

gmgl_init();

gmgl_window_hint(GMGL_CONTEXT_VERSION_MAJOR,3);
gmgl_window_hint(GMGL_CONTEXT_VERSION_MINOR,3);

gmgl_create_window_centered(800,600,"Demo - Using Element Buffers");

var vertexShader = gmgl_create_shader(GMGL_VERTEX_SHADER,vertex_shader());
var fragmentShader = gmgl_create_shader(GMGL_FRAGMENT_SHADER,fragment_shader());
program = gmgl_create_program();
gmgl_attach_shader(program,vertexShader);
gmgl_attach_shader(program,fragmentShader);
gmgl_link_program(program);
gmgl_delete_shader(vertexShader);
gmgl_delete_shader(fragmentShader);

var vertices = [
	 0.5,  0.5, 0.0,  // top right
	 0.5, -0.5, 0.0,  // bottom right
	-0.5, -0.5, 0.0,  // bottom left
	-0.5,  0.5, 0.0   // top left 
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

gmgl_vertex_attrib_pointer(0,3,GMGL_FALSE,3,0);
gmgl_enable_vertex_attrib_array(0);

gmgl_bind_buffer(GMGL_ARRAY_BUFFER,0);
gmgl_bind_vertex_array(0);





