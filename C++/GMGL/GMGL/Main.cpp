#define GLEW_STATIC
#include <GL/glew.h>
#include <GLFW/glfw3.h>

#define STB_IMAGE_IMPLEMENTATION
#include "stb_image.h"

#include <glm/glm.hpp>
#include <glm/gtc/matrix_transform.hpp>
#include <glm/gtc/type_ptr.hpp>

#include <vector>
#include <iostream>
#include "GMS_Extension.hpp"

#pragma region Internal Stuff

//Forward Declarations
GMS_DLL void gmgl_terminate();

//Data structures
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

//Global variables
std::vector<GMGLimage*> __gmgl_images;
std::vector<GLuint> __gmgl_image_slots;
GMGLmouse __gmgl_mouse;

GLFWwindow* __gmgl_window = nullptr;


//Helper functions
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

//Callbacks
void gmgl_callback_framebuffer_size(GLFWwindow* window, int width, int height) {
	glViewport(0, 0, width, height);
}

void gmgl_callback_window_close(GLFWwindow* window) {
	if (glfwWindowShouldClose(window)) gmgl_terminate();
}

void gmgl_callback_mouse_pos(GLFWwindow* window, double xpos, double ypos) {
	__gmgl_mouse.x = xpos;
	__gmgl_mouse.y = ypos;
}

#pragma endregion

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

GMS_DLL double gmgl_is_active() {
	if (!__gmgl_window) return GMS_FAIL;

	return GMS_SUCCESS;
}

GMS_DLL double gmgl_init() {
	//Initialize key states
	/*
	for (int i = 0; i < __gmgl_keystates.keycount; ++i) {
		__gmgl_keystates.keypress[i] = GMS_FALSE;
		__gmgl_keystates.keydown[i] = GMS_FALSE;
		__gmgl_keystates.keyrelease[i] = GMS_FALSE;
	}
	*/

	//Initialize GLFW
	if (glfwInit() == GLFW_FALSE) {
		std::cout << "GLFW initialization failed" << std::endl;
		return GMS_FAIL;
	}

	return GMS_SUCCESS;
}

GMS_DLL void gmgl_update() {
	glfwSwapBuffers(__gmgl_window);
	glfwPollEvents();
}

GMS_DLL void gmgl_terminate() {
	glfwTerminate();
	__gmgl_window = nullptr;
}

GMS_DLL void gmgl_enable(double cap) {
	glEnable(cap);
}

GMS_DLL void gmgl_disable(double cap) {
	glDisable(cap);
}

GMS_DLL void gmgl_poll_events() {
	glfwPollEvents();
}

GMS_DLL void gmgl_wait_events() {
	glfwWaitEvents();
}

GMS_DLL void gmgl_wait_events_timeout(double timeout) {
	glfwWaitEventsTimeout(timeout);
}

#pragma region Window Functions

GMS_DLL double gmgl_create_window(double width, double height, const char* title) {
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
	glfwSetFramebufferSizeCallback(__gmgl_window, gmgl_callback_framebuffer_size);
	glfwSetWindowCloseCallback(__gmgl_window, gmgl_callback_window_close);
	glfwSetCursorPosCallback(__gmgl_window, gmgl_callback_mouse_pos);

	if (glewInit() != GLEW_OK) {
		std::cout << "GLEW initialization failed" << std::endl;
		gmgl_terminate();
		return GMS_FAIL;
	}

	return GMS_SUCCESS;
}

GMS_DLL void gmgl_default_window_hints() {
	glfwDefaultWindowHints();
}

GMS_DLL void gmgl_window_hint(double hint, double value) {
	glfwWindowHint(hint, value);
}

GMS_DLL void gmgl_set_window_pos(double x, double y) {
	glfwSetWindowPos(__gmgl_window, x, y);
}
#pragma endregion

GMS_DLL void gmgl_clear_color(double r, double g, double b, double a) {
	glClearColor(r, g, b, a);
}

GMS_DLL void gmgl_clear(double mask) {
	glClear(mask);
}

GMS_DLL void gmgl_swap_buffers() {
	glfwSwapBuffers(__gmgl_window);
}

GMS_DLL void gmgl_draw_arrays(double mode, double first, double count) {
	glDrawArrays(mode, first, count);
}

GMS_DLL void gmgl_draw_elements(double mode, double count) {
	glDrawElements(mode, count, GL_UNSIGNED_INT, 0);
}

#pragma region Shaders

