gmgl_clear_color(0.2,0.3,0.3,1.0);

gmgl_active_texture(GMGL_TEXTURE0);
gmgl_bind_texture(GMGL_TEXTURE_2D, texture1);
gmgl_active_texture(GMGL_TEXTURE1);
gmgl_bind_texture(GMGL_TEXTURE_2D, texture2);
var t = (current_time/10)mod 360;
var transform = matrix_build(0.5,-0.5,0.5, 0,-t,t, 1,1,1);
buffer_seek(matrixBuffer,buffer_seek_start,0);
for (var i = 0; i < 16; ++i) {
	buffer_write(matrixBuffer,buffer_f32,transform[i]);
}

gmgl_use_program(program);

var transformLoc = gmgl_get_uniform_location(program,"transform");
gmgl_uniform_mat4fv(transformLoc,1,GMGL_FALSE,buffer_get_address(matrixBuffer));

gmgl_bind_vertex_array(vao);
gmgl_draw_elements(GMGL_TRIANGLES,6);

gmgl_update();