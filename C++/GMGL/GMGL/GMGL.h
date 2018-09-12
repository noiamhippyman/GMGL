#pragma once
#define GLEW_STATIC
#include <GL/glew.h>
#include <GLFW/glfw3.h>
#include <vector>
#include <iostream>
#include "GMS_Extension.hpp"
struct GMGLobject {
	GLuint object;
};

class GMGL
{
public:
	GMGL();
	~GMGL();

	GLuint init();
	void update();
	void free();
	void setGLversion(int major, int minor);
	GLuint createWindow(int width, int height, const char* title);
	void clearColor(double r, double g, double b, double a);

	double new_object();
	GMGLobject* get_object(double id);
	void delete_object(double id);

	GLFWwindow* get_window() { return m_window; }

	bool isInit() { return m_glfwInitialized; }
private:
	std::vector<GMGLobject*> m_objects;
	std::vector<unsigned int> m_object_slots;

	GLFWwindow* m_window;

	bool m_glfwInitialized;
};

