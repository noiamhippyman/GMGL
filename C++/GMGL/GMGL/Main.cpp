#define GLEW_STATIC
#include <GL/glew.h>
#include <GLFW/glfw3.h>

#define STB_IMAGE_IMPLEMENTATION
#include "stb_image.h"

//#include <glm/glm.hpp>
//#include <glm/gtc/matrix_transform.hpp>
//#include <glm/gtc/type_ptr.hpp>

#include <vector>
#include <iostream>
#include <string>
#include "GMS_Extension.hpp"

#pragma region Internal Stuff

//Forward Declarations
GMS_DLL void glfw_terminate();

#pragma region Data structures

struct GMGLimage {
	GLsizei width;
	GLsizei height;
	GLsizei nrChannels;
	unsigned char* data;
};

struct GMGLmouse {
	double x;
	double y;
	double scrollX;
	double scrollY;
};

enum eGMGLevent {
	Error,
	FramebufferSize,
	WindowClose,
	MousePos
};

class GMGLevent {
public:
	GMGLevent(eGMGLevent);
	void add_var(char* name, double value);
	void add_var(char* name, char* value);
	void trigger();

private:
	eGMGLevent type;
	gml_ds_map map;
};

GMGLevent::GMGLevent(eGMGLevent type) {
	map = gml_ds_map_create();
	add_var("event", type);
}

void GMGLevent::add_var(char* name, double value) {
	gml_ds_map_set_double(map, name, value);
}

void GMGLevent::add_var(char* name, char* value) {
	gml_ds_map_set_string(map, name, value);
}

void GMGLevent::trigger() {
	gml_event_perform_async(map, EVENT_OTHER_SOCIAL);
}

#pragma endregion

//Global variables
std::vector<GMGLimage*> __gmgl_images;
std::vector<GLuint> __gmgl_image_slots;

GMGLmouse __gmgl_mouse;
GLFWwindow* __gmgl_window = nullptr;

//Pointer management functions
double gmgl_new_image() {
	double index;
	GMGLimage* object = new GMGLimage;

	if (!__gmgl_image_slots.empty()) {
		index = __gmgl_image_slots.back();
		__gmgl_image_slots.pop_back();
		__gmgl_images[index] = object;
	}
	else {
		index = __gmgl_images.size();
		__gmgl_images.push_back(object);
	}

	return index;
}
GMGLimage* gmgl_get_image(double id) {
	return __gmgl_images[id];
}
void gmgl_delete_image(double id) {
	if (__gmgl_images.size() > id && __gmgl_images[id] != nullptr) {
		delete __gmgl_images[id];
		__gmgl_images[id] = nullptr;
		__gmgl_image_slots.push_back(id);
	}
}

#pragma region Callbacks

void gmgl_callback_error(int error, const char* description) {
	GMGLevent e(eGMGLevent::Error);
	e.add_var("error", error);
	e.add_var("description", (char*)description);
	e.trigger();
}
void gmgl_callback_framebuffer_size(GLFWwindow* window, int width, int height) {
	GMGLevent e(eGMGLevent::FramebufferSize);
	e.add_var("width", width);
	e.add_var("height", height);
	e.trigger();
}
void gmgl_callback_window_close(GLFWwindow* window) {
	GMGLevent e(eGMGLevent::WindowClose);
	e.trigger();
}
void gmgl_callback_mouse_pos(GLFWwindow* window, double xpos, double ypos) {
	GMGLevent e(eGMGLevent::MousePos);
	e.add_var("xpos", xpos);
	e.add_var("ypos", ypos);
	e.trigger();
}

#pragma endregion

#pragma endregion

#pragma region GMGL Functions

GMS_DLL double gmgl_is_active() {
	if (!__gmgl_window) return GMS_FAIL;

	return GMS_SUCCESS;
}

