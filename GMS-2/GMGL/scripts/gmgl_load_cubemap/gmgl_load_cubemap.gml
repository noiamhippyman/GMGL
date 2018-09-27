/// @desc gmgl_load_cubemap(pathsArray);
/// @arg pathsArray
var paths = argument0;
var count = array_length_1d(paths);

var texture = gl_gen_texture();
gl_bind_texture(GL_TEXTURE_CUBE_MAP, texture);

for (var i = 0; i < count; ++i) {
	var img = gmgl_load_image(paths[i], false);
	if (img == GMGL_FAIL) {
		show_debug_message("Cubemap texture failed to load file: " + paths[i]);
	} else {
		var width = gmgl_get_image_width(img);
		var height = gmgl_get_image_height(img);
		gl_tex_image2D(GL_TEXTURE_CUBE_MAP_POSITIVE_X + i, 0, GL_RGB, width, height, 0, GL_RGB, GL_UNSIGNED_BYTE, img);
		gmgl_free_image(img);
	}
}

gl_tex_parameteri(GL_TEXTURE_CUBE_MAP, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
gl_tex_parameteri(GL_TEXTURE_CUBE_MAP, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
gl_tex_parameteri(GL_TEXTURE_CUBE_MAP, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE);
gl_tex_parameteri(GL_TEXTURE_CUBE_MAP, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE);
gl_tex_parameteri(GL_TEXTURE_CUBE_MAP, GL_TEXTURE_WRAP_R, GL_CLAMP_TO_EDGE);

return texture;