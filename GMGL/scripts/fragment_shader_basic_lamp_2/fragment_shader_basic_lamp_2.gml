return @"#version 330 core

out vec4 FragColor;

uniform vec3 LightColor;

void main() {	
	FragColor = vec4(LightColor, 1.0);
}";