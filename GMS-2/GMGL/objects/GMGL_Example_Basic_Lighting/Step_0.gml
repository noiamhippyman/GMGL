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




// Set the background clear color
gl_clear_color(0.2,0.3,0.3,1.0);

// Actually clear screen with background color
gl_clear(GL_COLOR_BUFFER_BIT|GL_DEPTH_BUFFER_BIT);

/* 
	Similar to shader_set, this sets the current 
	shader program to use when rendering things 
*/
gl_use_program(shaderLighting);
gmgl_shader_set_vec3(shaderLighting, "objectColor", [1.0, 0.5, 0.31]);
gmgl_shader_set_vec3(shaderLighting, "lightColor", [1,1,1]);
gmgl_shader_set_vec3(shaderLighting, "lightPos", lightPos);
gmgl_shader_set_vec3(shaderLighting, "viewPos", cameraPos);

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


//Now we can set up our model-view-projection matrix uniforms
var modelLoc = gl_get_uniform_location(shaderLighting, "model");
var viewLoc = gl_get_uniform_location(shaderLighting, "view");
var projLoc = gl_get_uniform_location(shaderLighting, "projection");
gl_uniform_mat4fv(modelLoc, 1, GMGL_FALSE, buffer_get_address(modelMatrixBuffer));
gl_uniform_mat4fv(viewLoc, 1, GMGL_FALSE, buffer_get_address(viewMatrixBuffer));
gl_uniform_mat4fv(projLoc, 1, GMGL_FALSE, buffer_get_address(projMatrixBuffer));

// Bind the VAO that you want to render
gl_bind_vertex_array(cubeVAO);

// Draw array 
gl_draw_arrays(GL_TRIANGLES, 0, 36);

gl_use_program(shaderLamp);

model = matrix_build(lightPos[0], lightPos[1], lightPos[2],	  0, 0, 0,   0.2, 0.2, 0.2);
buffer_seek(modelMatrixBuffer, buffer_seek_start, 0);
for (var i = 0; i < 16; ++i) {
	buffer_write(modelMatrixBuffer, buffer_f32, model[i]);
}
gmgl_shader_set_mat4(shaderLamp, "model", modelMatrixBuffer);
gmgl_shader_set_mat4(shaderLamp, "view", viewMatrixBuffer);
gmgl_shader_set_mat4(shaderLamp, "projection", projMatrixBuffer);

// Bind the VAO that you want to render
gl_bind_vertex_array(lampVAO);

// Draw array 
gl_draw_arrays(GL_TRIANGLES, 0, 36);

// Swaps buffers and polls events
glfw_update();