/// @desc shader_example_textures_vs();
return @"
#version 330 core
layout (location = 0) in vec3 aPos;
layout (location = 1) in vec3 aColor;
layout (location = 2) in vec2 aUV;

out vec3 Color;
out vec2 UV;

uniform mat4 transform;

void main() {
	gl_Position = transform * vec4(aPos,1.0);
	Color = aColor;
	UV = aUV;
}";