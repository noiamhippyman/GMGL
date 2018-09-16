gl_clear_color(0.2,0.3,0.3,1.0);
gl_clear(GL_COLOR_BUFFER_BIT);

gl_active_texture(GL_TEXTURE0);
gl_bind_texture(GL_TEXTURE_2D, texture1);
gl_active_texture(GL_TEXTURE1);
gl_bind_texture(GL_TEXTURE_2D, texture2);

var t = (current_time/10)mod 360;
var model = gmgl_matrix_build(dcos(t), -dsin(t),0,-55,0,0,1,1,1);
buffer_seek(modelMatrixBuffer,buffer_seek_start,0);
for (var i = 0; i < 16; ++i) {
	buffer_write(modelMatrixBuffer,buffer_f32,model[i]);
}

gl_use_program(program);
gl_uniform_mat4fv(uModel,1,GMGL_FALSE,buffer_get_address(modelMatrixBuffer));
gl_uniform_mat4fv(uView,1,GMGL_FALSE,buffer_get_address(viewMatrixBuffer));
gl_uniform_mat4fv(uProj,1,GMGL_FALSE,buffer_get_address(projMatrixBuffer));

gl_bind_vertex_array(vao);
gl_draw_elements(GL_TRIANGLES,6);

glfw_update();