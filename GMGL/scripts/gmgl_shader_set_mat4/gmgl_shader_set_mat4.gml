/// @desc gmgl_shader_set_mat4(program,uniform,matrix);
/// @arg program,uniform,matrix
var program = argument0;
var uniform = argument1;
var m = argument2;

gmgl_uniform_mat4fv(gmgl_get_uniform_location(program,uniform),1,GMGL_FALSE,buffer_get_address(m));