return "
#version 330 core

in vec3 Color;
in vec2 UV;
out vec4 FragColor;

uniform sampler2D texture1;
uniform sampler2D texture2;

void main() {
	FragColor = vec4(Color,1.0) * mix(texture(texture1,UV), texture(texture2,UV), 0.2);
}";
