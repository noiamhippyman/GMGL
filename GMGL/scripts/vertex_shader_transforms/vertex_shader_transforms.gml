return @"#version 330 core
layout (location = 0) in vec3 aPos;
layout (location = 1) in vec3 aCol;
layout (location = 2) in vec2 aUV;
out vec4 vertexColor;
out vec2 uv;

uniform mat4 transform;

void main() {
	gl_Position = transform * vec4(aPos, 1.0);
	vertexColor = vec4(aCol, 1.0);
	uv = aUV;
}";