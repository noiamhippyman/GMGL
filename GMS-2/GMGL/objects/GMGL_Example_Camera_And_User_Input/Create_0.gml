/*
	Disabling the draw event basically turns off the GM window
	If you don't run this you'll have two windows open
*/
global.gmgl_mouse_pos = [0,0];
draw_enable_drawevent(false);

// Call this to initialize GLFW
glfw_init();

/*
	Set GL version to use with GLFW window hints
	
	GLFW_CONTEXT_VERSION_MAJOR and GLFW_CONTEXT_VERSION_MINOR 
	are not hard constraints, but creation will fail if the OpenGL 
	version of the created context is less than the one requested. 
	It is therefore perfectly safe to use the default of version 1.0 
	for legacy code and you will still get backwards-compatible 
	contexts of version 3.0 and above when available.
	
	While there is no way to ask the driver for a context of the 
	highest supported version, GLFW will attempt to provide this 
	when you ask for a version 1.0 context, which is the default 
	for these hints.
*/
glfw_window_hint(GLFW_CONTEXT_VERSION_MAJOR, 3);
glfw_window_hint(GLFW_CONTEXT_VERSION_MINOR, 3);

/*
	Set GL profile
	
	GLFW_OPENGL_PROFILE specifies which OpenGL profile to 
	create the context for. Possible values are one of 
	GLFW_OPENGL_CORE_PROFILE or GLFW_OPENGL_COMPAT_PROFILE, 
	or GLFW_OPENGL_ANY_PROFILE to not request a specific profile. 
	
	If requesting an OpenGL version below 3.2, GLFW_OPENGL_ANY_PROFILE 
	must be used.
*/
glfw_window_hint(GLFW_OPENGL_PROFILE, GLFW_OPENGL_CORE_PROFILE);

/*
	Create the actual window
	
	gmgl_create_window_centered is just a script. 
	Open it to see how to create a window and center it with GLFW functions.
*/
gmgl_create_window_centered(800,600,"Example - Camera and User Input ( W-A-S-D to move | Hold LMB to look around )");
glfw_set_window_icon("GMGL/gmglicon.png");

gl_enable(GL_DEPTH_TEST);
/*
	Create shaders
	
	For simplicity I decided to make this function actually do three things behind the scenes
	When doing this with C/C++ you would create the shader, set the source and then compile the shader.
	
	Creating a vertex shader would look like this:
	GLuint shader = glCreateShader(GL_VERTEX_SHADER);
	glShaderSource(shader, 1, &vertexShaderSource, nullptr);
	glCompileShader(shader);
	
	gl_create_shader also does a quick error check to see if the compilation failed.
	That's an extra five or six lines of code. There's already of ton of code to write
	so this is just a nice convenience.
	
	If it fails the function returns GMGL_FAIL otherwise it returns the shader ID.
*/
var vertShader = gl_create_shader(GL_VERTEX_SHADER,shader_example_cube_vs());
var fragShader = gl_create_shader(GL_FRAGMENT_SHADER,shader_example_cube_fs());

/*
	Create shader program
	
	The shaders by themselves are useless. You still need to create a program.
	Then attach any shaders you want to the program and finally link the program.
*/
shaderProgram = gl_create_program();
gl_attach_shader(shaderProgram,vertShader);
gl_attach_shader(shaderProgram,fragShader);
gl_link_program(shaderProgram);

/*
	Delete shaders
	
	After linking a program you don't need the shaders anymore. 
	You can delete them when you don't need them anymore.
*/
gl_delete_shader(vertShader);
gl_delete_shader(fragShader);


