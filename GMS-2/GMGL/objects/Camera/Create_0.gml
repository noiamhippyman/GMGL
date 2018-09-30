// Let's make a camera to control with some user input
position = [0,0,-3];//x, y, z
rotation = [90,0,0];//yaw, pitch, roll
front = vector_normalize([
	dcos(rotation[0]) * dcos(rotation[1]),
	dsin(rotation[1]),
	dsin(rotation[0]) * dcos(rotation[1])
]);
up = [0,1,0];
movespeed = 2.5;
lastX = 400;
lastY = 300;
firstMouse = true;
fov = 45;
near = 0.1;
far = 100;