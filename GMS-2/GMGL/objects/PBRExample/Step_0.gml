gl_clear_color(0,0,0,1.0);
gl_clear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);



gl_use_program(shader);

gl_active_texture(GL_TEXTURE0);
gl_bind_texture(GL_TEXTURE_2D, mat_albedo);
gl_active_texture(GL_TEXTURE1);
gl_bind_texture(GL_TEXTURE_2D, mat_normal);
gl_active_texture(GL_TEXTURE2);
gl_bind_texture(GL_TEXTURE_2D, mat_metallic);
gl_active_texture(GL_TEXTURE3);
gl_bind_texture(GL_TEXTURE_2D, mat_roughness);
gl_active_texture(GL_TEXTURE4);
gl_bind_texture(GL_TEXTURE_2D, mat_ao);

var modelMatrix = matrix_build(0,0,0, 90,0,0, 1,1,1);
matrix_to_buffer(modelMatrix,modelMatrixBuffer);
gmgl_shader_set_mat4(shader, "model", modelMatrixBuffer);

var view = gmgl_matrix_build_lookat(camID.position, vector_add(camID.position, camID.front), camID.up);
matrix_to_buffer(view, viewMatrixBuffer);
gmgl_shader_set_mat4(shader, "view", viewMatrixBuffer);

gmgl_shader_set_vec3(shader, "camPos", camID.position);

for (var i = 0; i < lightCount; ++i) {
	var pos = lightPositions[i];
	var col = lightColors[i];
	gmgl_shader_set_vec3(shader, "lightPositions["+string(i)+"]", pos);
	gmgl_shader_set_vec3(shader, "lightColors["+string(i)+"]", col);
}

gmgl_model_draw(model);


gl_use_program(lampShader);
gmgl_shader_set_mat4(lampShader, "view", viewMatrixBuffer);



for (var i = 0; i < lightCount; ++i) {
	var t = (current_time / 10);
	var pos = lightPositions[i];
	pos[@1] = (dcos(t + (i*sqr(pi))) * 1.5) + 0.5;
	var col = lightColors[i];
	var modelMatrix = matrix_build(pos[0],pos[1],pos[2], 90,0,0, 0.1,0.1,0.1);
	matrix_to_buffer(modelMatrix,modelMatrixBuffer);
	gmgl_shader_set_mat4(lampShader, "model", modelMatrixBuffer);
	gmgl_shader_set_vec3(lampShader, "lightColor", col);
	gmgl_model_draw(model);
}