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
	After setting the shader you can bind the textures 
	to their corresponding texture units
*/
gl_active_texture(GL_TEXTURE0);
gl_bind_texture(GL_TEXTURE_2D, texture1);
gl_active_texture(GL_TEXTURE1);
gl_bind_texture(GL_TEXTURE_2D, texture2);


// First lets make a matrix
var t = (current_time/10)mod 360;
var transform = matrix_build(0.5,-0.5,0, 0,0,t, 1,1,1);

// Now that we have our matrix we need to store it in our matrix buffer from before
buffer_seek(transformMatrixBuffer, buffer_seek_start, 0);
for (var i = 0; i < 16; ++i) {
	buffer_write(transformMatrixBuffer, buffer_f32, transform[i]);
}

// Now we can pass the buffer address as a matrix to the shader uniform
var transformLoc = gl_get_uniform_location(shaderProgram, "transform");
gl_uniform_mat4fv(transformLoc, 1, GMGL_FALSE, buffer_get_address(transformMatrixBuffer));


// Bind the VAO that you want to render
gl_bind_vertex_array(vao);

// Draw vao vertices with element buffer
gl_draw_elements(GL_TRIANGLES, 6);

// Swaps buffers and polls events
glfw_update();