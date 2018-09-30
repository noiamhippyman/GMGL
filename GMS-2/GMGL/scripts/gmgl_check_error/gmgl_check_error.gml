/// @desc gmgl_check_error(msg);
/// @arg msg
var msg = argument0;
var errorCode = gl_get_error();
var error = "";
switch (errorCode) {
    case GL_INVALID_ENUM:					error = "INVALID_ENUM"; break;
    case GL_INVALID_VALUE:					error = "INVALID_VALUE"; break;
    case GL_INVALID_OPERATION:				error = "INVALID_OPERATION"; break;
    case GL_STACK_OVERFLOW:					error = "STACK_OVERFLOW"; break;
    case GL_STACK_UNDERFLOW:				error = "STACK_UNDERFLOW"; break;
    case GL_OUT_OF_MEMORY:					error = "OUT_OF_MEMORY"; break;
    case GL_INVALID_FRAMEBUFFER_OPERATION:	error = "INVALID_FRAMEBUFFER_OPERATION"; break;
	default:								error = "NO_ERROR"; break;
}

show_debug_message(msg + "::" + error);