/// @desc gmgl_shader_create(vertex,fragment);
/// @arg vertex,fragment
var vertShader = gl_create_shader(GL_VERTEX_SHADER,argument0);
var fragShader = gl_create_shader(GL_FRAGMENT_SHADER,argument1);

/*
	Create shader program
	
	The shaders by themselves are useless. You still need to create a program.
	Then attach any shaders you want to the program and finally link the program.
*/
var program = gl_create_program();
gl_attach_shader(program,vertShader);
gl_attach_shader(program,fragShader);
gl_link_program(program);

/*
	Delete shaders
	
	After linking a program you don't need the shaders anymore. 
	You can delete them when you don't need them anymore.
*/
gl_delete_shader(vertShader);
gl_delete_shader(fragShader);

return program;