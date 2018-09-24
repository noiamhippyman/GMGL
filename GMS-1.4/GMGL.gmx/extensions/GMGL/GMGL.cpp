dllx double RegisterCallbacks(char* arg1, char* arg2, char* arg3, char* arg4) { ... }

dllx double gmgl_is_active() { ... }

dllx double gmgl_load_image(const char* path) { ... }

dllx double gmgl_free_image(double imageIndex) { ... }

dllx double gmgl_get_image_width(double image) { ... }

dllx double gmgl_get_image_height(double image) { ... }

dllx double gmgl_get_image_channel_num(double image) { ... }

dllx double glfw_init() { ... }

dllx double glfw_update() { ... }

dllx double glfw_terminate() { ... }

dllx double glfw_create_window(double width, double height, const char* title) { ... }

dllx double glfw_default_window_hints() { ... }

dllx double glfw_window_hint(double hint, double value) { ... }

dllx double glfw_set_window_title(char* title) { ... }

dllx double glfw_set_window_icon(const char* path) { ... }

dllx double glfw_get_window_x() { ... }

dllx double glfw_get_window_y() { ... }

dllx double glfw_set_window_pos(double x, double y) { ... }

dllx double glfw_get_window_width() { ... }

dllx double glfw_get_window_height() { ... }

dllx double glfw_set_window_size_limits(double minwidth, double minheight, double maxwidth, double maxheight) { ... }

dllx double glfw_set_window_aspect_ratio(double numer, double denom) { ... }

dllx double glfw_set_window_size(double width, double height) { ... }

dllx double glfw_get_framebuffer_width() { ... }

dllx double glfw_get_framebuffer_height() { ... }

dllx double glfw_iconify_window() { ... }

dllx double glfw_restore_window() { ... }

dllx double glfw_maximize_window() { ... }

dllx double glfw_show_window() { ... }

dllx double glfw_hide_window() { ... }

dllx double glfw_focus_window() { ... }

dllx double glfw_get_window_attrib(double attrib) { ... }

dllx double glfw_poll_events() { ... }

dllx double glfw_wait_events() { ... }

dllx double glfw_wait_events_timeout(double timeout) { ... }

dllx double glfw_post_empty_event() { ... }

dllx double glfw_swap_buffers() { ... }

dllx double glfw_set_input_mode(double mode, double value) { ... }

dllx double glfw_get_input_mode(double mode) { ... }

dllx const char* glfw_get_key_name(double key, double scancode) { ... }

dllx double glfw_get_key(double key) { ... }

dllx double glfw_get_mouse_button(double button) { ... }

dllx double glfw_get_mouse_x() { ... }

dllx double glfw_get_mouse_y() { ... }

dllx double glfw_set_mouse_pos(double x, double y) { ... }

dllx double glfw_set_clipboard_string(const char* string) { ... }

dllx const char* glfw_get_clipboard_string() { ... }

dllx double glfw_get_time() { ... }

dllx double glfw_set_time(double time) { ... }

dllx double gl_viewport(double x, double y, double width, double height) { ... }

dllx double gl_enable(double cap) { ... }

dllx double gl_disable(double cap) { ... }

dllx double gl_depth_mask(double flag) { ... }

dllx double gl_depth_func(double func) { ... }

dllx double gl_stencil_mask(double mask) { ... }

dllx double gl_stencil_func(double func, double ref, double mask) { ... }

dllx double gl_stencil_op(double fail, double zfail, double zpass) { ... }

dllx double gl_blend_func(double sfactor, double dfactor) { ... }

dllx double gl_blend_func_separate(double sfactorRGB, double dfactorRGB, double sfactorAlpha, double dfactorAlpha) { ... }

dllx double gl_blend_equation(double mode) { ... }

dllx double gl_cull_face(double mode) { ... }

dllx double gl_front_face(double mode) { ... }

dllx double gl_clear_color(double r, double g, double b, double a) { ... }

dllx double gl_clear(double mask) { ... }

dllx double gl_draw_arrays(double mode, double first, double count) { ... }

dllx double gl_draw_elements(double mode, double count) { ... }

dllx double gl_gen_buffer() { ... }

dllx double gl_bind_buffer(double target, double bufferIndex) { ... }

dllx double gl_delete_buffer(double bufferIndex) { ... }

dllx double gl_buffer_data(double target, double size, void* vertices, double usage) { ... }

dllx double gl_gen_vertex_array() { ... }

dllx double gl_bind_vertex_array(double varrayIndex) { ... }

dllx double gl_delete_vertex_array(double varrayIndex) { ... }

dllx double gl_vertex_attrib_pointer(double index, double size, double type, double normalized, double stride, double offset) { ... }

dllx double gl_enable_vertex_attrib_array(double index) { ... }