GMS_DLL double gmgl_load_image(const char* path) {
	double imageIndex = gmgl_new_image();
	GMGLimage* image = gmgl_get_image(imageIndex);

	stbi_set_flip_vertically_on_load(true);

	image->data = stbi_load(path, &image->width, &image->height, &image->nrChannels, 0);

	if (!image->data) {
		std::cout << "Failed to load texture" << std::endl;
		stbi_image_free(image->data);
		gmgl_delete_image(imageIndex);
		return GMS_FAIL;
	}

	return imageIndex;
}

GMS_DLL void gmgl_free_image(double imageIndex) {
	GMGLimage* image = gmgl_get_image(imageIndex);
	stbi_image_free(image->data);
	gmgl_delete_image(imageIndex);
}

GMS_DLL double gmgl_get_image_width(double image) {
	GMGLimage* _image = gmgl_get_image(image);
	return _image->width;
}

GMS_DLL double gmgl_get_image_height(double image) {
	GMGLimage* _image = gmgl_get_image(image);
	return _image->height;
}

GMS_DLL double gmgl_get_image_channel_num(double image) {
	GMGLimage* _image = gmgl_get_image(image);
	return _image->nrChannels;
}

#pragma region User Input

GMS_DLL double gmgl_key_press(double key) {
	if (glfwGetKey(__gmgl_window, key) == GLFW_PRESS) return GMS_TRUE;

	return GMS_FALSE;
}

GMS_DLL double gmgl_mouse_x() {
	return __gmgl_mouse.x;
}

GMS_DLL double gmgl_mouse_y() {
	return __gmgl_mouse.y;
}

GMS_DLL double gmgl_mouse_press(double button) {
	if (glfwGetMouseButton(__gmgl_window, button) == GLFW_PRESS) return GMS_TRUE;

	return GMS_FALSE;
}

GMS_DLL void gmgl_mouse_lock() {
	glfwSetInputMode(__gmgl_window, GLFW_CURSOR, GLFW_CURSOR_DISABLED);
}

GMS_DLL void gmgl_mouse_hide() {
	glfwSetInputMode(__gmgl_window, GLFW_CURSOR, GLFW_CURSOR_HIDDEN);
}

GMS_DLL void gmgl_mouse_normal() {
	glfwSetInputMode(__gmgl_window, GLFW_CURSOR, GLFW_CURSOR_NORMAL);
}

#pragma endregion

#pragma endregion

#pragma region GLFW Functions

GMS_DLL double glfw_init() {
	//Initialize GLFW
	if (glfwInit() == GLFW_FALSE) {
		std::cout << "GLFW initialization failed" << std::endl;
		return GMS_FAIL;
	}

	return GMS_SUCCESS;
}

GMS_DLL void glfw_update() {
	glfwSwapBuffers(__gmgl_window);
	glfwPollEvents();
}

GMS_DLL void glfw_terminate() {
	glfwTerminate();
	__gmgl_window = nullptr;
}

GMS_DLL void glfw_poll_events() {
	glfwPollEvents();
}

GMS_DLL void glfw_wait_events() {
	glfwWaitEvents();
}

GMS_DLL void glfw_wait_events_timeout(double timeout) {
	glfwWaitEventsTimeout(timeout);
}

GMS_DLL void glfw_swap_buffers() {
	glfwSwapBuffers(__gmgl_window);
}

#pragma region Window Functions

GMS_DLL double glfw_create_window(double width, double height, const char* title) {
	if (__gmgl_window) {
		std::cout << "Window has already been created" << std::endl;
		return GMS_FAIL;
	}

	__gmgl_window = glfwCreateWindow(width, height, title, nullptr, nullptr);

	if (!__gmgl_window) {
		std::cout << "Window creation failed" << std::endl;
		return GMS_FAIL;
	}

	glfwMakeContextCurrent(__gmgl_window);

	//Set callbacks
	glfwSetErrorCallback(gmgl_callback_error);
	glfwSetFramebufferSizeCallback(__gmgl_window, gmgl_callback_framebuffer_size);
	glfwSetWindowCloseCallback(__gmgl_window, gmgl_callback_window_close);
	glfwSetCursorPosCallback(__gmgl_window, gmgl_callback_mouse_pos);

	//Initialize GLEW
	if (glewInit() != GLEW_OK) {
		std::cout << "GLEW initialization failed" << std::endl;
		glfw_terminate();
		return GMS_FAIL;
	}

	return GMS_SUCCESS;
}