// Create three vertices
var vertices = [
	//Positions			//UV
	-0.5, -0.5, -0.5,  0.0, 0.0,
	 0.5, -0.5, -0.5,  1.0, 0.0,
	 0.5,  0.5, -0.5,  1.0, 1.0,
	 0.5,  0.5, -0.5,  1.0, 1.0,
	-0.5,  0.5, -0.5,  0.0, 1.0,
	-0.5, -0.5, -0.5,  0.0, 0.0,

	-0.5, -0.5,  0.5,  0.0, 0.0,
	 0.5, -0.5,  0.5,  1.0, 0.0,
	 0.5,  0.5,  0.5,  1.0, 1.0,
	 0.5,  0.5,  0.5,  1.0, 1.0,
	-0.5,  0.5,  0.5,  0.0, 1.0,
	-0.5, -0.5,  0.5,  0.0, 0.0,

	-0.5,  0.5,  0.5,  1.0, 0.0,
	-0.5,  0.5, -0.5,  1.0, 1.0,
	-0.5, -0.5, -0.5,  0.0, 1.0,
	-0.5, -0.5, -0.5,  0.0, 1.0,
	-0.5, -0.5,  0.5,  0.0, 0.0,
	-0.5,  0.5,  0.5,  1.0, 0.0,

	 0.5,  0.5,  0.5,  1.0, 0.0,
	 0.5,  0.5, -0.5,  1.0, 1.0,
	 0.5, -0.5, -0.5,  0.0, 1.0,
	 0.5, -0.5, -0.5,  0.0, 1.0,
	 0.5, -0.5,  0.5,  0.0, 0.0,
	 0.5,  0.5,  0.5,  1.0, 0.0,

	-0.5, -0.5, -0.5,  0.0, 1.0,
	 0.5, -0.5, -0.5,  1.0, 1.0,
	 0.5, -0.5,  0.5,  1.0, 0.0,
	 0.5, -0.5,  0.5,  1.0, 0.0,
	-0.5, -0.5,  0.5,  0.0, 0.0,
	-0.5, -0.5, -0.5,  0.0, 1.0,

	-0.5,  0.5, -0.5,  0.0, 1.0,
	 0.5,  0.5, -0.5,  1.0, 1.0,
	 0.5,  0.5,  0.5,  1.0, 0.0,
	 0.5,  0.5,  0.5,  1.0, 0.0,
	-0.5,  0.5,  0.5,  0.0, 0.0,
	-0.5,  0.5, -0.5,  0.0, 1.0
];

/*
	Store vertices and indices into their own gamemaker buffers
	
	The reason we have to do this is because you can't pass an array 
	to an extension. But you can get the address of a buffer with 
	buffer_get_address which can then be passed to and read by the extension.
*/
var vcount = array_length_1d(vertices);
vbuff = buffer_create(vcount*buffer_sizeof(buffer_f32),buffer_fixed,4);
for (var i = 0; i < vcount; ++i) {
	buffer_write(vbuff,buffer_f32,vertices[i]);
}


/*
	Generate vertex array, vertex buffer object and element buffer object
	
	A vertex array object (VAO) is basically nothing more than a box.
	In this box you store it's vertex data, vertex attributes,
	vertex indices, etc.
	
	A vertex buffer object (VBO) is the actual vertex data.
	Each vertex could be just a position or position, color and texture coordinates, etc.
*/
vao = gl_gen_vertex_array();
vbo = gl_gen_buffer();

/*
	First you need to bind the vertex array so OpenGL knows which one you're modifying/using.
	Now when you bind buffers or setup vertex attribute pointers, it will do it for this vao.
*/
gl_bind_vertex_array(vao);

// Next you need to bind the vbo to this vao's array buffer
gl_bind_buffer(GL_ARRAY_BUFFER, vbo);

/*
	Now you need to actually put your vertex data into the array buffer
	Don't forget about the buffer we stored the vertex data into. 
	This is where you use buffer_get_address
*/
gl_buffer_data(GL_ARRAY_BUFFER, buffer_get_size(vbuff), buffer_get_address(vbuff), GL_STATIC_DRAW);

// Next we need to setup this vertex array's vertex attributes
gl_vertex_attrib_pointer(0,3,GL_FLOAT,GMGL_FALSE,5,0);

// Don't forget to enable the attribute also
gl_enable_vertex_attrib_array(0);

//UV attribute
gl_vertex_attrib_pointer(1,2,GL_FLOAT,GMGL_FALSE,5,3);
gl_enable_vertex_attrib_array(1);

/*
	You're done with the quad but now you need to load in your texture(s)
	First generate and bind a texture similarly to how we did with the vao, vbo and ebo
*/
texture1 = gl_gen_texture();
gl_bind_texture(GL_TEXTURE_2D,texture1);

