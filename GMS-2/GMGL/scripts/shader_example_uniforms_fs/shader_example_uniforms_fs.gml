/// @desc shader_example_uniforms_fs();
return @"
#version 330 core

uniform vec3 Color;
out vec4 FragColor;

void main() {
	FragColor = vec4(Color, 1.0);
}";