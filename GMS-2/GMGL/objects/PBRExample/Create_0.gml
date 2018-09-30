windowWidth = 800;
windowHeight = 600;

global.gmgl_mouse_pos = [0,0];
camID = instance_create_layer(0,0,"Instances",Camera);

modelMatrixBuffer = buffer_create(16 * buffer_sizeof(buffer_f32), buffer_fixed, 4);
viewMatrixBuffer = buffer_create(16 * buffer_sizeof(buffer_f32), buffer_fixed, 4);

var proj = matrix_build_projection_perspective_fov(camID.fov, windowWidth / windowHeight, camID.near, camID.far);
projMatrixBuffer = buffer_create(16 * buffer_sizeof(buffer_f32), buffer_fixed, 4);
matrix_to_buffer(proj,projMatrixBuffer);

// OpenGL starts here
gmgl_init(3,3, windowWidth,windowHeight, "PBR");

model = gmgl_model_load("GMGL/models/cube.dat");

shader = gmgl_shader_create(shader_pbr_vs(), shader_pbr_fs());
gl_use_program(shader);
gmgl_shader_set_int(shader, "albedoMap", 0);
gmgl_shader_set_int(shader, "normalMap", 1);
gmgl_shader_set_int(shader, "metallicMap", 2);
gmgl_shader_set_int(shader, "roughnessMap", 3);
gmgl_shader_set_int(shader, "aoMap", 4);
gmgl_shader_set_mat4(shader, "projection", projMatrixBuffer);

lampShader = gmgl_shader_create(shader_lamp_vs(), shader_lamp_fs());
gl_use_program(lampShader);
gmgl_shader_set_mat4(lampShader, "projection", projMatrixBuffer);

mat_albedo = gmgl_texture_load("GMGL/textures/MetalTiles03/Diffuse.png");
mat_normal = gmgl_texture_load("GMGL/textures/MetalTiles03/Normal.png");
mat_metallic = gmgl_texture_load("GMGL/textures/MetalTiles03/Metallic.png");
mat_roughness = gmgl_texture_load("GMGL/textures/MetalTiles03/Roughness.png");
mat_ao = gmgl_texture_load("GMGL/textures/MetalTiles03/AO.png");

var spread = 2.5;
lightPositions = [
	[-spread,3,0],
	[spread,3,0],
	[0,3,-spread],
	[0,3,spread]
];
lightColors = [
	kelvin_to_rgb(7500),
	kelvin_to_rgb(2700),
	kelvin_to_rgb(5000),
	kelvin_to_rgb(2700)
];
lightCount = array_length_1d(lightPositions);