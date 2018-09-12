/*
#include "GMGL.h"

GMGL* gmgl = nullptr;

GMS_DLL double gmgl_is_active() {
if (!gmgl) return GMS_FAIL;
if (gmgl && !gmgl->isInit()) {
gmgl->free();
gmgl = nullptr;
return GMS_FAIL;
}

return GMS_SUCCESS;
}

GMS_DLL double gmgl_init() {
if (gmgl) return GMS_FAIL;

gmgl = new GMGL;
if (!gmgl->init()) {

delete gmgl;
gmgl = nullptr;

return GMS_FAIL;
}

return GMS_SUCCESS;
}

GMS_DLL void gmgl_update() {
gmgl->update();
}

GMS_DLL void gmgl_free() {
gmgl->free();
gmgl = nullptr;
}

GMS_DLL void gmgl_setGLversion(double major, double minor) {
gmgl->setGLversion(major, minor);
}

GMS_DLL double gmgl_createWindow(double width, double height, const char* title) {
return gmgl->createWindow(width, height, title);
}

GMS_DLL void gmgl_clearColor(double r, double g, double b, double a) {
gmgl->clearColor(r, g, b, a);
}
*/

#define GLEW_STATIC
#include <GL/glew.h>
#include <GLFW/glfw3.h>
#include <vector>
#include <iostream>
#include "GMS_Extension.hpp"

#pragma region Internal Stuff
//Forward Declarations
GMS_DLL void gmgl_terminate();
//Data structures
struct GMGLobject {
	GLuint object;
};

//Global variables
std::vector<GMGLobject*> __gmgl_objects;
std::vector<GLuint> __gmgl_object_slots;
GLFWwindow* __gmgl_window = nullptr;

//Helper functions
double gmgl_new_object() {
	double index;
	GMGLobject* object = new GMGLobject;

	if (!__gmgl_object_slots.empty()) {
		index = __gmgl_object_slots.back();
		__gmgl_object_slots.pop_back();
		__gmgl_objects[index] = object;
	}
	else {
		index = __gmgl_objects.size();
		__gmgl_objects.push_back(object);
	}

	return index;
}

GMGLobject* gmgl_get_object(double id) {
	return __gmgl_objects[id];
}

void gmgl_delete_object(double id) {
	if (__gmgl_objects.size() > id && __gmgl_objects[id] != nullptr) {
		delete __gmgl_objects[id];
		__gmgl_objects[id] = nullptr;
		__gmgl_object_slots.push_back(id);
	}
}

//Callbacks
void gmgl_callback_framebuffer_size(GLFWwindow* window, int width, int height) {
	glViewport(0, 0, width, height);
}

void gmgl_callback_window_close(GLFWwindow* window) {
	if (glfwWindowShouldClose(window)) gmgl_terminate();
}
#pragma endregion

GMS_DLL double gmgl_is_active() {
	if (!__gmgl_window) return GMS_FAIL;

	return GMS_SUCCESS;
}

GMS_DLL double gmgl_init() {
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

GMS_DLL void gmgl_default_window_hints() {
	glfwDefaultWindowHints();
}

GMS_DLL void gmgl_window_hint(double hint, double value) {
	glfwWindowHint(hint, value);
}

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

	if (glewInit() != GLEW_OK) {
		std::cout << "GLEW initialization failed" << std::endl;
		gmgl_terminate();
		return GMS_FAIL;
	}

	return GMS_SUCCESS;
}

GMS_DLL void gmgl_clear_color(double r, double g, double b, double a) {
	glClearColor(r, g, b, a);
	glClear(GL_COLOR_BUFFER_BIT);
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
	glGetProgramiv(program, GL_COMPILE_STATUS, &success);
	if (!success) {
		glGetProgramInfoLog(program, 512, nullptr, infoLog);
		std::cout << "Program linking failed:" << infoLog << std::endl;
	}
}

GMS_DLL void gmgl_use_program(double program) {
	glUseProgram(program);
}

GMS_DLL void gmgl_draw_arrays(double mode, double first, double count) {
	glDrawArrays(mode, first, count);
}

#pragma endregion

#pragma region VBO

GMS_DLL double gmgl_gen_buffer() {
	unsigned int VBO;
	glGenBuffers(1, &VBO);
	return VBO;
}

GMS_DLL void gmgl_bind_buffer(double target, double buffer) {
	glBindBuffer(target, buffer);
}

GMS_DLL void gmgl_buffer_data(double target, double size, void* vertices, double usage) {
	glBufferData(target, size, vertices, usage);
}

#pragma endregion

#pragma region VAO

GMS_DLL double gmgl_gen_vertex_array() {
	unsigned int VAO;
	glGenVertexArrays(1, &VAO);
	return VAO;
}

GMS_DLL void gmgl_bind_vertex_array(double varray) {
	glBindVertexArray(varray);
}

GMS_DLL void gmgl_vertex_attrib_pointer(double index, double size, double normalized, double stride, double offset) {
	int _offset = (int)offset;
	glVertexAttribPointer(index, size, GL_FLOAT, normalized, stride * sizeof(float), (void*)_offset);
}

GMS_DLL void gmgl_enable_vertex_attrib_array(double index) {
	glEnableVertexAttribArray(index);
}

#pragma endregion