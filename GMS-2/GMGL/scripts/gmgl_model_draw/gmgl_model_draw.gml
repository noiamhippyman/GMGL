/// @desc gmgl_model_draw(model);
/// @arg model
var model = argument0;
gl_bind_vertex_array(model[@0]);
gl_draw_arrays(GL_TRIANGLES, 0, model[@2]);