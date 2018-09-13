//user input
if (gmgl_key_press(GMGL_KEY_ESCAPE)) game_end();
show_debug_message(string(gmgl_mouse_x()) + "," + string(gmgl_mouse_y()));
var xaxis = gmgl_key_press(GMGL_KEY_D) - gmgl_key_press(GMGL_KEY_A);
var yaxis = gmgl_key_press(GMGL_KEY_W) - gmgl_key_press(GMGL_KEY_S);
var zaxis = gmgl_key_press(GMGL_KEY_E) - gmgl_key_press(GMGL_KEY_Q);
var dt = delta_time / 1000000;

if (gmgl_key_press(GMGL_KEY_W)) {
	cameraPos = vector_add(cameraPos, vector_multiply(cameraFront,cameraSpeed * dt));
}
if (gmgl_key_press(GMGL_KEY_S)) {
	cameraPos = vector_subtract(cameraPos, vector_multiply(cameraFront,cameraSpeed * dt));
}
if (gmgl_key_press(GMGL_KEY_A)) {
	cameraPos = vector_subtract(cameraPos, vector_multiply(vector_cross(cameraFront,cameraUp),cameraSpeed * dt));
}
if (gmgl_key_press(GMGL_KEY_D)) {
	cameraPos = vector_add(cameraPos, vector_multiply(vector_cross(cameraFront,cameraUp),cameraSpeed * dt));
}

var mx = gmgl_mouse_x();
var my = gmgl_mouse_y();

if (gmgl_mouse_press(GMGL_MOUSE_BUTTON_LEFT) && cameraFirstMouse) {
	cameraLastX = mx;
	cameraLastY = my;
	cameraFirstMouse = false;
	gmgl_mouse_lock();
} else {
	if (!cameraFirstMouse) {
		var xoff = mx - cameraLastX;
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

		if (!gmgl_mouse_press(GMGL_MOUSE_BUTTON_LEFT)) {
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
gmgl_clear_color(0.2,0.3,0.3,1.0);
gmgl_clear(GMGL_COLOR_BUFFER_BIT|GMGL_DEPTH_BUFFER_BIT);

gmgl_active_texture(GMGL_TEXTURE0);
gmgl_bind_texture(GMGL_TEXTURE_2D, texture1);
gmgl_active_texture(GMGL_TEXTURE1);
gmgl_bind_texture(GMGL_TEXTURE_2D, texture2);

gmgl_use_program(program);
gmgl_uniform_mat4fv(uView,1,GMGL_FALSE,buffer_get_address(viewMatrixBuffer));
gmgl_uniform_mat4fv(uProj,1,GMGL_FALSE,buffer_get_address(projMatrixBuffer));

gmgl_bind_vertex_array(vao);

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
	gmgl_uniform_mat4fv(uModel,1,GMGL_FALSE,buffer_get_address(modelMatrixBuffer));
	
	gmgl_draw_arrays(GMGL_TRIANGLES, 0, 36);
}

gmgl_update();

