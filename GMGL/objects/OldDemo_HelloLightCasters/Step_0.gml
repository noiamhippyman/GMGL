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
var view = gmgl_matrix_build_lookat(cameraPos,vector_add(cameraPos,cameraFront),cameraUp);
buffer_seek(viewMatrixBuffer,buffer_seek_start,0);
for (var i = 0; i < 16; ++i) {
	buffer_write(viewMatrixBuffer,buffer_f32,view[i]);
}

//Update projection matrix buffer
var proj = matrix_build_projection_perspective_fov(45,scr_width/scr_height,0.1,1000.0);
buffer_seek(projMatrixBuffer,buffer_seek_start,0);
for (var i = 0; i < 16; ++i) {
	buffer_write(projMatrixBuffer,buffer_f32,proj[i]);
}


gmgl_clear_color(0.1,0.1,0.1,1.0);
gmgl_clear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);


gmgl_use_program(shaderMaterial);
gmgl_shader_set_vec3(shaderMaterial,"viewPos",cameraPos);
gmgl_shader_set_float(shaderMaterial,"material.shininess",32.0);

gmgl_shader_set_vec3(shaderMaterial,"dirLight.direction", [-0.2,-1,-0.3]);
gmgl_shader_set_vec3(shaderMaterial,"dirLight.ambient", [0.05,0.05,0.05]);
gmgl_shader_set_vec3(shaderMaterial,"dirLight.diffuse", [0.4,0.4,0.4]);
gmgl_shader_set_vec3(shaderMaterial,"dirLight.specular", [0.5,0.5,0.5]);


for (var i = 0; i < 4; ++i) {
	gmgl_shader_set_vec3(shaderMaterial,"pointLights["+string(i)+"].position", pointLightPositions[i]);
	gmgl_shader_set_vec3(shaderMaterial,"pointLights["+string(i)+"].ambient", vector_multiply(pointLightColors[i],0.05));
	gmgl_shader_set_vec3(shaderMaterial,"pointLights["+string(i)+"].diffuse", vector_multiply(pointLightColors[i],0.8));
	gmgl_shader_set_vec3(shaderMaterial,"pointLights["+string(i)+"].specular", [1,1,1]);
	gmgl_shader_set_float(shaderMaterial,"pointLights["+string(i)+"].constant", 1);
	gmgl_shader_set_float(shaderMaterial,"pointLights["+string(i)+"].linear", 0.09);
	gmgl_shader_set_float(shaderMaterial,"pointLights["+string(i)+"].quadratic", 0.032);
}

gmgl_shader_set_vec3(shaderMaterial,"spotLight.position", cameraPos);
gmgl_shader_set_vec3(shaderMaterial,"spotLight.direction",cameraFront);
gmgl_shader_set_vec3(shaderMaterial,"spotLight.ambient",[0,0,0]);
gmgl_shader_set_vec3(shaderMaterial,"spotLight.diffuse",[1,1,1]);
gmgl_shader_set_vec3(shaderMaterial,"spotLight.specular",[1,1,1]);
gmgl_shader_set_float(shaderMaterial,"spotLight.constant", 1);
gmgl_shader_set_float(shaderMaterial,"spotLight.linear", 0.09);
gmgl_shader_set_float(shaderMaterial,"spotLight.quadratic", 0.032);
gmgl_shader_set_float(shaderMaterial,"spotLight.cutOff", dcos(12.5));
gmgl_shader_set_float(shaderMaterial,"spotLight.outerCutoff", dcos(15));

gmgl_shader_set_mat4(shaderMaterial,"projection",projMatrixBuffer);
gmgl_shader_set_mat4(shaderMaterial,"view",viewMatrixBuffer);
gmgl_shader_set_mat4(shaderMaterial,"model",modelMatrixBuffer);

gmgl_active_texture(GL_TEXTURE0);
gmgl_bind_texture(GL_TEXTURE_2D,diffuseMap);

gmgl_active_texture(GL_TEXTURE1);
gmgl_bind_texture(GL_TEXTURE_2D,specularMap);

var t = current_time / 100;
gmgl_bind_vertex_array(cubevao);
for (var i = 0; i < array_length_1d(cubePositions); ++i) {
	var p = cubePositions[i];
	var a = i * 20;
	a += t;
	var model = gmgl_matrix_build(p[0],p[1],p[2],a, a*0.3, a*0.5,1,1,1);
	buffer_seek(modelMatrixBuffer,buffer_seek_start,0);
	for (var j = 0; j < 16; ++j) {
		buffer_write(modelMatrixBuffer,buffer_f32,model[j]);
	}
	gmgl_shader_set_mat4(shaderMaterial,"model",modelMatrixBuffer);
	gmgl_draw_arrays(GL_TRIANGLES,0,36);
}

gmgl_use_program(shaderLamp);
gmgl_shader_set_mat4(shaderLamp,"projection",projMatrixBuffer);
gmgl_shader_set_mat4(shaderLamp,"view",viewMatrixBuffer);

gmgl_bind_vertex_array(lightvao);
for (var i = 0; i < array_length_1d(pointLightPositions); ++i) {
	var p = pointLightPositions[i];
	var c = pointLightColors[i];
	var model = gmgl_matrix_build(p[0],p[1],-p[2], 0,0,0, 0.2,0.2,0.2);
	buffer_seek(modelMatrixBuffer,buffer_seek_start,0);
	for (var j = 0; j < 16; ++j) {
		buffer_write(modelMatrixBuffer,buffer_f32,model[j]);
	}
	gmgl_shader_set_vec3(shaderLamp,"LightColor",c);
	gmgl_shader_set_mat4(shaderLamp,"model",modelMatrixBuffer);
	gmgl_draw_arrays(GL_TRIANGLES,0,36);
}

gmgl_update();