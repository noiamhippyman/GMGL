//user input
var dt = delta_time / 1000000;

if (gmgl_key_press(GMGL_KEY_W)) {
	cameraPos = vector_add(cameraPos, vector_multiply(cameraFront,cameraSpeed * dt));
}
if (gmgl_key_press(GMGL_KEY_S)) {
	cameraPos = vector_subtract(cameraPos, vector_multiply(cameraFront,cameraSpeed * dt));
}
if (gmgl_key_press(GMGL_KEY_D)) {
	cameraPos = vector_subtract(cameraPos, vector_multiply(vector_cross(cameraFront,cameraUp),cameraSpeed * dt));
}
if (gmgl_key_press(GMGL_KEY_A)) {
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
gmgl_clear_color(0.1,0.1,0.1,1.0);
gmgl_clear(GMGL_COLOR_BUFFER_BIT | GMGL_DEPTH_BUFFER_BIT);


//Render cube
gmgl_use_program(shaderMaterial);

var diffuseColor = vector_multiply(lightColor,0.5);
var ambientColor = vector_multiply(diffuseColor,0.5);

gmgl_uniform3f(u_viewPos,cameraPos[0],cameraPos[1],cameraPos[2]);

gmgl_uniform3f(u_lightPos, lightPos[0],lightPos[1],lightPos[2]);
gmgl_uniform3f(u_lightAmbient, ambientColor[0],ambientColor[1],ambientColor[2]);
gmgl_uniform3f(u_lightDiffuse, diffuseColor[0],diffuseColor[1],diffuseColor[2]);
gmgl_uniform3f(u_lightSpecular, lightSpecular,lightSpecular,lightSpecular);

//gmgl_uniform3f(u_matAmbient, matAmbient[0],matAmbient[1],matAmbient[2]);
//gmgl_uniform3f(u_matDiffuse, matAmbient[0],matAmbient[1],matAmbient[2]);
//gmgl_uniform3f(u_matSpecular, matSpecular,matSpecular,matSpecular);
gmgl_uniform1f(u_matShininess, matShininess);

gmgl_uniform_mat4fv(gmgl_get_uniform_location(shaderMaterial,"view"),1,GMGL_FALSE,buffer_get_address(viewMatrixBuffer));
gmgl_uniform_mat4fv(gmgl_get_uniform_location(shaderMaterial,"projection"),1,GMGL_FALSE,buffer_get_address(projMatrixBuffer));

var p = cubePos;
var t = current_time / 10;

var model = gmgl_matrix_build(p[0],p[1],p[2], dcos(t mod 360) * 50,0,0, 1,1,1);
buffer_seek(modelMatrixBuffer,buffer_seek_start,0);
for (var j = 0; j < 16; ++j) {
	buffer_write(modelMatrixBuffer,buffer_f32,model[j]);
}
gmgl_uniform_mat4fv(gmgl_get_uniform_location(shaderMaterial,"model"),1,GMGL_FALSE,buffer_get_address(modelMatrixBuffer));

gmgl_active_texture(GMGL_TEXTURE0);
gmgl_bind_texture(GMGL_TEXTURE_2D, diffuseMap);
gmgl_active_texture(GMGL_TEXTURE1);
gmgl_bind_texture(GMGL_TEXTURE_2D, specularMap);

gmgl_bind_vertex_array(cubevao);
gmgl_draw_arrays(GMGL_TRIANGLES,0,36);

//Render lamp
gmgl_use_program(shaderLamp);
gmgl_uniform_mat4fv(gmgl_get_uniform_location(shaderLamp,"view"),1,GMGL_FALSE,buffer_get_address(viewMatrixBuffer));
gmgl_uniform_mat4fv(gmgl_get_uniform_location(shaderLamp,"projection"),1,GMGL_FALSE,buffer_get_address(projMatrixBuffer));

p = lightPos;

model = gmgl_matrix_build(p[0],p[1],-p[2], 0,0,0, 0.2,0.2,0.2);//why do I have to make z value negative for lighting to work?
buffer_seek(modelMatrixBuffer,buffer_seek_start,0);
for (var j = 0; j < 16; ++j) {
	buffer_write(modelMatrixBuffer,buffer_f32,model[j]);
}
gmgl_uniform_mat4fv(gmgl_get_uniform_location(shaderLamp,"model"),1,GMGL_FALSE,buffer_get_address(modelMatrixBuffer));

gmgl_bind_vertex_array(lightvao);
gmgl_draw_arrays(GMGL_TRIANGLES,0,36);



gmgl_update();

