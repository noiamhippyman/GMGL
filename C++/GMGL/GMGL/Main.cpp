#include <vector>
#include <iostream>
#include <string>

#define GLEW_STATIC
#include <GL/glew.h>
#include <GLFW/glfw3.h>

#define STB_IMAGE_IMPLEMENTATION
#include "stb_image.h"

//#include <glm/glm.hpp>
//#include <glm/gtc/matrix_transform.hpp>
//#include <glm/gtc/type_ptr.hpp>

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

enum eGMGLevent {
	Error,
	WindowPos,
	WindowResize,
	WindowClose,
	WindowRefresh,
	WindowFocus,
	WindowIconify,
	FramebufferSize,
	Key,
	Mouse,
	Joystick,
	CursorPos,
	CursorEnter,
	Scroll,
	Drop
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
std::vector<unsigned int> __gmgl_image_slots;

std::vector<unsigned int*> __gmgl_gl_refs;
std::vector<unsigned int> __gmgl_gl_ref_slots;

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

double gmgl_new_gl_ref() {
	double index;
	unsigned int* object = new unsigned int;

	if (!__gmgl_gl_ref_slots.empty()) {
		index = __gmgl_gl_ref_slots.back();
		__gmgl_gl_ref_slots.pop_back();
		__gmgl_gl_refs[index] = object;
	}
	else {
		index = __gmgl_gl_refs.size();
		__gmgl_gl_refs.push_back(object);
	}

	return index;
}
double gmgl_new_gl_ref(unsigned int val) {
	double index;
	unsigned int* object = new unsigned int(val);

	if (!__gmgl_gl_ref_slots.empty()) {
		index = __gmgl_gl_ref_slots.back();
		__gmgl_gl_ref_slots.pop_back();
		__gmgl_gl_refs[index] = object;
	}
	else {
		index = __gmgl_gl_refs.size();
		__gmgl_gl_refs.push_back(object);
	}

	return index;
}
unsigned int* gmgl_get_gl_ref(double id) {
	return __gmgl_gl_refs[id];
}
void gmgl_delete_gl_ref(double id) {
	if (__gmgl_gl_refs.size() > id && __gmgl_gl_refs[id] != nullptr) {
		delete __gmgl_gl_refs[id];
		__gmgl_gl_refs[id] = nullptr;
		__gmgl_gl_ref_slots.push_back(id);
	}
}

#pragma region Callbacks

void gmgl_callback_error(int error, const char* description) {
	GMGLevent e(eGMGLevent::Error);
	e.add_var("error", error);
	e.add_var("description", (char*)description);
	e.trigger();
}

# pragma region Window Callbacks

void gmgl_callback_window_pos(GLFWwindow* window, int xpos, int ypos) {
	GMGLevent e(eGMGLevent::WindowPos);
	e.add_var("xpos", xpos);
	e.add_var("ypos", ypos);
	e.trigger();
}
void gmgl_callback_window_size(GLFWwindow* window, int width, int height) {
	GMGLevent e(eGMGLevent::WindowResize);
	e.add_var("width", width);
	e.add_var("height", height);
	e.trigger();
}
void gmgl_callback_window_close(GLFWwindow* window) {
	GMGLevent e(eGMGLevent::WindowClose);
	e.trigger();
}
void gmgl_callback_window_refresh(GLFWwindow* window) {
	GMGLevent e(eGMGLevent::WindowRefresh);
	e.trigger();
}
void gmgl_callback_window_focus(GLFWwindow* window, int focused) {
	GMGLevent e(eGMGLevent::WindowFocus);
	e.add_var("focused", focused);
	e.trigger();
}
void gmgl_callback_window_iconify(GLFWwindow* window, int iconified) {
	GMGLevent e(eGMGLevent::WindowIconify);
	e.add_var("iconified", iconified);
	e.trigger();
}
void gmgl_callback_framebuffer_size(GLFWwindow* window, int width, int height) {
	GMGLevent e(eGMGLevent::FramebufferSize);
	e.add_var("width", width);
	e.add_var("height", height);
	e.trigger();
}

#pragma endregion

#pragma region Input Callbacks

void gmgl_callback_key(GLFWwindow* window, int key, int scancode, int action, int mods) {
	GMGLevent e(eGMGLevent::Key);
	e.add_var("key", key);
	e.add_var("scancode", scancode);
	e.add_var("action", action);
	e.add_var("mods", mods);
	e.trigger();
}
void gmgl_callback_mouse(GLFWwindow* window, int button, int action, int mods) {
	GMGLevent e(eGMGLevent::Mouse);
	e.add_var("button", button);
	e.add_var("action", action);
	e.add_var("mods", mods);
	e.trigger();
}
void gmgl_callback_joystick(int joy, int event) {
	GMGLevent e(eGMGLevent::Joystick);
	e.add_var("joy", joy);
	e.add_var("action", event);
	e.trigger();
}
void gmgl_callback_cursor_pos(GLFWwindow* window, double xpos, double ypos) {
	GMGLevent e(eGMGLevent::CursorPos);
	e.add_var("xpos", xpos);
	e.add_var("ypos", ypos);
	e.trigger();
}
void gmgl_callback_cursor_enter(GLFWwindow* window, int entered) {
	GMGLevent e(eGMGLevent::CursorEnter);
	e.add_var("entered", entered);
	e.trigger();
}
void gmgl_callback_scroll(GLFWwindow* window, double xoffset, double yoffset) {
	GMGLevent e(eGMGLevent::Scroll);
	e.add_var("xoffset", xoffset);
	e.add_var("yoffset", yoffset);
	e.trigger();
}
void gmgl_callback_drop(GLFWwindow* window, int count, const char** paths) {
	GMGLevent e(eGMGLevent::Drop);
	e.add_var("count", count);
	for (int i = 0; i < count; ++i) {
		std::string id = "paths[" + std::to_string(i) + "]";
		e.add_var((char*)id.c_str(), (char*)paths[i]);
	}
	e.trigger();
}

#pragma endregion

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
		std::cout << "Failed to load texture::" << path << std::endl;
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

