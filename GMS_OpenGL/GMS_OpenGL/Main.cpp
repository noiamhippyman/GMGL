#define GMS_DLL extern "C" __declspec(dllexport)

#define GMS_SUCCESS 1
#define GMS_FAIL -1
#define GMS_NOONE -4

#define GLEW_STATIC
#include <GL/glew.h>
#include <GLFW/glfw3.h>
#include <iostream>
#include <vector>

GLFWwindow* _gmgl_window = nullptr;
std::vector<unsigned int*> _gmgl_objects;
std::vector<unsigned int> _gmgl_objects_open_spots;


#pragma region Testing Shit out

#pragma endregion


GMS_DLL void gmgl_free();

#pragma region Internals
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

	if (!_gmgl_objects_open_spots.empty()) {
	index = _gmgl_objects_open_spots.back();
	_gmgl_objects_open_spots.pop_back();
	_gmgl_objects[index] = new unsigned int;
	} else {
	index = _gmgl_objects.size();
	_gmgl_objects.push_back(new unsigned int);
	}

	return index;
}

unsigned int* gmgl_get_object(double index) {
	return _gmgl_objects[index];
}

void gmgl_delete_object(double index) {
	if (_gmgl_objects.size() > index && _gmgl_objects[index] != nullptr) {
		delete _gmgl_objects[index];
		_gmgl_objects[index] = nullptr;
		_gmgl_objects_open_spots.push_back(index);
	}
}

#pragma endregion

#pragma region GMGL Functions

GMS_DLL double gmgl_is_active() {
	if (!_gmgl_window) return GMS_FAIL;

	return GMS_SUCCESS;
}

GMS_DLL double gmgl_init(double major, double minor) {
	if (!glfwInit()) {
		return GMS_FAIL;
	}

	glfwWindowHint(GLFW_CONTEXT_VERSION_MAJOR, major);
	glfwWindowHint(GLFW_CONTEXT_VERSION_MINOR, minor);
	if ((major < 3) || (minor < 2 && major > 2)) {
		glfwWindowHint(GLFW_OPENGL_PROFILE, GLFW_OPENGL_ANY_PROFILE);
	} else {
		glfwWindowHint(GLFW_OPENGL_PROFILE, GLFW_OPENGL_CORE_PROFILE);
	}

	return GMS_SUCCESS;
}

GMS_DLL void gmgl_update() {
	glfwSwapBuffers(gmgl_get_window());
	glfwPollEvents();
}

GMS_DLL void gmgl_free() {
	glfwTerminate();
	_gmgl_window = nullptr;
}

GMS_DLL double gmgl_create_window(double width, double height, const char* title) {

	if (gmgl_get_window()) return GMS_FAIL;//Window already exists

	GLFWwindow* window = glfwCreateWindow(width, height, title, nullptr, nullptr);

	if (!window) {
		fprintf(stderr, "GLFW window creation failed");
		glfwTerminate();
		return GMS_FAIL;
	}

	gmgl_set_window(window);
	glfwMakeContextCurrent(window);
	glfwSwapInterval(1);

	glfwSetWindowCloseCallback(window, gmgl_callback_window_close);
	glfwSetFramebufferSizeCallback(window, gmgl_callback_framebuffer_size);

	if (glewInit() != GLEW_OK) {
		fprintf(stderr, "GLEW initialization failed");
		glfwTerminate();
		return GMS_FAIL;
	}

	return GMS_SUCCESS;
}

GMS_DLL void gmgl_clear_color(double r, double g, double b, double a) {
	glClearColor(r, g, b, a);
	glClear(GL_COLOR_BUFFER_BIT);
}

GMS_DLL double gmgl_vbo_create() {
	double vboIndex = gmgl_new_object();
	unsigned int* VBO = gmgl_get_object(vboIndex);
	glGenBuffers(1, VBO);
	return vboIndex;
}

GMS_DLL void gmgl_vbo_bind(double target, double vboIndex) {
	glBindBuffer(target,*gmgl_get_object(vboIndex));
}

GMS_DLL void gmgl_vbo_data(double target, void* buffer, double size, double usage) {
	glBufferData(target, size, buffer, usage);
}

GMS_DLL double gmgl_shader_create() {
	double programIndex = gmgl_new_object();
	unsigned int* program = gmgl_get_object(programIndex);
	*program = glCreateProgram();
	return programIndex;
}

GMS_DLL double gmgl_shader_attach(double programIndex, double type, const char* source) {
	unsigned int* program = gmgl_get_object(programIndex);
	
	unsigned int shader = glCreateShader(type);
	glShaderSource(shader, 1, &source, nullptr);
	glCompileShader(shader);

	//Check if shader compilation was successful
	int success;
	char infoLog[512];
	glGetShaderiv(shader, GL_COMPILE_STATUS, &success);

	//If compilation failed print error to console and return fail error code
	if (!success) {
		glGetShaderInfoLog(shader, 512, nullptr, infoLog);
		fprintf(stderr, "ERROR::SHADER::COMPILATION FAILED::%s\n", infoLog);
		return GMS_FAIL;
	} else {
		fprintf(stderr, "SHADER::COMPILATION SUCCEEDED\n");
	}

	//If compilation succeeded attach shader to program
	glAttachShader(*program, shader);

	return GMS_SUCCESS;
}

GMS_DLL double gmgl_shader_link(double programIndex) {
	unsigned int* program = gmgl_get_object(programIndex);
	glLinkProgram(*program);

	//Check if shader program linking was successful
	int success;
	char infoLog[512];
	glGetProgramiv(*program, GL_COMPILE_STATUS, &success);

	//If compilation failed print error to console and return fail error code
	if (!success) {
		glGetProgramInfoLog(*program, 512, nullptr, infoLog);
		fprintf(stderr, "ERROR::SHADER PROGRAM::LINKING FAILED::%s\n", infoLog);
		return GMS_FAIL;
	} else {
		fprintf(stderr, "SHADER::LINKING SUCCEEDED\n");
	}

	return GMS_SUCCESS;

}

GMS_DLL void gmgl_shader_use(double programIndex) {
	unsigned int* program = gmgl_get_object(programIndex);
	glUseProgram(*program);
}

GMS_DLL void gmgl_vertex_attrib_pointer(double index, double size, double type, double normalized, double stride, double offset) {
	glVertexAttribPointer(index, size, type, normalized, stride, (void*)((int)offset));
}

GMS_DLL void gmgl_enable_vertex_attrib_array(double index) {
	glEnableVertexAttribArray(index);
}

GMS_DLL double gmgl_vao_create() {
	double vaoIndex = gmgl_new_object();
	unsigned int* VAO = gmgl_get_object(vaoIndex);
	glGenVertexArrays(1, VAO);
	return vaoIndex;
}

GMS_DLL void gmgl_vao_bind(double vaoIndex) {
	unsigned int vao = *gmgl_get_object(vaoIndex);
	glBindVertexArray(vao);
}

GMS_DLL void gmgl_draw_arrays(double mode, double first, double count) {
	glDrawArrays(mode, first, count);
}
#pragma endregion