GMS_DLL void glfw_default_window_hints() {
	glfwDefaultWindowHints();
}

GMS_DLL void glfw_window_hint(double hint, double value) {
	glfwWindowHint(hint, value);
}

GMS_DLL void glfw_set_window_pos(double x, double y) {
	glfwSetWindowPos(__gmgl_window, x, y);
}

#pragma endregion

#pragma endregion

#pragma region GL Functions

GMS_DLL void gl_viewport(double x, double y, double width, double height) {
	glViewport(x, y, width, height);
}

GMS_DLL void gl_enable(double cap) {
	glEnable(cap);
}

GMS_DLL void gl_disable(double cap) {
	glDisable(cap);
}

GMS_DLL void gl_clear_color(double r, double g, double b, double a) {
	glClearColor(r, g, b, a);
}

GMS_DLL void gl_clear(double mask) {
	glClear(mask);
}

GMS_DLL void gl_draw_arrays(double mode, double first, double count) {
	glDrawArrays(mode, first, count);
}

GMS_DLL void gl_draw_elements(double mode, double count) {
	glDrawElements(mode, count, GL_UNSIGNED_INT, 0);
}

GMS_DLL double gl_gen_buffer() {
	unsigned int buffer;
	glGenBuffers(1, &buffer);
	return buffer;
}

GMS_DLL void gl_bind_buffer(double target, double buffer) {
	glBindBuffer(target, buffer);
}

GMS_DLL void gl_buffer_data(double target, double size, void* vertices, double usage) {
	glBufferData(target, size, vertices, usage);
}

GMS_DLL double gl_gen_vertex_array() {
	unsigned int VAO;
	glGenVertexArrays(1, &VAO);
	return VAO;
}

GMS_DLL void gl_bind_vertex_array(double varray) {
	glBindVertexArray(varray);
}

GMS_DLL void gl_vertex_attrib_pointer(double index, double size, double type, double normalized, double stride, double offset) {
	int _offset = (int)offset * sizeof(float);

	double typesize;

	switch ((int)type) {
	case GL_FLOAT:
		typesize = sizeof(float);
		break;
	case GL_UNSIGNED_INT:
		typesize = sizeof(unsigned int);
		break;
	case GL_INT:
		typesize = sizeof(int);
		break;
	default:
		type = GL_FLOAT;
		typesize = sizeof(float);
		break;
	}

	glVertexAttribPointer(index, size, type, normalized, stride * typesize, (void*)_offset);
}

GMS_DLL void gl_enable_vertex_attrib_array(double index) {
	glEnableVertexAttribArray(index);
}

GMS_DLL double gl_gen_texture() {
	GLuint texture;
	glGenTextures(1, &texture);
	return texture;
}

GMS_DLL void gl_bind_texture(double target, double texture) {
	glBindTexture(target, texture);
}

GMS_DLL void gl_active_texture(double unit) {
	glActiveTexture(unit);
}

GMS_DLL void gl_texImage2D(double target, double level, double internalformat, double border, double format, double type, double imageIndex) {
	GMGLimage* image = gmgl_get_image(imageIndex);

	glTexImage2D(target, level, internalformat, image->width, image->height, border, format, type, image->data);
}

GMS_DLL void gl_generate_mipmap(double target) {
	glGenerateMipmap(target);
}

#pragma region Shaders

GMS_DLL double gl_create_shader(double type, char* source) {
	GLuint shader = glCreateShader(type);
	glShaderSource(shader, 1, &source, nullptr);
	glCompileShader(shader);

	int success;
	char infoLog[512];
	glGetShaderiv(shader, GL_COMPILE_STATUS, &success);
	if (!success) {
		glGetShaderInfoLog(shader, 512, nullptr, infoLog);
		std::cout << "Shader compilation failed:" << infoLog << std::endl;
		return GMS_FAIL;
	}

	return shader;
}

