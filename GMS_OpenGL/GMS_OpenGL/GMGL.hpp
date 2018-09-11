#pragma once
#define GMS_DLL extern "C" __declspec(dllexport)

#define GMS_SUCCESS 1
#define GMS_FAIL -1
#define GMS_NOONE -4

#define GLEW_STATIC
#include <GL/glew.h>
#include <GLFW/glfw3.h>
#include <iostream>
#include <vector>
//#include "GMGL_VertexBuffer.h"

struct GMGLvertexBuffer {
	GLuint vbo;
	std::vector<float> vertices;
};

struct GMGLvertexArray {
	GLuint vao;
};


enum eGMGL_VAO_TYPE {
	REAL, VEC2, VEC3, VEC4
};
struct GMGLvertexArraySetup {
	bool is_setting_up;
	GMGLvertexArray* varray;
	GLsizei stride;
	GLuint attribCount;
	std::vector<eGMGL_VAO_TYPE> attribTypes;
	std::vector<GLsizei> attribStride;

	

	const std::string TYPE_REAL = "real";
	const std::string TYPE_VEC2 = "vec2";
	const std::string TYPE_VEC3 = "vec3";

	void reset() {
		is_setting_up = false;
		stride = 0;
		attribCount = 0;
	}
};

//Forward declarations
GMS_DLL void gmgl_free();

//Global variables
GLFWwindow* _gmgl_window = nullptr;
std::vector<GLuint*> _gmgl_objects;
std::vector<GLuint> _gmgl_objects_open_spots;
std::vector<GMGLvertexBuffer*> _gmgl_vertex_buffers;
std::vector<GLuint> _gmgl_vertex_buffers_open_spots;
std::vector<GMGLvertexArray*> _gmgl_vertex_arrays;
std::vector<GLuint> _gmgl_vertex_arrays_open_spots;
GMGLvertexArraySetup _gmgl_vao_setup;


//Internal Helper functions
void gmgl_set_window(GLFWwindow* window) {
	_gmgl_window = window;
}

GLFWwindow* gmgl_get_window() {
	return _gmgl_window;
}

void gmgl_callback_framebuffer_size(GLFWwindow* window, int width, int height) {
	glViewport(0, 0, width, height);
}

void gmgl_callback_window_close(GLFWwindow* window) {
	if (glfwWindowShouldClose(window)) gmgl_free();
}

double gmgl_new_object() {
	int index;
	GLuint* object = new GLuint;

	if (!_gmgl_objects_open_spots.empty()) {
		index = _gmgl_objects_open_spots.back();
		_gmgl_objects_open_spots.pop_back();
		_gmgl_objects[index] = object;
	}
	else {
		index = _gmgl_objects.size();
		_gmgl_objects.push_back(object);
	}

	return index;
}

GLuint* gmgl_get_object(double index) {
	return _gmgl_objects[index];
}

void gmgl_delete_object(double index) {
	if (_gmgl_objects.size() > index && _gmgl_objects[index] != nullptr) {
		delete _gmgl_objects[index];
		_gmgl_objects[index] = nullptr;
		_gmgl_objects_open_spots.push_back(index);
	}
}

double gmgl_new_vertex_buffer() {
	int index;
	GMGLvertexBuffer* vbuff = new GMGLvertexBuffer;
	if (!_gmgl_vertex_buffers_open_spots.empty()) {
		index = _gmgl_vertex_buffers_open_spots.back();
		_gmgl_vertex_buffers_open_spots.pop_back();
		_gmgl_vertex_buffers[index] = vbuff;
	}
	else {
		index = _gmgl_vertex_buffers.size();
		_gmgl_vertex_buffers.push_back(vbuff);
	}

	return index;
}

GMGLvertexBuffer* gmgl_get_vertex_buffer(double index) {
	return _gmgl_vertex_buffers[index];
}

void gmgl_delete_vertex_buffer(double index) {
	if (_gmgl_vertex_buffers.size() > index && _gmgl_vertex_buffers[index] != nullptr) {
		delete _gmgl_vertex_buffers[index];
		_gmgl_vertex_buffers[index] = nullptr;
		_gmgl_vertex_buffers_open_spots.push_back(index);
	}
}

double gmgl_new_vertex_array() {
	int index;
	GMGLvertexArray* vbuff = new GMGLvertexArray;
	if (!_gmgl_vertex_arrays_open_spots.empty()) {
		index = _gmgl_vertex_arrays_open_spots.back();
		_gmgl_vertex_arrays.pop_back();
		_gmgl_vertex_arrays[index] = vbuff;
	}
	else {
		index = _gmgl_vertex_arrays.size();
		_gmgl_vertex_arrays.push_back(vbuff);
	}

	return index;
}

GMGLvertexArray* gmgl_get_vertex_array(double index) {
	return _gmgl_vertex_arrays[index];
}

void gmgl_delete_vertex_array(double index) {
	if (_gmgl_vertex_arrays.size() > index && _gmgl_vertex_arrays[index] != nullptr) {
		delete _gmgl_vertex_arrays[index];
		_gmgl_vertex_arrays[index] = nullptr;
		_gmgl_vertex_arrays_open_spots.push_back(index);
	}
}