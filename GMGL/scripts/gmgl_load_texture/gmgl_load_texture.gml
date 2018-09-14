/// @desc gmgl_load_texture(path);
/// @arg path
var path = argument0;
var texID = gmgl_gen_texture();

var img = gmgl_load_image(path);
if (img == GMGL_FAIL) {
	show_error("Failed to loaded image: " + string(path),false);
	exit;
}

var width = gmgl_get_image_width(img);
var height = gmgl_get_image_height(img);
var channelNums = gmgl_get_image_channel_num(img);
var format = GMGL_RGB;
if (channelNums == 4) format = GMGL_RGBA;

gmgl_bind_texture(GMGL_TEXTURE_2D,texID);
gmgl_texImage2D(GMGL_TEXTURE_2D,0,format,0,format,img);
gmgl_generate_mipmap(GMGL_TEXTURE_2D);

gmgl_tex_parameteri(GMGL_TEXTURE_2D, GMGL_TEXTURE_WRAP_S, GMGL_REPEAT);
gmgl_tex_parameteri(GMGL_TEXTURE_2D, GMGL_TEXTURE_WRAP_T, GMGL_REPEAT);
gmgl_tex_parameteri(GMGL_TEXTURE_2D, GMGL_TEXTURE_MIN_FILTER, GMGL_LINEAR_MIPMAP_LINEAR);
gmgl_tex_parameteri(GMGL_TEXTURE_2D, GMGL_TEXTURE_MAG_FILTER, GMGL_LINEAR);

gmgl_free_image(img);

return texID;


/*
unsigned int loadTexture(char const * path)
{
    unsigned int textureID;
    glGenTextures(1, &textureID);

    int width, height, nrComponents;
    unsigned char *data = stbi_load(path, &width, &height, &nrComponents, 0);
    if (data)
    {
        GLenum format;
        if (nrComponents == 1)
            format = GL_RED;
        else if (nrComponents == 3)
            format = GL_RGB;
        else if (nrComponents == 4)
            format = GL_RGBA;

        glBindTexture(GL_TEXTURE_2D, textureID);
        glTexImage2D(GL_TEXTURE_2D, 0, format, width, height, 0, format, GL_UNSIGNED_BYTE, data);
        glGenerateMipmap(GL_TEXTURE_2D);

        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_REPEAT);
        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_REPEAT);
        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR_MIPMAP_LINEAR);
        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);

        stbi_image_free(data);
    }
    else
    {
        std::cout << "Texture failed to load at path: " << path << std::endl;
        stbi_image_free(data);
    }

    return textureID;
}
*/