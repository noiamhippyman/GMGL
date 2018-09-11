#include "GMGL.hpp"


#pragma region Testing Shit out
GMS_DLL void read_buffer_as_float(void* buffer, double size) {
	float* buff = (float*)buffer;
	for (int i = 0; i < size; ++i) {
		std::cout << buff[i] << " ";
	}
	std::cout << std::endl;
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

/*
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
glBufferData(target, size, (float*)buffer, usage);
}
*/

//TODO: Make vertex format class to input to vertex buffer
/*
GMS_DLL double gmgl_vertex_buffer_bind(double target, double vboIndex) {
GMGLvertexBuffer* vbuff = gmgl_get_vertex_buffer(vboIndex);
glBindBuffer(target, vbuff->vbo);
}
*/

GMS_DLL double gmgl_vertex_buffer_create() {
	double vboIndex = gmgl_new_vertex_buffer();
	GMGLvertexBuffer* vbuff = gmgl_get_vertex_buffer(vboIndex);
	glGenBuffers(1, &vbuff->vbo);
	return vboIndex;
}

GMS_DLL void gmgl_vertex_buffer_write_real(double vboIndex, double value) {
	GMGLvertexBuffer* vbuff = gmgl_get_vertex_buffer(vboIndex);
	vbuff->vertices.push_back(value);
}

GMS_DLL void gmgl_vertex_buffer_write_vec2(double vboIndex, double x, double y) {
	GMGLvertexBuffer* vbuff = gmgl_get_vertex_buffer(vboIndex);
	vbuff->vertices.push_back(x);
	vbuff->vertices.push_back(y);
}

GMS_DLL void gmgl_vertex_buffer_write_vec3(double vboIndex, double x, double y, double z) {
	GMGLvertexBuffer* vbuff = gmgl_get_vertex_buffer(vboIndex);
	vbuff->vertices.push_back(x);
	vbuff->vertices.push_back(y);
	vbuff->vertices.push_back(z);
}

GMS_DLL void gmgl_vertex_buffer_update(double target, double vboIndex, double usage) {
	GMGLvertexBuffer* vbuff = gmgl_get_vertex_buffer(vboIndex);
	float* data = vbuff->vertices.data();
	
	//bind this vbo to this target
	glBindBuffer(target, vbuff->vbo);
	
	//copy data to vbo
	glBufferData(target, sizeof(data), data, usage);

	//unbind vbo from this target
	glBindBuffer(target, 0);
}

GMS_DLL void gmgl_vertex_buffer_destroy(double vboIndex) {
	GMGLvertexBuffer* vbuff = gmgl_get_vertex_buffer(vboIndex);
	glDeleteBuffers(1, &vbuff->vbo);
	gmgl_delete_vertex_buffer(vboIndex);
}

GMS_DLL void gmgl_vertex_format_begin() {
	if (_gmgl_vao_setup.is_setting_up) return;
	
	_gmgl_vao_setup.is_setting_up = true;
	
	double vaoIndex = gmgl_new_vertex_array();
	_gmgl_vao_setup.varray = gmgl_get_vertex_array(vaoIndex);
	glGenVertexArrays(1, &_gmgl_vao_setup.varray->vao);
	glBindVertexArray(_gmgl_vao_setup.varray->vao);
}

GMS_DLL void gmgl_vertex_format_add(double type) {
	if (!_gmgl_vao_setup.is_setting_up) return;
	GLsizei stride;
	eGMGL_VAO_TYPE _type = (eGMGL_VAO_TYPE)type;
	switch (_type) {
	case REAL:
		stride = 1;
		break;
	case VEC2:
		stride = 2;
		break;
	case VEC3:
		stride = 3;
		break;
	case VEC4:
		stride = 4;
		break;
	}

	_gmgl_vao_setup.attribTypes.push_back(_type);
	_gmgl_vao_setup.attribStride.push_back(stride);
	_gmgl_vao_setup.attribCount++;
	_gmgl_vao_setup.stride += stride;
}

GMS_DLL double gmgl_vertex_format_end() {
	if (!_gmgl_vao_setup.is_setting_up) return 0;

	eGMGL_VAO_TYPE type;
	for (int i = 0; i < _gmgl_vao_setup.attribCount; ++i) {
		type = _gmgl_vao_setup.attribTypes[i];
		switch (type) {
		case REAL:
			break;
		case VEC2:
			break;
		case VEC3:
			break;
		case VEC4:
			break;
		}
	}
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

/*
GMS_DLL double gmgl_vao_create() {
double vaoIndex = gmgl_new_object();
unsigned int* VAO = gmgl_get_object(vaoIndex);
glGenVertexArrays(1, VAO);
return vaoIndex;
}
*/

GMS_DLL void gmgl_vao_bind(double vaoIndex) {
	unsigned int vao = *gmgl_get_object(vaoIndex);
	glBindVertexArray(vao);
}

GMS_DLL void gmgl_draw_arrays(double mode, double first, double count) {
	glDrawArrays(mode, first, count);
}
#pragma endregion