	// Set callbacks
	glfwSetErrorCallback(gmgl_callback_error);

	glfwSetWindowPosCallback(__gmgl_window, gmgl_callback_window_pos);
	glfwSetWindowSizeCallback(__gmgl_window, gmgl_callback_window_size);
	glfwSetWindowCloseCallback(__gmgl_window, gmgl_callback_window_close);
	glfwSetWindowRefreshCallback(__gmgl_window, gmgl_callback_window_refresh);
	glfwSetWindowFocusCallback(__gmgl_window, gmgl_callback_window_focus);
	glfwSetWindowIconifyCallback(__gmgl_window, gmgl_callback_window_iconify);
	glfwSetFramebufferSizeCallback(__gmgl_window, gmgl_callback_framebuffer_size);

	glfwSetKeyCallback(__gmgl_window, gmgl_callback_key);
	glfwSetMouseButtonCallback(__gmgl_window, gmgl_callback_mouse);
	glfwSetJoystickCallback(gmgl_callback_joystick);
	glfwSetCursorPosCallback(__gmgl_window, gmgl_callback_cursor_pos);
	glfwSetCursorEnterCallback(__gmgl_window, gmgl_callback_cursor_enter);
	glfwSetScrollCallback(__gmgl_window, gmgl_callback_scroll);

	glfwSetDropCallback(__gmgl_window, gmgl_callback_drop);

