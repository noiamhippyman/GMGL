/// @desc gmgl_shader_set_vec3(program,uniform,vector);
/// @arg program,uniform,vector
var program = argument0;
var uniform = argument1;
var v = argument2;

var loc = gmgl_get_uniform_location(program,uniform);
gmgl_uniform3f(loc,v[0],v[1],v[2]);