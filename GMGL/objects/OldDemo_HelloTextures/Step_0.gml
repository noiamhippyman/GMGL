gmgl_clear_color(0.2,0.3,0.3,1.0);
gmgl_clear(GL_COLOR_BUFFER_BIT);

gmgl_active_texture(GL_TEXTURE0);
gmgl_bind_texture(GL_TEXTURE_2D, texture1);
gmgl_active_texture(GL_TEXTURE1);
gmgl_bind_texture(GL_TEXTURE_2D, texture2);

gmgl_use_program(program);
gmgl_bind_vertex_array(vao);
gmgl_draw_elements(GL_TRIANGLES,6);

gmgl_update();