	// Initialize GLEW
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

GMS_DLL void glfw_set_window_title(char* title) {
	glfwSetWindowTitle(__gmgl_window, title);
}

GMS_DLL void glfw_set_window_icon(const char* path) {
	GLFWimage image[1];

	stbi_set_flip_vertically_on_load(false);

	image[0].pixels = stbi_load(path, &image[0].width, &image[0].height, 0, 4);

	if (!image[0].pixels) {
		std::cout << "Failed to load texture::" << path << std::endl;
		stbi_image_free(image[0].pixels);
		return;
	}

	glfwSetWindowIcon(__gmgl_window, 1, image);

	stbi_image_free(image[0].pixels);
}

GMS_DLL double glfw_get_window_x() {
	int xpos;
	glfwGetWindowPos(__gmgl_window, &xpos, nullptr);
	return xpos;
}

GMS_DLL double glfw_get_window_y() {
	int ypos;
	glfwGetWindowPos(__gmgl_window, nullptr, &ypos);
	return ypos;
}

GMS_DLL void glfw_set_window_pos(double x, double y) {
	glfwSetWindowPos(__gmgl_window, x, y);
}

GMS_DLL double glfw_get_window_width() {
	int width;
	glfwGetWindowSize(__gmgl_window, &width, nullptr);
	return width;
}

GMS_DLL double glfw_get_window_height() {
	int height;
	glfwGetWindowSize(__gmgl_window, nullptr, &height);
	return height;
}

GMS_DLL void glfw_set_window_size_limits(double minwidth, double minheight, double maxwidth, double maxheight) {
	glfwSetWindowSizeLimits(__gmgl_window, minwidth, minheight, maxwidth, maxheight);
}

GMS_DLL void glfw_set_window_aspect_ratio(double numer, double denom) {
	glfwSetWindowAspectRatio(__gmgl_window, numer, denom);
}

GMS_DLL void glfw_set_window_size(double width, double height) {
	glfwSetWindowSize(__gmgl_window, width, height);
}

GMS_DLL double glfw_get_framebuffer_width() {
	int width;
	glfwGetFramebufferSize(__gmgl_window, &width, nullptr);
	return width;
}

GMS_DLL double glfw_get_framebuffer_height() {
	int height;
	glfwGetFramebufferSize(__gmgl_window, nullptr, &height);
	return height;
}

GMS_DLL void glfw_iconify_window() {
	glfwIconifyWindow(__gmgl_window);
}

GMS_DLL void glfw_restore_window() {
	glfwRestoreWindow(__gmgl_window);
}

GMS_DLL void glfw_maximize_window() {
	glfwMaximizeWindow(__gmgl_window);
}

GMS_DLL void glfw_show_window() {
	glfwShowWindow(__gmgl_window);
}

GMS_DLL void glfw_hide_window() {
	glfwHideWindow(__gmgl_window);
}

GMS_DLL void glfw_focus_window() {
	glfwFocusWindow(__gmgl_window);
}

GMS_DLL double glfw_get_window_attrib(double attrib) {
	return glfwGetWindowAttrib(__gmgl_window, attrib);
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

GMS_DLL void glfw_post_empty_event() {
	glfwPostEmptyEvent();
}

GMS_DLL void glfw_swap_buffers() {
	glfwSwapBuffers(__gmgl_window);
}

#pragma endregion

#pragma region Input Functions

GMS_DLL void glfw_set_input_mode(double mode, double value) {
	glfwSetInputMode(__gmgl_window, mode, value);
}

GMS_DLL double glfw_get_input_mode(double mode) {
	return glfwGetInputMode(__gmgl_window, mode);
}

GMS_DLL const char* glfw_get_key_name(double key, double scancode) {
	return glfwGetKeyName(key, scancode);
}

GMS_DLL double glfw_get_key(double key) {
	return glfwGetKey(__gmgl_window, key);
}

GMS_DLL double glfw_get_mouse_button(double button) {
	return glfwGetMouseButton(__gmgl_window, button);
}

GMS_DLL double glfw_get_mouse_x() {
	double xpos;
	glfwGetCursorPos(__gmgl_window, &xpos, nullptr);
	return xpos;
}

GMS_DLL double glfw_get_mouse_y() {
	double ypos;
	glfwGetCursorPos(__gmgl_window, nullptr, &ypos);
	return ypos;
}

GMS_DLL void glfw_set_mouse_pos(double x, double y) {
	glfwSetCursorPos(__gmgl_window, x, y);
}

GMS_DLL void glfw_set_clipboard_string(const char* string) {
	glfwSetClipboardString(__gmgl_window, string);
}

GMS_DLL const char* glfw_get_clipboard_string() {
	return glfwGetClipboardString(__gmgl_window);
}

GMS_DLL double glfw_get_time() {
	return glfwGetTime();
}

GMS_DLL void glfw_set_time(double time) {
	glfwSetTime(time);
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

GMS_DLL void gl_depth_mask(double flag) {
	glDepthMask(flag);
}

GMS_DLL void gl_depth_func(double func) {
	glDepthFunc(func);
}

GMS_DLL void gl_stencil_mask(double mask) {
	glStencilMask(mask);
}

GMS_DLL void gl_stencil_func(double func, double ref, double mask) {
	glStencilFunc(func, ref, mask);
}

GMS_DLL void gl_stencil_op(double fail, double zfail, double zpass) {
	glStencilOp(fail, zfail, zpass);
}

GMS_DLL void gl_blend_func(double sfactor, double dfactor) {
	glBlendFunc(sfactor, dfactor);
}

GMS_DLL void gl_blend_func_separate(double sfactorRGB, double dfactorRGB, double sfactorAlpha, double dfactorAlpha) {
	glBlendFuncSeparate(sfactorRGB, dfactorRGB, sfactorAlpha, dfactorAlpha);
}

GMS_DLL void gl_blend_equation(double mode) {
	glBlendEquation(mode);
}

GMS_DLL void gl_cull_face(double mode) {
	glCullFace(mode);
}

GMS_DLL void gl_front_face(double mode) {
	glFrontFace(mode);
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
	double bufferIndex = gmgl_new_gl_ref();
	glGenBuffers(1, gmgl_get_gl_ref(bufferIndex));
	return bufferIndex;
}

GMS_DLL void gl_bind_buffer(double target, double bufferIndex) {
	glBindBuffer(target, *gmgl_get_gl_ref(bufferIndex));
}

GMS_DLL void gl_delete_buffer(double bufferIndex) {
	glDeleteBuffers(1, gmgl_get_gl_ref(bufferIndex));
	gmgl_delete_gl_ref(bufferIndex);
}

GMS_DLL void gl_buffer_data(double target, double size, void* vertices, double usage) {
	glBufferData(target, size, vertices, usage);
}

GMS_DLL double gl_gen_vertex_array() {
	double varrayIndex = gmgl_new_gl_ref();
	glGenVertexArrays(1, gmgl_get_gl_ref(varrayIndex));
	return varrayIndex;
}

GMS_DLL void gl_bind_vertex_array(double varrayIndex) {
	glBindVertexArray(*gmgl_get_gl_ref(varrayIndex));
}

GMS_DLL void gl_delete_vertex_array(double varrayIndex) {
	glDeleteVertexArrays(1, gmgl_get_gl_ref(varrayIndex));
	gmgl_delete_gl_ref(varrayIndex);
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
	double textureIndex = gmgl_new_gl_ref();
	glGenTextures(1, gmgl_get_gl_ref(textureIndex));
	return textureIndex;
}

GMS_DLL void gl_bind_texture(double target, double textureIndex) {
	glBindTexture(target, *gmgl_get_gl_ref(textureIndex));
}

GMS_DLL void gl_delete_texture(double textureIndex) {
	glDeleteTextures(1, gmgl_get_gl_ref(textureIndex));
	gmgl_delete_gl_ref(textureIndex);
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

GMS_DLL double gl_gen_framebuffer() {
	double framebufferIndex = gmgl_new_gl_ref();
	glGenFramebuffers(1, gmgl_get_gl_ref(framebufferIndex));
	return framebufferIndex;
}

GMS_DLL void gl_bind_framebuffer(double target, double framebufferIndex) {
	glBindFramebuffer(target, *gmgl_get_gl_ref(framebufferIndex));
}

GMS_DLL void gl_delete_framebuffer(double framebufferIndex) {
	glDeleteFramebuffers(1, gmgl_get_gl_ref(framebufferIndex));
	gmgl_delete_gl_ref(framebufferIndex);
}

#pragma region Shaders

GMS_DLL double gl_create_shader(double type, char* source) {
	unsigned int shader = glCreateShader(type);
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

	return gmgl_new_gl_ref(shader);
}

GMS_DLL void gl_delete_shader(double shaderIndex) {
	glDeleteShader(*gmgl_get_gl_ref(shaderIndex));
}

GMS_DLL double gl_create_program() {
	unsigned int program = glCreateProgram();
	return gmgl_new_gl_ref(program);
}

GMS_DLL void gl_attach_shader(double programIndex, double shaderIndex) {
	glAttachShader(*gmgl_get_gl_ref(programIndex), *gmgl_get_gl_ref(shaderIndex));
}

GMS_DLL void gl_link_program(double programIndex) {
	unsigned int program = *gmgl_get_gl_ref(programIndex);
	glLinkProgram(program);

	int success;
	char infoLog[512];
	glGetProgramiv(program, GL_LINK_STATUS, &success);
	if (!success) {
		glGetProgramInfoLog(program, 512, nullptr, infoLog);
		std::cout << "Program linking failed:" << infoLog << std::endl;
	}
}

GMS_DLL void gl_use_program(double programIndex) {
	glUseProgram(*gmgl_get_gl_ref(programIndex));
}

GMS_DLL double gl_get_uniform_location(double programIndex, const char* name) {
	return glGetUniformLocation(*gmgl_get_gl_ref(programIndex), name);
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
	glUniform1fv(location, size, (GLfloat*)value);
}
GMS_DLL void gl_uniform2fv(double location, double size, void* value) {
	glUniform2fv(location, size, (GLfloat*)value);
}
GMS_DLL void gl_uniform3fv(double location, double size, void* value) {
	glUniform3fv(location, size, (GLfloat*)value);
}
GMS_DLL void gl_uniform4fv(double location, double size, void* value) {
	glUniform4fv(location, size, (GLfloat*)value);
}

GMS_DLL void gl_uniform1iv(double location, double size, void* value) {
	glUniform1iv(location, size, (GLint*)value);
}
GMS_DLL void gl_uniform2iv(double location, double size, void* value) {
	glUniform2iv(location, size, (GLint*)value);
}
GMS_DLL void gl_uniform3iv(double location, double size, void* value) {
	glUniform3iv(location, size, (GLint*)value);
}
GMS_DLL void gl_uniform4iv(double location, double size, void* value) {
	glUniform4iv(location, size, (GLint*)value);
}

GMS_DLL void gl_uniform1uiv(double location, double size, void* value) {
	glUniform1uiv(location, size, (GLuint*)value);
}
GMS_DLL void gl_uniform2uiv(double location, double size, void* value) {
	glUniform2uiv(location, size, (GLuint*)value);
}
GMS_DLL void gl_uniform3uiv(double location, double size, void* value) {
	glUniform3uiv(location, size, (GLuint*)value);
}
GMS_DLL void gl_uniform4uiv(double location, double size, void* value) {
	glUniform4uiv(location, size, (GLuint*)value);
}

GMS_DLL void gl_uniform_mat2fv(double location, double count, double transpose, void* value) {
	glUniformMatrix2fv(location, count, transpose, (float*)value);
}
GMS_DLL void gl_uniform_mat3fv(double location, double count, double transpose, void* value) {
	glUniformMatrix3fv(location, count, transpose, (float*)value);
}
GMS_DLL void gl_uniform_mat4fv(double location, double count, double transpose, void* value) {
	glUniformMatrix4fv(location, count, transpose, (float*)value);
}

GMS_DLL void gl_uniform_mat2x3fv(double location, double count, double transpose, void* value) {
	glUniformMatrix2x3fv(location, count, transpose, (float*)value);
}
GMS_DLL void gl_uniform_mat3x2fv(double location, double count, double transpose, void* value) {
	glUniformMatrix3x2fv(location, count, transpose, (float*)value);
}
GMS_DLL void gl_uniform_mat2x4fv(double location, double count, double transpose, void* value) {
	glUniformMatrix2x4fv(location, count, transpose, (float*)value);
}

GMS_DLL void gl_uniform_mat4x2fv(double location, double count, double transpose, void* value) {
	glUniformMatrix4x2fv(location, count, transpose, (float*)value);
}
GMS_DLL void gl_uniform_mat3x4fv(double location, double count, double transpose, void* value) {
	glUniformMatrix3x4fv(location, count, transpose, (float*)value);
}
GMS_DLL void gl_uniform_mat4x3fv(double location, double count, double transpose, void* value) {
	glUniformMatrix4x3fv(location, count, transpose, (float*)value);
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
GMS_DLL void gl_texture_parameterf(double textureIndex, double pname, double param) {
	glTextureParameterf(*gmgl_get_gl_ref(textureIndex), pname, param);
}
GMS_DLL void gl_texture_parameteri(double textureIndex, double pname, double param) {
	glTextureParameteri(*gmgl_get_gl_ref(textureIndex), pname, param);
}

GMS_DLL void gl_tex_parameterfv(double target, double pname, void* param) {
	glTexParameterfv(target, pname, (const GLfloat*)param);
}
GMS_DLL void gl_tex_parameteriv(double target, double pname, void* param) {
	glTexParameteriv(target, pname, (const GLint*)param);
}
GMS_DLL void gl_texture_parameterfv(double textureIndex, double pname, void* param) {
	glTextureParameterfv(*gmgl_get_gl_ref(textureIndex), pname, (const GLfloat*)param);
}
GMS_DLL void gl_texture_parameteriv(double textureIndex, double pname, void* param) {
	glTextureParameteriv(*gmgl_get_gl_ref(textureIndex), pname, (const GLint*)param);
}

GMS_DLL void gl_tex_parameterIiv(double target, double pname, void* param) {
	glTexParameterIiv(target, pname, (const GLint*)param);
}
GMS_DLL void gl_tex_parameterIuiv(double target, double pname, void* param) {
	glTexParameterIuiv(target, pname, (const GLuint*)param);
}
GMS_DLL void gl_texture_parameterIiv(double textureIndex, double pname, void* param) {
	glTextureParameterIiv(*gmgl_get_gl_ref(textureIndex), pname, (const GLint*)param);
}
GMS_DLL void gl_texture_parameterIuiv(double textureIndex, double pname, void* param) {
	glTextureParameterIuiv(*gmgl_get_gl_ref(textureIndex), pname, (const GLuint*)param);
}

#pragma endregion

#pragma endregion
