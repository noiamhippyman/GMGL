/// @desc gmgl_shader_setup(vertexShaderSource,fragmentShaderSource);
/// @arg vertexShaderSource,fragmentShaderSource
var vsSource = argument0;
var fsSource = argument1;

// gmgl_create_shader creates and compiles a shader from it's source code
// It will tell you if the compilation fails in the output logs
var vshader = gmgl_create_shader(GL_VERTEX_SHADER, vsSource);
var fshader = gmgl_create_shader(GL_FRAGMENT_SHADER, fsSource);


var shaderProgram = gmgl_create_program();