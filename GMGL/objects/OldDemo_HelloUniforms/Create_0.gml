alarm_set(0,GMGL_ACTIVE_CHECK_TIME * game_get_speed(gamespeed_fps));

draw_enable_drawevent(false);

glfw_init();

glfw_window_hint(GLFW_CONTEXT_VERSION_MAJOR,3);
glfw_window_hint(GLFW_CONTEXT_VERSION_MINOR,3);

gmgl_create_window_centered(800,600,"Demo - Using Shader Uniforms");

var vertexShader = gl_create_shader(GL_VERTEX_SHADER,vertex_shader_uniforms());
var fragmentShader = gl_create_shader(GL_FRAGMENT_SHADER,fragment_shader_uniforms());
program = gl_create_program();
gl_attach_shader(program,vertexShader);
gl_attach_shader(program,fragmentShader);
gl_link_program(program);
gl_delete_shader(vertexShader);
gl_delete_shader(fragmentShader);

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

vao = gl_gen_vertex_array();
vbo = gl_gen_buffer();
ebo = gl_gen_buffer();

gl_bind_vertex_array(vao);

gl_bind_buffer(GL_ARRAY_BUFFER,vbo);
gl_buffer_data(GL_ARRAY_BUFFER,buffer_get_size(vbuff),buffer_get_address(vbuff),GL_STATIC_DRAW);

gl_bind_buffer(GL_ELEMENT_ARRAY_BUFFER,ebo);
gl_buffer_data(GL_ELEMENT_ARRAY_BUFFER,buffer_get_size(ibuff),buffer_get_address(ibuff),GL_STATIC_DRAW);

gl_vertex_attrib_pointer(0,3,GL_FLOAT,GMGL_FALSE,3,0);
gl_enable_vertex_attrib_array(0);

gl_bind_buffer(GL_ARRAY_BUFFER,0);
gl_bind_vertex_array(0);

colorUniform = gl_get_uniform_location(program,"ourColor");





