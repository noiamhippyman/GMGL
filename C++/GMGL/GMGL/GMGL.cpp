#include "GMGL.h"


void callback_framebuffer_size(GLFWwindow* window, int width, int height) {
	glViewport(0, 0, width, height);
}
void callback_window_close(GLFWwindow* window) {
	if (glfwWindowShouldClose(window)) {
		void* data = glfwGetWindowUserPointer(window);
		GMGL* _gmgl = (GMGL*)data;
		_gmgl->free();
	}
}

GMGL::GMGL()
{
	m_glfwInitialized = false;
	m_window = nullptr;
}


GMGL::~GMGL()
{
	//Delete any GMGLobjects that still exist
	for (std::vector<GMGLobject*>::iterator it = m_objects.begin(); it != m_objects.end(); ++it) {
		delete *it;
	}
}

GLuint GMGL::init() {
	if (m_glfwInitialized) {
		std::cout << "GLFW already initialized" << std::endl;
		return GMS_FAIL;
	}

	if (!glfwInit()) {
		std::cout << "GLFW initialization failed" << std::endl;
		return GMS_FAIL;
	}

	m_glfwInitialized = true;
	return GMS_SUCCESS;
}

void GMGL::update() {
	glfwSwapBuffers(m_window);
	glfwPollEvents();
}

void GMGL::free() {
	glfwTerminate();
	m_glfwInitialized = false;
	delete this;
}

void GMGL::setGLversion(int major, int minor) {
	glfwWindowHint(GLFW_CONTEXT_VERSION_MAJOR, major);
	glfwWindowHint(GLFW_CONTEXT_VERSION_MINOR, minor);
	glfwWindowHint(GLFW_OPENGL_PROFILE, GLFW_OPENGL_CORE_PROFILE);
}

GLuint GMGL::createWindow(int width, int height, const char* title) {
	if (m_window) {
		std::cout << "Window already exists" << std::endl;
		return GMS_FAIL;
	}

	m_window = glfwCreateWindow(width, height, title, nullptr, nullptr);
	if (!m_window) {
		std::cout << "Window creation failed" << std::endl;
		glfwTerminate();
		return GMS_FAIL;
	}

	glfwMakeContextCurrent(m_window);

	if (glewInit() != GLEW_OK) {
		std::cout << "GLEW initialization failed" << std::endl;
		glfwTerminate();
		return GMS_FAIL;
	}

	glfwSetWindowUserPointer(m_window, this);
	glfwSetFramebufferSizeCallback(m_window, callback_framebuffer_size);
	glfwSetWindowCloseCallback(m_window, callback_window_close);

	return GMS_SUCCESS;
}

void GMGL::clearColor(double r, double g, double b, double a) {
	glClearColor(r, g, b, a);
	glClear(GL_COLOR_BUFFER_BIT);
}

double GMGL::new_object() {
	double index;
	GMGLobject* object = new GMGLobject;

	if (!m_object_slots.empty()) {
		index = m_object_slots.back();
		m_object_slots.pop_back();
		m_objects[index] = object;
	} else {
		index = m_objects.size();
		m_objects.push_back(object);
	}

	return index;
}

GMGLobject* GMGL::get_object(double id) {
	return m_objects[id];
}

void GMGL::delete_object(double id) {
	if (m_objects.size() > id && m_objects[id] != nullptr) {
		delete m_objects[id];
		m_objects[id] = nullptr;
		m_object_slots.push_back(id);
	}
}
