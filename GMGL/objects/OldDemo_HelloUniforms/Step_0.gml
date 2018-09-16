gl_clear_color(0.2,0.3,0.3,1.0);
gl_clear(GL_COLOR_BUFFER_BIT);

gl_use_program(program);
gl_bind_vertex_array(vao);

var t = (current_time / 10) mod 360;
gl_uniform4f(colorUniform,dcos(t) / 2 + 0.5,dsin(t) / 2 + 0.5,0,1);
//gl_draw_arrays(GL_TRIANGLES,0,3);
gl_draw_elements(GL_TRIANGLES,6);

glfw_update();