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

//Lets set up our matrices
var view = gmgl_matrix_build_lookat(cameraPos,vector_add(cameraPos,cameraFront),cameraUp);
buffer_seek(viewMatrixBuffer,buffer_seek_start,0);
for (var i = 0; i < 16; ++i) {
	buffer_write(viewMatrixBuffer,buffer_f32,view[i]);
}

var proj = matrix_build_projection_perspective_fov(cameraFOV,800/600,0.1,100.0);
buffer_seek(projMatrixBuffer,buffer_seek_start,0);
for (var i = 0; i < 16; ++i) {
	buffer_write(projMatrixBuffer,buffer_f32,proj[i]);
}

var t = (current_time/10) mod 359;
var model = matrix_build(0,0,0, 0,t,0, 1,1,1);
buffer_seek(modelMatrixBuffer, buffer_seek_start, 0);
for (var i = 0; i < 16; ++i) {
	buffer_write(modelMatrixBuffer, buffer_f32, model[i]);
}


gl_clear_color(0.1,0.1,0.1,1.0);
gl_clear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

gl_use_program(shaderProgram);
gmgl_shader_set_mat4(shaderProgram, "model", modelMatrixBuffer);
gmgl_shader_set_mat4(shaderProgram, "view", viewMatrixBuffer);
gmgl_shader_set_mat4(shaderProgram, "projection", projMatrixBuffer);

//cubes
gl_bind_vertex_array(cubeVAO);
gl_active_texture(GL_TEXTURE0);
gl_bind_texture(GL_TEXTURE_2D, cubeTexture);
gl_draw_arrays(GL_TRIANGLES, 0, 36);

//skybox
gl_depth_func(GL_LEQUAL);
gl_use_program(shaderSkyboxProgram);
gmgl_shader_set_mat4(shaderSkyboxProgram, "view", viewMatrixBuffer);
gmgl_shader_set_mat4(shaderSkyboxProgram, "projection", projMatrixBuffer);

gl_bind_vertex_array(skyboxVAO);
gl_bind_texture(GL_TEXTURE_CUBE_MAP, cubemapTexture);
gl_draw_arrays(GL_TRIANGLES, 0, 36);
gl_depth_func(GL_LESS);


// Swaps buffers and polls events
glfw_update();