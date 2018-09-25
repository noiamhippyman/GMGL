/// @desc gmgl_shader_set_int(program,uniform,value);
/// @arg program,uniform,value
var program = argument0;
var uniform = argument1;
var v = argument2;

gl_uniform1i(gl_get_uniform_location(program,uniform),v);