GMS_DLL double gmgl_create_shader(double type, char* source) {
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

GMS_DLL void gmgl_delete_shader(double shader) {
	glDeleteShader(shader);
}

GMS_DLL double gmgl_create_program() {
	return glCreateProgram();
}

GMS_DLL void gmgl_attach_shader(double program, double shader) {
	glAttachShader(program, shader);
}

GMS_DLL void gmgl_link_program(double program) {
	glLinkProgram(program);

	int success;
	char infoLog[512];
	glGetProgramiv(program, GL_LINK_STATUS, &success);
	if (!success) {
		glGetProgramInfoLog(program, 512, nullptr, infoLog);
		std::cout << "Program linking failed:" << infoLog << std::endl;
	}
}

GMS_DLL void gmgl_use_program(double program) {
	glUseProgram(program);
}

GMS_DLL double gmgl_get_uniform_location(double program, const char* name) {
	return glGetUniformLocation(program, name);
}

//TODO: Finish creating other uniform wrappers
GMS_DLL void gmgl_uniform1f(double location, double x) {
	glUniform1f(location, x);
}
GMS_DLL void gmgl_uniform2f(double location, double x, double y) {
	glUniform2f(location, x, y);
}
GMS_DLL void gmgl_uniform3f(double location, double x, double y, double z) {
	glUniform3f(location, x, y, z);
}
GMS_DLL void gmgl_uniform4f(double location, double x, double y, double z, double w) {
	glUniform4f(location, x, y, z, w);
}

GMS_DLL void gmgl_uniform1i(double location, double x) {
	glUniform1i(location, x);
}
GMS_DLL void gmgl_uniform2i(double location, double x, double y) {
	glUniform2i(location, x, y);
}
GMS_DLL void gmgl_uniform3i(double location, double x, double y, double z) {
	glUniform3i(location, x, y, z);
}
GMS_DLL void gmgl_uniform4i(double location, double x, double y, double z, double w) {
	glUniform4i(location, x, y, z, w);
}

GMS_DLL void gmgl_uniform1ui(double location, double x) {
	glUniform1ui(location, x);
}
GMS_DLL void gmgl_uniform2ui(double location, double x, double y) {
	glUniform2ui(location, x, y);
}
GMS_DLL void gmgl_uniform3ui(double location, double x, double y, double z) {
	glUniform3ui(location, x, y, z);
}
GMS_DLL void gmgl_uniform4ui(double location, double x, double y, double z, double w) {
	glUniform4ui(location, x, y, z, w);
}

GMS_DLL void gmgl_uniform1fv(double location, double size, void* value) {
	GLfloat* val = (GLfloat*)value;
	glUniform1fv(location, size, val);
}
GMS_DLL void gmgl_uniform2fv(double location, double size, void* value) {
	GLfloat* val = (GLfloat*)value;
	glUniform2fv(location, size, val);
}
GMS_DLL void gmgl_uniform3fv(double location, double size, void* value) {
	GLfloat* val = (GLfloat*)value;
	glUniform3fv(location, size, val);
}
GMS_DLL void gmgl_uniform4fv(double location, double size, void* value) {
	GLfloat* val = (GLfloat*)value;
	glUniform4fv(location, size, val);
}

GMS_DLL void gmgl_uniform1iv(double location, double size, void* value) {
	GLint* val = (GLint*)value;
	glUniform1iv(location, size, val);
}
GMS_DLL void gmgl_uniform2iv(double location, double size, void* value) {
	GLint* val = (GLint*)value;
	glUniform2iv(location, size, val);
}
GMS_DLL void gmgl_uniform3iv(double location, double size, void* value) {
	GLint* val = (GLint*)value;
	glUniform3iv(location, size, val);
}
GMS_DLL void gmgl_uniform4iv(double location, double size, void* value) {
	GLint* val = (GLint*)value;
	glUniform4iv(location, size, val);
}

GMS_DLL void gmgl_uniform1uiv(double location, double size, void* value) {
	GLuint* val = (GLuint*)value;
	glUniform1uiv(location, size, val);
}
GMS_DLL void gmgl_uniform2uiv(double location, double size, void* value) {
	GLuint* val = (GLuint*)value;
	glUniform2uiv(location, size, val);
}
GMS_DLL void gmgl_uniform3uiv(double location, double size, void* value) {
	GLuint* val = (GLuint*)value;
	glUniform3uiv(location, size, val);
}
GMS_DLL void gmgl_uniform4uiv(double location, double size, void* value) {
	GLuint* val = (GLuint*)value;
	glUniform4uiv(location, size, val);
}

GMS_DLL void gmgl_uniform_mat2fv(double location, double count, double transpose, void* value) {
	float* fval = (float*)value;
	glUniformMatrix2fv(location, count, transpose, fval);
}
GMS_DLL void gmgl_uniform_mat3fv(double location, double count, double transpose, void* value) {
	float* fval = (float*)value;
	glUniformMatrix3fv(location, count, transpose, fval);
}
GMS_DLL void gmgl_uniform_mat4fv(double location, double count, double transpose, void* value) {
	float* fval = (float*)value;
	glUniformMatrix4fv(location, count, transpose, fval);
}

GMS_DLL void gmgl_uniform_mat2x3fv(double location, double count, double transpose, void* value) {
	float* fval = (float*)value;
	glUniformMatrix2x3fv(location, count, transpose, fval);
}
GMS_DLL void gmgl_uniform_mat3x2fv(double location, double count, double transpose, void* value) {
	float* fval = (float*)value;
	glUniformMatrix3x2fv(location, count, transpose, fval);
}
GMS_DLL void gmgl_uniform_mat2x4fv(double location, double count, double transpose, void* value) {
	float* fval = (float*)value;
	glUniformMatrix2x4fv(location, count, transpose, fval);
}

GMS_DLL void gmgl_uniform_mat4x2fv(double location, double count, double transpose, void* value) {
	float* fval = (float*)value;
	glUniformMatrix4x2fv(location, count, transpose, fval);
}
GMS_DLL void gmgl_uniform_mat3x4fv(double location, double count, double transpose, void* value) {
	float* fval = (float*)value;
	glUniformMatrix3x4fv(location, count, transpose, fval);
}
GMS_DLL void gmgl_uniform_mat4x3fv(double location, double count, double transpose, void* value) {
	float* fval = (float*)value;
	glUniformMatrix4x3fv(location, count, transpose, fval);
}

#pragma endregion

GMS_DLL double gmgl_gen_buffer() {
	unsigned int buffer;
	glGenBuffers(1, &buffer);
	return buffer;
}

GMS_DLL void gmgl_bind_buffer(double target, double buffer) {
	glBindBuffer(target, buffer);
}

GMS_DLL void gmgl_buffer_data(double target, double size, void* vertices, double usage) {
	glBufferData(target, size, vertices, usage);
}

GMS_DLL double gmgl_gen_vertex_array() {
	unsigned int VAO;
	glGenVertexArrays(1, &VAO);
	return VAO;
}

GMS_DLL void gmgl_bind_vertex_array(double varray) {
	glBindVertexArray(varray);
}

GMS_DLL void gmgl_vertex_attrib_pointer(double index, double size, double normalized, double stride, double offset) {
	int _offset = (int)offset * sizeof(float);
	glVertexAttribPointer(index, size, GL_FLOAT, normalized, stride * sizeof(float), (void*)_offset);
}

GMS_DLL void gmgl_enable_vertex_attrib_array(double index) {
	glEnableVertexAttribArray(index);
}

GMS_DLL double gmgl_gen_texture() {
	GLuint texture;
	glGenTextures(1, &texture);
	return texture;
}

GMS_DLL void gmgl_bind_texture(double target, double texture) {
	glBindTexture(target, texture);
}

GMS_DLL void gmgl_active_texture(double unit) {
	glActiveTexture(unit);
}

//TODO: Finish creating other tex_parameter wrappers
GMS_DLL void gmgl_tex_parameteri(double target, double pname, double param) {
	glTexParameteri(target, pname, param);
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
	/*else {
		std::cout << "Image Properties:\nSize: " << image->width << "," << image->height << "\nChannels: " << image->nrChannels << std::endl;
	}*/

	return imageIndex;
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

GMS_DLL void gmgl_texImage2D(double target, double level, double internalformat, double border, double format, double imageIndex) {
	GMGLimage* image = gmgl_get_image(imageIndex);

	glTexImage2D(target, level, internalformat, image->width, image->height, border, format, GL_UNSIGNED_BYTE, image->data);
}

GMS_DLL void gmgl_generate_mipmap(double target) {
	glGenerateMipmap(target);
}

GMS_DLL void gmgl_free_image(double imageIndex) {
	GMGLimage* image = gmgl_get_image(imageIndex);
	stbi_image_free(image->data);
	gmgl_delete_image(imageIndex);
}