/*
	Texture Wrapping
	GL_TEXTURE_WRAP_S/GL_TEXTURE_WRAP_T are the wrap
	modes for the S and T axis. Why is it S and T axis? ¯\_(ツ)_/¯
	
	Texture coordinates usually range from (0,0) to (1,1) but what happens if we 
	specify coordinates outside this range? The default behavior of OpenGL is to 
	repeat the texture images (we basically ignore the integer part of the floating 
	point texture coordinate), but there are more options OpenGL offers:

	GL_REPEAT: The default behavior for textures. Repeats the texture image.
	
	GL_MIRRORED_REPEAT: Same as GL_REPEAT but mirrors the image with each repeat.
	
	GL_CLAMP_TO_EDGE: Clamps the coordinates between 0 and 1. The result is that 
	higher coordinates become clamped to the edge, resulting in a stretched edge pattern.
	
	GL_CLAMP_TO_BORDER: Coordinates outside the range are now given a user-specified border color.
*/
gl_tex_parameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_REPEAT);
gl_tex_parameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_REPEAT);

/*
	Texture filtering can be set for magnifying and minifying operations (when scaling up or downwards) 
	so you could for example use nearest neighbor filtering when textures are scaled downwards and linear 
	filtering for upscaled textures. We thus have to specify the filtering method for both options via 
	glTexParameter*. The code should look similar to setting the wrapping method:
*/
gl_tex_parameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR_MIPMAP_LINEAR);
gl_tex_parameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);

//Next we need to load the image data into memory
var img = gmgl_load_image("GMGL/container.jpg");

/*
	Now that we finally have a bound texture and some image data
	we can copy the image data into the bound texture
*/
gl_tex_image2D(GL_TEXTURE_2D, 0, GL_RGB, gmgl_get_image_width(img), gmgl_get_image_height(img),  0, GL_RGB, GL_UNSIGNED_BYTE, img);

/*
	If you want to use mipmaps you need to generate those as well
*/
gl_generate_mipmap(GL_TEXTURE_2D);

// Now that the image is loaded into a texture you no longer need it so free it from memory
gmgl_free_image(img);

/*
	I know that seems like a whole bunch of things but it's not that bad with no comments.
	Here is the second texture setup in 10 lines
*/
texture2 = gl_gen_texture();
gl_bind_texture(GL_TEXTURE_2D, texture2);
gl_tex_parameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_REPEAT);
gl_tex_parameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_REPEAT);
gl_tex_parameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR_MIPMAP_LINEAR);
gl_tex_parameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
img = gmgl_load_image("GMGL/awesomeface.png");
gl_tex_image2D(GL_TEXTURE_2D, 0, GL_RGB, gmgl_get_image_width(img), gmgl_get_image_height(img),  0, GL_RGBA, GL_UNSIGNED_BYTE, img);
gl_generate_mipmap(GL_TEXTURE_2D);
gmgl_free_image(img);



/* 
	That all! Your quad is all setup with textures. It's not a requirement but it's good practice
	to unbind your vertex array so you don't accidentally change something down the line
	and cause a hard to find bug.
*/
gl_bind_vertex_array(0);

/*
	Tell opengl what texture unit belongs to which sampler index
*/
gl_use_program(shaderProgram);
gl_uniform1i(gl_get_uniform_location(shaderProgram, "texture1"), 0);
gl_uniform1i(gl_get_uniform_location(shaderProgram, "texture2"), 1);


/*
	I'm not going to get into the details of this since it doesn't really pertain
	to OpenGL as much as it does to just 3D graphics in general.
	
	Check out this link for a very in depth tutorial
	https://learnopengl.com/Getting-started/Coordinate-Systems
	
	Follow along with that and things should make sense here.
*/
modelMatrixBuffer = buffer_create(16*buffer_sizeof(buffer_f32),buffer_fixed,4);
viewMatrixBuffer = buffer_create(16*buffer_sizeof(buffer_f32),buffer_fixed,4);
projMatrixBuffer = buffer_create(16*buffer_sizeof(buffer_f32),buffer_fixed,4);

// Let's make a camera to control with some user input
cameraPos = [0,0,-3];//x, y, z
cameraRot = [90,0,0];//yaw, pitch, roll
cameraFront = vector_normalize([
	dcos(cameraRot[0]) * dcos(cameraRot[1]),
	dsin(cameraRot[1]),
	dsin(cameraRot[0]) * dcos(cameraRot[1])
]);
cameraUp = [0,1,0];
cameraSpeed = 2.5;
cameraLastX = 400;
cameraLastY = 300;
cameraFirstMouse = true;
cameraFOV = 45;
