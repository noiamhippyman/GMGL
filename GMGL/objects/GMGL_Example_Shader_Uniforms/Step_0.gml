// Set the background clear color
gl_clear_color(0.2,0.3,0.3,1.0);

// Actually clear screen with background color
gl_clear(GL_COLOR_BUFFER_BIT);

/* 
	Similar to shader_set, this sets the current 
	shader program to use when rendering things 
*/
gl_use_program(shaderProgram);

/*
	After setting the shader you want to use you can start
	setting it's uniforms with the gl_uniform* functions
*/
var t = (current_time/10) mod 360;
gl_uniform3f(ColorUniformID,dcos(t) / 2 + 0.5,dsin(t) / 2 + 0.5,0);

// Bind the VAO that you want to render
gl_bind_vertex_array(vao);

// Draw vao vertices with element buffer
gl_draw_elements(GL_TRIANGLES, 6);

// Swaps buffers and polls events
glfw_update();