gl_clear_color(0.2,0.3,0.3,1.0);
gl_clear(GL_COLOR_BUFFER_BIT);

gl_active_texture(GL_TEXTURE0);
gl_bind_texture(GL_TEXTURE_2D, texture1);
gl_active_texture(GL_TEXTURE1);
gl_bind_texture(GL_TEXTURE_2D, texture2);
var t = (current_time/10)mod 360;
var transform = gmgl_matrix_build(0.5,-0.5,0.5, 0,-t,t, 1,1,1);
buffer_seek(matrixBuffer,buffer_seek_start,0);
for (var i = 0; i < 16; ++i) {
	buffer_write(matrixBuffer,buffer_f32,transform[i]);
}

gl_use_program(program);

var transformLoc = gl_get_uniform_location(program,"transform");
gl_uniform_mat4fv(transformLoc,1,GMGL_FALSE,buffer_get_address(matrixBuffer));

gl_bind_vertex_array(vao);
gl_draw_elements(GL_TRIANGLES,6);

glfw_update();