// User Input
//user input
var dt = delta_time / 1000000;

if (glfw_get_key(GLFW_KEY_W) == GLFW_PRESS) {
	cameraPos = vector_add(cameraPos, vector_multiply(cameraFront,cameraSpeed * dt));
}
if (glfw_get_key(GLFW_KEY_S) == GLFW_PRESS) {
	cameraPos = vector_subtract(cameraPos, vector_multiply(cameraFront,cameraSpeed * dt));
}
if (glfw_get_key(GLFW_KEY_D) == GLFW_PRESS) {
	cameraPos = vector_subtract(cameraPos, vector_multiply(vector_cross(cameraFront,cameraUp),cameraSpeed * dt));
}
if (glfw_get_key(GLFW_KEY_A) == GLFW_PRESS) {
	cameraPos = vector_add(cameraPos, vector_multiply(vector_cross(cameraFront,cameraUp),cameraSpeed * dt));
}

var mx = global.gmgl_mouse_pos[0];
var my = global.gmgl_mouse_pos[1];

if (glfw_get_mouse_button(GLFW_MOUSE_BUTTON_LEFT) == GLFW_PRESS && cameraFirstMouse) {
	cameraLastX = mx;
	cameraLastY = my;
	cameraFirstMouse = false;
	
	glfw_set_input_mode(GLFW_CURSOR, GLFW_CURSOR_DISABLED);
	
} else {
	if (!cameraFirstMouse) {
		var xoff = cameraLastX - mx;
		var yoff = cameraLastY - my;
		cameraLastX = mx;
		cameraLastY = my;

		var sensitivity = 0.1;
		xoff *= sensitivity;
		yoff *= sensitivity;

		cameraRot[0] += xoff;
		cameraRot[1] = clamp(cameraRot[1] + yoff,-89,89);

		cameraFront = vector_normalize([
			cos(degtorad(cameraRot[0])) * cos(degtorad(cameraRot[1])),
			sin(degtorad(cameraRot[1])),
			sin(degtorad(cameraRot[0])) * cos(degtorad(cameraRot[1]))
		]);
		
		if (glfw_get_mouse_button(GLFW_MOUSE_BUTTON_LEFT) == GLFW_RELEASE) {
			cameraFirstMouse = true;
			glfw_set_input_mode(GLFW_CURSOR, GLFW_CURSOR_NORMAL);
		}
	}
}

var model,view,proj;

view = gmgl_matrix_build_lookat(cameraPos,vector_add(cameraPos,cameraFront),cameraUp);
buffer_seek(viewMatrixBuffer,buffer_seek_start,0);
for (var i = 0; i < 16; ++i) {
	buffer_write(viewMatrixBuffer,buffer_f32,view[i]);
}

proj = matrix_build_projection_perspective_fov(cameraFOV,800/600,0.1,100.0);
buffer_seek(projMatrixBuffer,buffer_seek_start,0);
for (var i = 0; i < 16; ++i) {
	buffer_write(projMatrixBuffer,buffer_f32,proj[i]);
}

gl_bind_framebuffer(GL_FRAMEBUFFER, framebuffer);
gl_enable(GL_DEPTH_TEST);

// Set the background clear color
gl_clear_color(0.2,0.3,0.3,1.0);

// Actually clear screen with background color
gl_clear(GL_COLOR_BUFFER_BIT|GL_DEPTH_BUFFER_BIT);

gl_use_program(shaderProgram);

gmgl_shader_set_mat4(shaderProgram, "projection", projMatrixBuffer);
gmgl_shader_set_mat4(shaderProgram, "view", viewMatrixBuffer);

// Draw Cubes
gl_bind_vertex_array(cubeVAO);
gl_active_texture(GL_TEXTURE0);
gl_bind_texture(GL_TEXTURE_2D, cubeTexture);

model = matrix_build(-1,0,-1, 0,0,0, 1,1,1);
buffer_seek(modelMatrixBuffer, buffer_seek_start, 0);
for (var i = 0; i < 16; ++i) {
	buffer_write(modelMatrixBuffer, buffer_f32, model[i]);
}
gmgl_shader_set_mat4(shaderProgram, "model", modelMatrixBuffer);
gl_draw_arrays(GL_TRIANGLES, 0, 36);

model = matrix_build(2,0,0, 0,0,0, 1,1,1);
buffer_seek(modelMatrixBuffer, buffer_seek_start, 0);
for (var i = 0; i < 16; ++i) {
	buffer_write(modelMatrixBuffer, buffer_f32, model[i]);
}
gmgl_shader_set_mat4(shaderProgram, "model", modelMatrixBuffer);
gl_draw_arrays(GL_TRIANGLES, 0, 36);

// Draw floor
gl_bind_vertex_array(planeVAO);
gl_bind_texture(GL_TEXTURE_2D, planeTexture);
model = matrix_build(0,0,0, 0,0,0, 1,1,1);
buffer_seek(modelMatrixBuffer, buffer_seek_start, 0);
for (var i = 0; i < 16; ++i) {
	buffer_write(modelMatrixBuffer, buffer_f32, model[i]);
}
gmgl_shader_set_mat4(shaderProgram, "model", modelMatrixBuffer);
gl_draw_arrays(GL_TRIANGLES, 0, 6);

// Windows
gl_bind_vertex_array(transVAO);

//gl_bind_texture(GL_TEXTURE_2D, windowTexture);
for (var i = 0; i < array_length_1d(blendedObjects); ++i) {
	var blendedObject = blendedObjects[i];
	var dist = point_distance_3d(cameraPos[0],cameraPos[1],cameraPos[2],blendedObject[0],blendedObject[1],blendedObject[2]);
	ds_priority_add(blendSortedQueue, blendedObjects[i], dist);
}

while (!ds_priority_empty(blendSortedQueue)) {
	var blendedObject = ds_priority_delete_max(blendSortedQueue);
	model = matrix_build(blendedObject[0],blendedObject[1],blendedObject[2],0,0,0,1,1,1);
	gl_bind_texture(GL_TEXTURE_2D, blendedObject[3]);
	buffer_seek(modelMatrixBuffer, buffer_seek_start, 0);
	for (var j = 0; j < 16; ++j) {
		buffer_write(modelMatrixBuffer, buffer_f32, model[j]);
	}
	gmgl_shader_set_mat4(shaderProgram, "model", modelMatrixBuffer);
	gl_draw_arrays(GL_TRIANGLES, 0, 6);
}

gl_bind_vertex_array(noone);

gl_bind_framebuffer(GL_FRAMEBUFFER, noone);
gl_disable(GL_DEPTH_TEST);

gl_clear_color(1,1,1,1);
gl_clear(GL_COLOR_BUFFER_BIT);

gl_use_program(shaderScreenProgram);
gl_bind_vertex_array(quadVAO);
gl_bind_texture(GL_TEXTURE_2D, textureColorBuffer);
gl_draw_arrays(GL_TRIANGLES, 0, 6);


// Swaps buffers and polls events
glfw_update();