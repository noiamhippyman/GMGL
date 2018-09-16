gmgl_clear_color(0.2,0.3,0.3,1.0);
gmgl_clear(GL_COLOR_BUFFER_BIT);

gmgl_active_texture(GL_TEXTURE0);
gmgl_bind_texture(GL_TEXTURE_2D, texture1);
gmgl_active_texture(GL_TEXTURE1);
gmgl_bind_texture(GL_TEXTURE_2D, texture2);

var t = (current_time/10)mod 360;
var model = gmgl_matrix_build(dcos(t), -dsin(t),0,-55,0,0,1,1,1);
buffer_seek(modelMatrixBuffer,buffer_seek_start,0);
for (var i = 0; i < 16; ++i) {
	buffer_write(modelMatrixBuffer,buffer_f32,model[i]);
}

gmgl_use_program(program);
gmgl_uniform_mat4fv(uModel,1,GMGL_FALSE,buffer_get_address(modelMatrixBuffer));
gmgl_uniform_mat4fv(uView,1,GMGL_FALSE,buffer_get_address(viewMatrixBuffer));
gmgl_uniform_mat4fv(uProj,1,GMGL_FALSE,buffer_get_address(projMatrixBuffer));

gmgl_bind_vertex_array(vao);
gmgl_draw_elements(GL_TRIANGLES,6);

gmgl_update();