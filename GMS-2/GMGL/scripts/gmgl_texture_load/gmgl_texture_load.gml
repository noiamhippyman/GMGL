/// @desc gmgl_texture_load(path);
/// @arg path
var path = argument0;
var texID = gl_gen_texture();

var img = gmgl_load_image(path, true);
if (img == GMGL_FAIL) {
	show_error("Failed to load image: " + string(path),false);
	return GMGL_FAIL;
}

var width = gmgl_get_image_width(img);
var height = gmgl_get_image_height(img);
var channelNums = gmgl_get_image_channel_num(img);
var format;
switch (channelNums) {
	case 1: format = GL_RED; break;
	case 3: format = GL_RGB; break;
	case 4: format = GL_RGBA; break;
}

gl_bind_texture(GL_TEXTURE_2D,texID);
gl_tex_image2D(GL_TEXTURE_2D,0,format,gmgl_get_image_width(img), gmgl_get_image_height(img),0,format,GL_UNSIGNED_BYTE,img);
gl_generate_mipmap(GL_TEXTURE_2D);

gl_tex_parameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_REPEAT);
gl_tex_parameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_REPEAT);
gl_tex_parameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR_MIPMAP_LINEAR);
gl_tex_parameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);

gmgl_free_image(img);

return texID;