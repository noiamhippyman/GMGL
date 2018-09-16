//user input
var dt = delta_time / 1000000;

if (gmgl_key_press(GLFW_KEY_W)) {
	cameraPos = vector_add(cameraPos, vector_multiply(cameraFront,cameraSpeed * dt));
}
if (gmgl_key_press(GLFW_KEY_S)) {
	cameraPos = vector_subtract(cameraPos, vector_multiply(cameraFront,cameraSpeed * dt));
}
if (gmgl_key_press(GLFW_KEY_D)) {
	cameraPos = vector_subtract(cameraPos, vector_multiply(vector_cross(cameraFront,cameraUp),cameraSpeed * dt));
}
if (gmgl_key_press(GLFW_KEY_A)) {
	cameraPos = vector_add(cameraPos, vector_multiply(vector_cross(cameraFront,cameraUp),cameraSpeed * dt));
}

var mx = gmgl_mouse_x();
var my = gmgl_mouse_y();

if (gmgl_mouse_press(GLFW_MOUSE_BUTTON_LEFT) && cameraFirstMouse) {
	cameraLastX = mx;
	cameraLastY = my;
	cameraFirstMouse = false;
	gmgl_mouse_lock();
} else {
	if (!cameraFirstMouse) {
		var xoff = cameraLastX - mx;
		var yoff = cameraLastY - my;
		cameraLastX = mx;
		cameraLastY = my;

		var sensitivity = 0.1;
		xoff *= sensitivity;
		yoff *= sensitivity;

		cameraYaw += xoff;
		cameraPitch = clamp(cameraPitch + yoff,-89,89);

		cameraFront = vector_normalize([
			dcos(cameraYaw) * dcos(cameraPitch),
			dsin(cameraPitch),
			dsin(cameraYaw) * dcos(cameraPitch)
		]);

		if (!gmgl_mouse_press(GLFW_MOUSE_BUTTON_LEFT)) {
			cameraFirstMouse = true;
			gmgl_mouse_normal();
		}
	}
}
//update view matrix buffer
view = gmgl_matrix_build_lookat(cameraPos,vector_add(cameraPos,cameraFront),cameraUp);
buffer_seek(viewMatrixBuffer,buffer_seek_start,0);
for (var i = 0; i < 16; ++i) {
	buffer_write(viewMatrixBuffer,buffer_f32,view[i]);
}

//Rendering
gl_clear_color(0.2,0.3,0.3,1.0);
gl_clear(GL_COLOR_BUFFER_BIT|GL_DEPTH_BUFFER_BIT);

gl_active_texture(GL_TEXTURE0);
gl_bind_texture(GL_TEXTURE_2D, texture1);
gl_active_texture(GL_TEXTURE1);
gl_bind_texture(GL_TEXTURE_2D, texture2);

gl_use_program(program);
gl_uniform_mat4fv(uView,1,GMGL_FALSE,buffer_get_address(viewMatrixBuffer));
gl_uniform_mat4fv(uProj,1,GMGL_FALSE,buffer_get_address(projMatrixBuffer));

gl_bind_vertex_array(vao);

var t = (current_time / 500);
var count = array_length_1d(modelPositions);
for (var i = 0; i < count; ++i) {
	var p = modelPositions[i];
	var a = (i * 20);
	a += t;
	var model = gmgl_matrix_build(p[0],p[1],p[2], a, a*0.5, a*0.3, 1,1,1);
	buffer_seek(modelMatrixBuffer,buffer_seek_start,0);
	for (var j = 0; j < 16; ++j) {
		buffer_write(modelMatrixBuffer,buffer_f32,model[j]);
	}
	gl_uniform_mat4fv(uModel,1,GMGL_FALSE,buffer_get_address(modelMatrixBuffer));
	
	gl_draw_arrays(GL_TRIANGLES, 0, 36);
}

glfw_update();