dllx double gl_gen_texture() { ... }

dllx double gl_bind_texture(double target, double textureIndex) { ... }

dllx double gl_delete_texture(double textureIndex) { ... }

dllx double gl_active_texture(double unit) { ... }

dllx double gl_texImage2D(double target, double level, double internalformat, double border, double format, double type, double imageIndex) { ... }

dllx double gl_generate_mipmap(double target) { ... }

dllx double gl_gen_framebuffer() { ... }

dllx double gl_bind_framebuffer(double target, double framebufferIndex) { ... }

dllx double gl_delete_framebuffer(double framebufferIndex) { ... }

dllx double gl_create_shader(double type, char* source) { ... }

dllx double gl_delete_shader(double shaderIndex) { ... }

dllx double gl_create_program() { ... }

dllx double gl_attach_shader(double programIndex, double shaderIndex) { ... }

dllx double gl_link_program(double programIndex) { ... }

dllx double gl_use_program(double programIndex) { ... }

dllx double gl_get_uniform_location(double programIndex, const char* name) { ... }

dllx double gl_uniform1f(double location, double x) { ... }

dllx double gl_uniform2f(double location, double x, double y) { ... }

dllx double gl_uniform3f(double location, double x, double y, double z) { ... }

dllx double gl_uniform4f(double location, double x, double y, double z, double w) { ... }

dllx double gl_uniform1i(double location, double x) { ... }

dllx double gl_uniform2i(double location, double x, double y) { ... }

dllx double gl_uniform3i(double location, double x, double y, double z) { ... }

dllx double gl_uniform4i(double location, double x, double y, double z, double w) { ... }

dllx double gl_uniform1ui(double location, double x) { ... }

dllx double gl_uniform2ui(double location, double x, double y) { ... }

dllx double gl_uniform3ui(double location, double x, double y, double z) { ... }

dllx double gl_uniform4ui(double location, double x, double y, double z, double w) { ... }

dllx double gl_uniform1fv(double location, double size, void* value) { ... }

dllx double gl_uniform2fv(double location, double size, void* value) { ... }

dllx double gl_uniform3fv(double location, double size, void* value) { ... }

dllx double gl_uniform4fv(double location, double size, void* value) { ... }

dllx double gl_uniform1iv(double location, double size, void* value) { ... }

dllx double gl_uniform2iv(double location, double size, void* value) { ... }

dllx double gl_uniform3iv(double location, double size, void* value) { ... }

dllx double gl_uniform4iv(double location, double size, void* value) { ... }

dllx double gl_uniform1uiv(double location, double size, void* value) { ... }

dllx double gl_uniform2uiv(double location, double size, void* value) { ... }

dllx double gl_uniform3uiv(double location, double size, void* value) { ... }

dllx double gl_uniform4uiv(double location, double size, void* value) { ... }

dllx double gl_uniform_mat2fv(double location, double count, double transpose, void* value) { ... }

dllx double gl_uniform_mat3fv(double location, double count, double transpose, void* value) { ... }

dllx double gl_uniform_mat4fv(double location, double count, double transpose, void* value) { ... }

dllx double gl_uniform_mat2x3fv(double location, double count, double transpose, void* value) { ... }

dllx double gl_uniform_mat3x2fv(double location, double count, double transpose, void* value) { ... }

dllx double gl_uniform_mat2x4fv(double location, double count, double transpose, void* value) { ... }

dllx double gl_uniform_mat4x2fv(double location, double count, double transpose, void* value) { ... }

dllx double gl_uniform_mat3x4fv(double location, double count, double transpose, void* value) { ... }

dllx double gl_uniform_mat4x3fv(double location, double count, double transpose, void* value) { ... }

dllx double gl_tex_parameterf(double target, double pname, double param) { ... }

dllx double gl_tex_parameteri(double target, double pname, double param) { ... }

dllx double gl_texture_parameterf(double textureIndex, double pname, double param) { ... }

dllx double gl_texture_parameteri(double textureIndex, double pname, double param) { ... }

dllx double gl_tex_parameterfv(double target, double pname, void* param) { ... }

dllx double gl_tex_parameteriv(double target, double pname, void* param) { ... }

dllx double gl_texture_parameterfv(double textureIndex, double pname, void* param) { ... }

dllx double gl_texture_parameteriv(double textureIndex, double pname, void* param) { ... }

dllx double gl_tex_parameterIiv(double target, double pname, void* param) { ... }

dllx double gl_tex_parameterIuiv(double target, double pname, void* param) { ... }

dllx double gl_texture_parameterIiv(double textureIndex, double pname, void* param) { ... }

dllx double gl_texture_parameterIuiv(double textureIndex, double pname, void* param) { ... }
