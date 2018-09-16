gmgl_clear_color(0.2,0.3,0.3,1.0);
gmgl_clear(GL_COLOR_BUFFER_BIT);

gmgl_use_program(program);
gmgl_bind_vertex_array(vao);

var t = (current_time / 10) mod 360;
gmgl_uniform4f(colorUniform,dcos(t) / 2 + 0.5,dsin(t) / 2 + 0.5,0,1);
//gmgl_draw_arrays(GL_TRIANGLES,0,3);
gmgl_draw_elements(GL_TRIANGLES,6);

gmgl_update();