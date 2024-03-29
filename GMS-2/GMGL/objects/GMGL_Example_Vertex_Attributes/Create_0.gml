/*
	Disabling the draw event basically turns off the GM window
	If you don't run this you'll have two windows open
*/
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
gmgl_create_window_centered(800,600,"Example - Vertex Attributes");
glfw_set_window_icon("GMGL/gmglicon.png");

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
var vertShader = gl_create_shader(GL_VERTEX_SHADER,shader_example_attrib_vs());
var fragShader = gl_create_shader(GL_FRAGMENT_SHADER,shader_example_attrib_fs());

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
	// First thing we need to do is add more attibutes to the vertex data
	// Since we already had a position, we'll add a color as well for each vertex
	//position			//color
	 0.5,  0.5, 0.0,	1.0, 0.0, 0.0,
	 0.5, -0.5, 0.0,	0.0, 1.0, 0.0,
	-0.5, -0.5, 0.0,	0.0, 0.0, 1.0,
	-0.5,  0.5, 0.0, 	1.0, 1.0, 0.0
];

// Create indices for each triangle
var indices = [
	0,1,3,//first triangle
	1,2,3 //second triangle
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

var icount = array_length_1d(indices);
ibuff = buffer_create(icount*buffer_sizeof(buffer_u32),buffer_fixed,4);
for (var i = 0; i < icount; ++i) {
	buffer_write(ibuff,buffer_u32,indices[i]);
}


/*
	Generate vertex array, vertex buffer object and element buffer object
	
	A vertex array object (VAO) is basically nothing more than a box.
	In this box you store it's vertex data, vertex attributes,
	vertex indices, etc.
	
	A vertex buffer object (VBO) is the actual vertex data.
	Each vertex could be just a position or position, color and texture coordinates, etc.
	
	An element buffer object (EBO) is an array of indices that point to which vertex to use in the VBO.
*/
vao = gl_gen_vertex_array();
vbo = gl_gen_buffer();
ebo = gl_gen_buffer();

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

/*
	Next you need to do the same thing with the ebo as you did with the vbo
	except instead of the array buffer you need to bind it to the element array buffer
*/
gl_bind_buffer(GL_ELEMENT_ARRAY_BUFFER, ebo);
gl_buffer_data(GL_ELEMENT_ARRAY_BUFFER, buffer_get_size(ibuff), buffer_get_address(ibuff), GL_STATIC_DRAW);

/*
	Next we need to setup this vertex array's vertex attributes
	You've already seen this in the last three examples but lets add 
	another attribute to see how each argument works
*/
gl_vertex_attrib_pointer(0,3,GL_FLOAT,GMGL_FALSE,6 * buffer_sizeof(buffer_f32),0);

// Don't forget to enable the attribute also
gl_enable_vertex_attrib_array(0);

/*
	Here we will setup the color vertex attribute
	
	gl_vertex_attrib_pointer(index, size, type, normalized?, stride, offset);
	
	"index" is the index in the vertex attribute array. Remember in the 
	previous vertex shaders the layout location line?
	layout (location = 0) in vec3 aPos; <--- The location is the index
	
	
	"size" is the number of values used for this attribute
	In the case of the position it's 3 since the position 
	is a 3D vector.	If you were adding UV coordinates, the 
	attribute size would be 2, since UVs are only 2D vectors.
	
	
	"type" at the moment will only accept GL_FLOAT, GL_INT and
	GL_UNSIGNED_INT. If you put anything else it will just default
	to GL_FLOAT.
	
	
	"normalized?" is asking whether or not the values stored
	should be mapped to -1,1 if signed and 0,1 if unsigned.
	
	
	"stride" is the sum of all the attribute sizes. So if you're
	only using position coordinates the stride is 3.
	Since this has two 3D vectors (position,color) the stride is 6.
	If you have position, color and UV coordinates the stride is 8.
	
	
	"offset" is the the starting index of this attribute. You can get the offset
	by adding the last attributes offset + size.
	
	var vertices = [
		 |-position:index 0 |-color:index 1
		 |---size 3---|     |---size 3---|
		 |------------stride 6-----------|	 
		 |<--offset 0       |<--offset 3
		 0.5,  0.5, 0.0,	1.0, 0.0, 0.0,
		 0.5, -0.5, 0.0,	0.0, 1.0, 0.0,
		-0.5, -0.5, 0.0,	0.0, 0.0, 1.0,
		-0.5,  0.5, 0.0 	1.0, 1.0, 0.0,
	];


	So after reading all that it should be clear how this next call works.
	Color is the second attribute so it's index will be 1.
	It is a 3D vector so it's size is 3.
	The variables are floats so GL_FLOAT is the type
	Since they're already values between 0-1 there is no need to normalize so GMGL_FALSE
	The stride of each vertex is the position size + color size (3d vector + 3d vector) which equals 6
	Since it's the second attribute and the first attribute's size is 3 and it's offset is 0 so the offset is 3.
	Hopefully that clears up how setting vertex attributes works.
	Check out shader_example_attrib_vs/shader_example_attrib_fs if you want to see how to use the attributes
*/
gl_vertex_attrib_pointer(1,3,GL_FLOAT,GMGL_FALSE,6 * buffer_sizeof(buffer_f32),3 * buffer_sizeof(buffer_f32));
gl_enable_vertex_attrib_array(1);

/* 
	That all! Your quad is all setup. It's not a requirement but it's good practice
	to unbind your vertex array so you don't accidentally change something down the line
	and cause a hard to find bug.
*/
gl_bind_vertex_array(0);