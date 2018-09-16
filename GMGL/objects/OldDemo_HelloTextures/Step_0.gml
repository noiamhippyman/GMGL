gl_clear_color(0.2,0.3,0.3,1.0);
gl_clear(GL_COLOR_BUFFER_BIT);

gl_active_texture(GL_TEXTURE0);
gl_bind_texture(GL_TEXTURE_2D, texture1);
gl_active_texture(GL_TEXTURE1);
gl_bind_texture(GL_TEXTURE_2D, texture2);

gl_use_program(program);
gl_bind_vertex_array(vao);
gl_draw_elements(GL_TRIANGLES,6);

glfw_update();