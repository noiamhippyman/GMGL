return @"#version 330 core
out vec4 FragColor;

in vec4 vertexColor;
in vec2 uv;

uniform sampler2D texture1;
uniform sampler2D texture2;

void main() {
	FragColor = vertexColor * mix(texture(texture1, uv), texture(texture2, uv), 0.2);
}";