var dt = delta_time / 1000000;

if (glfw_get_key(GLFW_KEY_W) == GLFW_PRESS) {
	position = vector_add(position, vector_multiply(front,movespeed * dt));
}
if (glfw_get_key(GLFW_KEY_S) == GLFW_PRESS) {
	position = vector_subtract(position, vector_multiply(front,movespeed * dt));
}
if (glfw_get_key(GLFW_KEY_D) == GLFW_PRESS) {
	position = vector_subtract(position, vector_multiply(vector_cross(front,up),movespeed * dt));
}
if (glfw_get_key(GLFW_KEY_A) == GLFW_PRESS) {
	position = vector_add(position, vector_multiply(vector_cross(front,up),movespeed * dt));
}
if (glfw_get_key(GLFW_KEY_Q) == GLFW_PRESS) {
	position = vector_subtract(position, vector_multiply(up, movespeed * dt));
}
if (glfw_get_key(GLFW_KEY_E) == GLFW_PRESS) {
	position = vector_add(position, vector_multiply(up, movespeed * dt));
}

var mx = global.gmgl_mouse_pos[0];
var my = global.gmgl_mouse_pos[1];

if (glfw_get_mouse_button(GLFW_MOUSE_BUTTON_LEFT) == GLFW_PRESS && firstMouse) {
	lastX = mx;
	lastY = my;
	firstMouse = false;
	
	glfw_set_input_mode(GLFW_CURSOR, GLFW_CURSOR_DISABLED);
	
} else {
	if (!firstMouse) {
		var xoff = lastX - mx;
		var yoff = lastY - my;
		lastX = mx;
		lastY = my;

		var sensitivity = 0.1;
		xoff *= sensitivity;
		yoff *= sensitivity;

		rotation[0] += xoff;
		rotation[1] = clamp(rotation[1] + yoff,-89,89);

		front = vector_normalize([
			cos(degtorad(rotation[0])) * cos(degtorad(rotation[1])),
			sin(degtorad(rotation[1])),
			sin(degtorad(rotation[0])) * cos(degtorad(rotation[1]))
		]);
		
		if (glfw_get_mouse_button(GLFW_MOUSE_BUTTON_LEFT) == GLFW_RELEASE) {
			firstMouse = true;
			glfw_set_input_mode(GLFW_CURSOR, GLFW_CURSOR_NORMAL);
		}
	}
}