GMS_DLL void gl_delete_shader(double shader) {
	glDeleteShader(shader);
}

GMS_DLL double gl_create_program() {
	return glCreateProgram();
}

GMS_DLL void gl_attach_shader(double program, double shader) {
	glAttachShader(program, shader);
}

GMS_DLL void gl_link_program(double program) {
	glLinkProgram(program);

	int success;
	char infoLog[512];
	glGetProgramiv(program, GL_LINK_STATUS, &success);
	if (!success) {
		glGetProgramInfoLog(program, 512, nullptr, infoLog);
		std::cout << "Program linking failed:" << infoLog << std::endl;
	}
}

GMS_DLL void gl_use_program(double program) {
	glUseProgram(program);
}

GMS_DLL double gl_get_uniform_location(double program, const char* name) {
	return glGetUniformLocation(program, name);
}

#pragma region Uniform Set Functions

GMS_DLL void gl_uniform1f(double location, double x) {
	glUniform1f(location, x);
}
GMS_DLL void gl_uniform2f(double location, double x, double y) {
	glUniform2f(location, x, y);
}
GMS_DLL void gl_uniform3f(double location, double x, double y, double z) {
	glUniform3f(location, x, y, z);
}
GMS_DLL void gl_uniform4f(double location, double x, double y, double z, double w) {
	glUniform4f(location, x, y, z, w);
}

GMS_DLL void gl_uniform1i(double location, double x) {
	glUniform1i(location, x);
}
GMS_DLL void gl_uniform2i(double location, double x, double y) {
	glUniform2i(location, x, y);
}
GMS_DLL void gl_uniform3i(double location, double x, double y, double z) {
	glUniform3i(location, x, y, z);
}
GMS_DLL void gl_uniform4i(double location, double x, double y, double z, double w) {
	glUniform4i(location, x, y, z, w);
}

GMS_DLL void gl_uniform1ui(double location, double x) {
	glUniform1ui(location, x);
}
GMS_DLL void gl_uniform2ui(double location, double x, double y) {
	glUniform2ui(location, x, y);
}
GMS_DLL void gl_uniform3ui(double location, double x, double y, double z) {
	glUniform3ui(location, x, y, z);
}
GMS_DLL void gl_uniform4ui(double location, double x, double y, double z, double w) {
	glUniform4ui(location, x, y, z, w);
}

GMS_DLL void gl_uniform1fv(double location, double size, void* value) {
	GLfloat* val = (GLfloat*)value;
	glUniform1fv(location, size, val);
}
GMS_DLL void gl_uniform2fv(double location, double size, void* value) {
	GLfloat* val = (GLfloat*)value;
	glUniform2fv(location, size, val);
}
GMS_DLL void gl_uniform3fv(double location, double size, void* value) {
	GLfloat* val = (GLfloat*)value;
	glUniform3fv(location, size, val);
}
GMS_DLL void gl_uniform4fv(double location, double size, void* value) {
	GLfloat* val = (GLfloat*)value;
	glUniform4fv(location, size, val);
}

GMS_DLL void gl_uniform1iv(double location, double size, void* value) {
	GLint* val = (GLint*)value;
	glUniform1iv(location, size, val);
}
GMS_DLL void gl_uniform2iv(double location, double size, void* value) {
	GLint* val = (GLint*)value;
	glUniform2iv(location, size, val);
}
GMS_DLL void gl_uniform3iv(double location, double size, void* value) {
	GLint* val = (GLint*)value;
	glUniform3iv(location, size, val);
}
GMS_DLL void gl_uniform4iv(double location, double size, void* value) {
	GLint* val = (GLint*)value;
	glUniform4iv(location, size, val);
}

GMS_DLL void gl_uniform1uiv(double location, double size, void* value) {
	GLuint* val = (GLuint*)value;
	glUniform1uiv(location, size, val);
}
GMS_DLL void gl_uniform2uiv(double location, double size, void* value) {
	GLuint* val = (GLuint*)value;
	glUniform2uiv(location, size, val);
}
GMS_DLL void gl_uniform3uiv(double location, double size, void* value) {
	GLuint* val = (GLuint*)value;
	glUniform3uiv(location, size, val);
}
GMS_DLL void gl_uniform4uiv(double location, double size, void* value) {
	GLuint* val = (GLuint*)value;
	glUniform4uiv(location, size, val);
}

