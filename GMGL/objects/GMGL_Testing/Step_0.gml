gmgl_clear_color(0.2, 0.3, 0.3, 1.0);

gmgl_shader_use(shader);
gmgl_vao_bind(vao);
gmgl_draw_arrays(GMGL_TRIANGLES, 0, 3);

gmgl_update();