/// @desc gmgl_shader_set_vec3(program,uniform,vector);
/// @arg program,uniform,vector
var program = argument0;
var uniform = argument1;
var v = argument2;

// When setting a uniform value you first need
// to locate the uniform to pass to the set functions
var loc = gl_get_uniform_location(program,uniform);

// After you have the uniform location you can apply 
// your values to it.
gl_uniform3f(loc,v[0],v[1],v[2]);