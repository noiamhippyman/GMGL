/// @desc gmgl_load_texture(path);
/// @arg path
var path = argument0;
var texID = gl_gen_texture();

var img = gmgl_load_image(path);
if (img == GMGL_FAIL) {
	show_error("Failed to loaded image: " + string(path),false);
	return GMGL_FAIL;
}

var width = gmgl_get_image_width(img);
var height = gmgl_get_image_height(img);
var channelNums = gmgl_get_image_channel_num(img);
var format = GL_RGB;
if (channelNums == 4) format = GL_RGBA;

gl_bind_texture(GL_TEXTURE_2D,texID);
gl_texImage2D(GL_TEXTURE_2D,0,format,0,format,GL_UNSIGNED_BYTE,img);
gl_generate_mipmap(GL_TEXTURE_2D);

gl_tex_parameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_REPEAT);
gl_tex_parameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_REPEAT);
gl_tex_parameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR_MIPMAP_LINEAR);
gl_tex_parameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);

gmgl_free_image(img);

return texID;