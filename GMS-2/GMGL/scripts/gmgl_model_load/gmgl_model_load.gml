/// @desc gmgl_model_load(path);
/// @arg path
var path = argument0;
if (!file_exists(path)) {
	show_debug_message("FAILED TO LOAD MODEL");
	return noone;
}

var stride = 8 * buffer_sizeof(buffer_f32);
var offset = 0;
var model = buffer_load(path);
var modelVertCount = floor(buffer_get_size(model) /  stride);
var modelVAO = gl_gen_vertex_array();
var modelVBO = gl_gen_buffer();
gl_bind_vertex_array(modelVAO);
gl_bind_buffer(GL_ARRAY_BUFFER, modelVBO);
gl_buffer_data(GL_ARRAY_BUFFER, buffer_get_size(model), buffer_get_address(model),GL_STATIC_DRAW);

buffer_delete(model);

gl_enable_vertex_attrib_array(0);//position
gl_vertex_attrib_pointer(0, 3, GL_FLOAT, GL_FALSE, stride, offset);

offset += 3 * buffer_sizeof(buffer_f32);

gl_enable_vertex_attrib_array(1);//normal
gl_vertex_attrib_pointer(1, 3, GL_FLOAT, GL_FALSE, stride, offset);

offset += 3 * buffer_sizeof(buffer_f32);

gl_enable_vertex_attrib_array(2);//uv
gl_vertex_attrib_pointer(2, 2, GL_FLOAT, GL_FALSE, stride, offset);

return [modelVAO,modelVBO,modelVertCount];