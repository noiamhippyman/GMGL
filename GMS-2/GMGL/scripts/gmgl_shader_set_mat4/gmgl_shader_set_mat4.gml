/// @desc gmgl_shader_set_mat4(program,uniform,matrix);
/// @arg program,uniform,matrix
var program = argument0;
var uniform = argument1;
var m = argument2;

gl_uniform_mat4fv(gl_get_uniform_location(program,uniform),1,GMGL_FALSE,buffer_get_address(m));

show_debug_message("Shader set mat4");