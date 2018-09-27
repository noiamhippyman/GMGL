# GMGL
## GLFW wrapper for Gamemaker Studio

---

This is an extension for Gamemaker Studio that wraps GLFW and OpenGL functions.

GMS only uses OpenGL ES 2.0 while this will allow you to use any version.

I plan on adding every function but at the moment this only has the functions necessary to follow along with the tutorials found at [learnopengl.com](learnopengl.com).

This extension is W.I.P. so I don't recommend using this for anything serious. But it's fun to mess around with and I could really use some more experienced OpenGL programmers who can point out the more important functions. Otherwise it's just a matter of me learning about something I need and implmenting it.

Also if you're familiar with C++ you can check out the source code. It's pretty simple to follow the same pattern I've been going with when wrapping functions.

---

![alt text](https://i.imgur.com/50QnrND.gif,"")

### Currently Implemented Functions
```
real        gmgl_is_active() 
real        gmgl_load_image(string path, real flipOnLoad) 
void        gmgl_free_image(real imageIndex) 
real        gmgl_get_image_width(real image) 
real        gmgl_get_image_height(real image) 
real        gmgl_get_image_channel_num(real image)

real        glfw_init() 
void        glfw_update() 
void        glfw_terminate() 
real        glfw_create_window(real width, real height, string title) 
void        glfw_default_window_hints() 
void        glfw_window_hint(real hint, real value) 
void        glfw_set_window_title(string title) 
void        glfw_set_window_icon(string path) 
real        glfw_get_window_x() 
real        glfw_get_window_y() 
void        glfw_set_window_pos(real x, real y) 
real        glfw_get_window_width() 
real        glfw_get_window_height() 
void        glfw_set_window_size_limits(real minwidth, real minheight, real maxwidth, real maxheight) 
void        glfw_set_window_aspect_ratio(real numer, real denom) 
void        glfw_set_window_size(real width, real height) 
real        glfw_get_framebuffer_width() 
real        glfw_get_framebuffer_height() 
void        glfw_iconify_window() 
void        glfw_restore_window() 
void        glfw_maximize_window() 
void        glfw_show_window() 
void        glfw_hide_window() 
void        glfw_focus_window() 
real        glfw_get_window_attrib(real attrib) 
void        glfw_poll_events() 
void        glfw_wait_events() 
void        glfw_wait_events_timeout(real timeout) 
void        glfw_post_empty_event() 
void        glfw_swap_buffers() 
void        glfw_set_input_mode(real mode, real value) 
real        glfw_get_input_mode(real mode) 
string      glfw_get_key_name(real key, real scancode) 
real        glfw_get_key(real key) 
real        glfw_get_mouse_button(real button) 
real        glfw_get_mouse_x() 
real        glfw_get_mouse_y() 
void        glfw_set_mouse_pos(real x, real y) 
void        glfw_set_clipboard_string(string string) 
string      glfw_get_clipboard_string() 
real        glfw_get_time() 
void        glfw_set_time(real time) 

void        gl_viewport(real x, real y, real width, real height) 
void        gl_enable(real cap) 
void        gl_disable(real cap) 
void        gl_polygon_mode(real face, real mode) 
void        gl_depth_mask(real flag) 
void        gl_depth_func(real func) 
void        gl_stencil_mask(real mask) 
void        gl_stencil_func(real func, real ref, real mask) 
void        gl_stencil_op(real fail, real zfail, real zpass) 
void        gl_blend_func(real sfactor, real dfactor) 
void        gl_blend_func_separate(real sfactorRGB, real dfactorRGB, real sfactorAlpha, real dfactorAlpha) 
void        gl_blend_equation(real mode) 
void        gl_cull_face(real mode) 
void        gl_front_face(real mode) 
void        gl_clear_color(real r, real        g, real b, real a) 
void        gl_clear(real mask) 
void        gl_draw_arrays(real mode, real first, real count) 
void        gl_draw_elements(real mode, real count) 
real        gl_gen_buffer() 
void        gl_bind_buffer(real target, real bufferIndex) 
void        gl_delete_buffer(real bufferIndex) 
void        gl_buffer_data(real target, real size, void* vertices, real usage) 
real        gl_gen_vertex_array() 
void        gl_bind_vertex_array(real varrayIndex) 
void        gl_delete_vertex_array(real varrayIndex) 
void        gl_vertex_attrib_pointer(real index, real size, real type, real normalized, real stride, real offset) 
void        gl_enable_vertex_attrib_array(real index) 
real        gl_gen_texture() 
void        gl_bind_texture(real target, real textureIndex) 
void        gl_delete_texture(real textureIndex) 
void        gl_active_texture(real unit) 
void        gl_tex_image2D(real target, real level, real internalformat, real width, real height, real border, real format, real type, real imageIndex) 
void        gl_generate_mipmap(real target) 
real        gl_gen_framebuffer() 
void        gl_bind_framebuffer(real target, real framebufferIndex) 
void        gl_delete_framebuffer(real framebufferIndex) 
void        gl_framebuffer_texture2D(real target, real attachment, real textarget, real textureIndex, real level) 
real        gl_gen_renderbuffer() 
void        gl_bind_renderbuffer(real target, real renderbufferIndex) 
void        gl_renderbuffer_storage(real target, real internalFormat, real width, real height) 
void        gl_framebuffer_renderbuffer(real target, real attachment, real renderbufferTarget, real renderbufferIndex) 
real        gl_check_framebuffer_status(real target) 
real        gl_create_shader(real type, string source) 
void        gl_delete_shader(real shaderIndex) 
real        gl_create_program() 
void        gl_attach_shader(real programIndex, real shaderIndex) 
void        gl_link_program(real programIndex) 
void        gl_use_program(real programIndex) 
real        gl_get_uniform_location(real programIndex, string name) 
void        gl_uniform1f(real location, real x) 
void        gl_uniform2f(real location, real x, real y) 
void        gl_uniform3f(real location, real x, real y, real z) 
void        gl_uniform4f(real location, real x, real y, real z, real w) 
void        gl_uniform1i(real location, real x) 
void        gl_uniform2i(real location, real x, real y) 
void        gl_uniform3i(real location, real x, real y, real z) 
void        gl_uniform4i(real location, real x, real y, real z, real w) 
void        gl_uniform1ui(real location, real x) 
void        gl_uniform2ui(real location, real x, real y) 
void        gl_uniform3ui(real location, real x, real y, real z) 
void        gl_uniform4ui(real location, real x, real y, real z, real w) 
void        gl_uniform1fv(real location, real size, void* value) 
void        gl_uniform2fv(real location, real size, void* value) 
void        gl_uniform3fv(real location, real size, void* value) 
void        gl_uniform4fv(real location, real size, void* value) 
void        gl_uniform1iv(real location, real size, void* value) 
void        gl_uniform2iv(real location, real size, void* value) 
void        gl_uniform3iv(real location, real size, void* value) 
void        gl_uniform4iv(real location, real size, void* value) 
void        gl_uniform1uiv(real location, real size, void* value) 
void        gl_uniform2uiv(real location, real size, void* value) 
void        gl_uniform3uiv(real location, real size, void* value) 
void        gl_uniform4uiv(real location, real size, void* value) 
void        gl_uniform_mat2fv(real location, real count, real transpose, void* value) 
void        gl_uniform_mat3fv(real location, real count, real transpose, void* value) 
void        gl_uniform_mat4fv(real location, real count, real transpose, void* value) 
void        gl_uniform_mat2x3fv(real location, real count, real transpose, void* value) 
void        gl_uniform_mat3x2fv(real location, real count, real transpose, void* value) 
void        gl_uniform_mat2x4fv(real location, real count, real transpose, void* value) 
void        gl_uniform_mat4x2fv(real location, real count, real transpose, void* value) 
void        gl_uniform_mat3x4fv(real location, real count, real transpose, void* value) 
void        gl_uniform_mat4x3fv(real location, real count, real transpose, void* value) 
void        gl_tex_parameterf(real target, real pname, real param) 
void        gl_tex_parameteri(real target, real pname, real param) 
void        gl_texture_parameterf(real textureIndex, real pname, real param) 
void        gl_texture_parameteri(real textureIndex, real pname, real param) 
void        gl_tex_parameterfv(real target, real pname, void* param) 
void        gl_tex_parameteriv(real target, real pname, void* param) 
void        gl_texture_parameterfv(real textureIndex, real pname, void* param) 
void        gl_texture_parameteriv(real textureIndex, real pname, void* param) 
void        gl_tex_parameterIiv(real target, real pname, void* param) 
void        gl_tex_parameterIuiv(real target, real pname, void* param) 
void        gl_texture_parameterIiv(real textureIndex, real pname, void* param) 
void        gl_texture_parameterIuiv(real textureIndex, real pname, void* param) 
```