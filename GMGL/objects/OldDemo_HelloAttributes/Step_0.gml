gmgl_clear_color(0.2,0.3,0.3,1.0);
gmgl_clear(GL_COLOR_BUFFER_BIT);

gmgl_use_program(program);
gmgl_bind_vertex_array(vao);
gmgl_draw_arrays(GL_TRIANGLES,0,3);

gmgl_update();