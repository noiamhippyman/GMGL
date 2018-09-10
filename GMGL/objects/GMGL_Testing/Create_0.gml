//Run timer to check if gmgl is still active and shutdown process if it's dead
gmgl_downtime_timer = 1000;//check once every minute
alarm_set(0,game_get_speed(gamespeed_fps) * gmgl_downtime_timer);

//Disable draw event to also disable GM Window
//if you don't do this there will be two windows
draw_enable_drawevent(false);

//Initialize with whatever version of OpenGL you want
gmgl_init(3,3);

//Create your window
gmgl_create_window(800,600,"GMGL");

#region Shaders

//Put shader source code into a string.
//It's just hard-coded for example
//You could also load a text file into a string
var vertexShaderSource = @"#version 330 core
layout (location = 0) in vec3 aPos;

void main() {
	gl_Position = vec4(aPos,1.0);
}";

var fragmentShaderSource = @"#version 330 core
out vec4 FragColor;
void main() {
	FragColor = vec4(1.0,0.5,0.2,1.0);
}";

//gmgl_shader_create creates the actual 
//shader program that you'll use for drawing things
shader = gmgl_shader_create();

//gmgl_shader_attach creates and compiles a shader of type given
//then attaches the created shader to the given shader program
gmgl_shader_attach(shader,GMGL_VERTEX_SHADER,vertexShaderSource);
gmgl_shader_attach(shader,GMGL_FRAGMENT_SHADER,fragmentShaderSource);

//Finally you need to call gmgl_shader_link to finally
//link up the shaders with their respective processors
gmgl_shader_link(shader);
#endregion

#region Vertices,VAO,VBO

//Create a vertex buffer
var vertices = [
	-0.5, -0.5, 0.0, // left  
	 0.5, -0.5, 0.0, // right 
	 0.0,  0.5, 0.0  // top   
];
var vbuff = buffer_create(9 * buffer_sizeof(buffer_f32),buffer_fixed,4);
for (var i = 0; i < 9; ++i) buffer_write(vbuff,buffer_f32,vertices[i]);

vao = gmgl_vao_create();
vbo = gmgl_vbo_create();

gmgl_vao_bind(vao);
gmgl_vbo_bind(GMGL_ARRAY_BUFFER,vbo);
gmgl_vbo_data(GMGL_ARRAY_BUFFER,buffer_get_address(vbuff),buffer_get_size(vbuff),GMGL_STATIC_DRAW);

//Setup vertex attributes used by shaders
gmgl_vertex_attrib_pointer(0,3,GMGL_FLOAT,GMGL_FALSE,3 * buffer_sizeof(buffer_f32),0);
gmgl_enable_vertex_attrib_array(0);
#endregion