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