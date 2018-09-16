/// @desc gmgl_shader_set_float(program,uniform,value);
/// @arg program,uniform,vector
var program = argument0;
var uniform = argument1;
var v = argument2;

gl_uniform1f(gl_get_uniform_location(program,uniform),v);