GMS_DLL void gl_uniform_mat2fv(double location, double count, double transpose, void* value) {
	float* fval = (float*)value;
	glUniformMatrix2fv(location, count, transpose, fval);
}
GMS_DLL void gl_uniform_mat3fv(double location, double count, double transpose, void* value) {
	float* fval = (float*)value;
	glUniformMatrix3fv(location, count, transpose, fval);
}
GMS_DLL void gl_uniform_mat4fv(double location, double count, double transpose, void* value) {
	float* fval = (float*)value;
	glUniformMatrix4fv(location, count, transpose, fval);
}

GMS_DLL void gl_uniform_mat2x3fv(double location, double count, double transpose, void* value) {
	float* fval = (float*)value;
	glUniformMatrix2x3fv(location, count, transpose, fval);
}
GMS_DLL void gl_uniform_mat3x2fv(double location, double count, double transpose, void* value) {
	float* fval = (float*)value;
	glUniformMatrix3x2fv(location, count, transpose, fval);
}
GMS_DLL void gl_uniform_mat2x4fv(double location, double count, double transpose, void* value) {
	float* fval = (float*)value;
	glUniformMatrix2x4fv(location, count, transpose, fval);
}

GMS_DLL void gl_uniform_mat4x2fv(double location, double count, double transpose, void* value) {
	float* fval = (float*)value;
	glUniformMatrix4x2fv(location, count, transpose, fval);
}
GMS_DLL void gl_uniform_mat3x4fv(double location, double count, double transpose, void* value) {
	float* fval = (float*)value;
	glUniformMatrix3x4fv(location, count, transpose, fval);
}
GMS_DLL void gl_uniform_mat4x3fv(double location, double count, double transpose, void* value) {
	float* fval = (float*)value;
	glUniformMatrix4x3fv(location, count, transpose, fval);
}

#pragma endregion

#pragma endregion

#pragma region Texture Parameters

GMS_DLL void gl_tex_parameterf(double target, double pname, double param) {
	glTexParameterf(target, pname, param);
}
GMS_DLL void gl_tex_parameteri(double target, double pname, double param) {
	glTexParameteri(target, pname, param);
}
GMS_DLL void gl_texture_parameterf(double target, double pname, double param) {
	glTextureParameterf(target, pname, param);
}
GMS_DLL void gl_texture_parameteri(double target, double pname, double param) {
	glTextureParameteri(target, pname, param);
}

GMS_DLL void gl_tex_parameterfv(double target, double pname, void* param) {
	const GLfloat* _param;
	glTexParameterfv(target, pname, _param);
}
GMS_DLL void gl_tex_parameteriv(double target, double pname, void* param) {
	const GLint* _param;
	glTexParameteriv(target, pname, _param);
}
GMS_DLL void gl_texture_parameterfv(double target, double pname, void* param) {
	const GLfloat* _param;
	glTextureParameterfv(target, pname, _param);
}
GMS_DLL void gl_texture_parameteriv(double target, double pname, void* param) {
	const GLint* _param;
	glTextureParameteriv(target, pname, _param);
}

GMS_DLL void gl_tex_parameterIiv(double target, double pname, void* param) {
	const GLint* _param;
	glTexParameterIiv(target, pname, _param);
}
GMS_DLL void gl_tex_parameterIuiv(double target, double pname, void* param) {
	const GLuint* _param;
	glTexParameterIuiv(target, pname, _param);
}
GMS_DLL void gl_texture_parameterIiv(double target, double pname, void* param) {
	const GLint* _param;
	glTextureParameterIiv(target, pname, _param);
}
GMS_DLL void gl_texture_parameterIuiv(double target, double pname, void* param) {
	const GLuint* _param;
	glTextureParameterIuiv(target, pname, _param);
}

#pragma endregion

#pragma endregion
