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