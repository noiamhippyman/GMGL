gl_clear_color(0.2,0.3,0.3,1.0);
gl_clear(GL_COLOR_BUFFER_BIT);

gl_use_program(program);
gl_bind_vertex_array(vao);
gl_draw_elements(GL_TRIANGLES,6);

glfw_update();