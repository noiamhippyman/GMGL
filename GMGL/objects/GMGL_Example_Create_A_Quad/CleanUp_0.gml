//This function shuts down GMGL
glfw_terminate();

//Cleanup gamemaker buffers
buffer_delete(vbuff);
buffer_delete(ibuff);