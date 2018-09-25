{
    "id": "cfb5b347-2b1c-460c-b15f-a38d8ad10762",
    "modelName": "GMExtension",
    "mvc": "1.0",
    "name": "GMGL",
    "IncludedResources": [
        
    ],
    "androidPermissions": [
        
    ],
    "androidProps": false,
    "androidactivityinject": "",
    "androidclassname": "",
    "androidinject": "",
    "androidmanifestinject": "",
    "androidsourcedir": "",
    "author": "",
    "classname": "",
    "copyToTargets": 194,
    "date": "2018-32-11 04:09:42",
    "description": "",
    "extensionName": "",
    "files": [
        {
            "id": "da6cf3cd-83ad-48fe-a502-02d44cbda810",
            "modelName": "GMExtensionFile",
            "mvc": "1.0",
            "ProxyFiles": [
                
            ],
            "constants": [
                
            ],
            "copyToTargets": 64,
            "filename": "GMGL.dll",
            "final": "",
            "functions": [
                {
                    "id": "96fe0dfc-a6e0-476b-aa89-a409fb1c30c6",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 4,
                    "args": [
                        1,
                        1,
                        1,
                        1
                    ],
                    "externalName": "RegisterCallbacks",
                    "help": "",
                    "hidden": true,
                    "kind": 11,
                    "name": "RegisterCallbacks",
                    "returnType": 2
                },
                {
                    "id": "3b53333b-c647-461d-9e92-194b8cdb5d9e",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 0,
                    "args": [
                        
                    ],
                    "externalName": "gmgl_is_active",
                    "help": "gmgl_is_active()",
                    "hidden": false,
                    "kind": 1,
                    "name": "gmgl_is_active",
                    "returnType": 2
                },
                {
                    "id": "f2773f76-720d-4d99-8395-17236b181d74",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 1,
                    "args": [
                        1
                    ],
                    "externalName": "gmgl_load_image",
                    "help": "gmgl_load_image(path)",
                    "hidden": false,
                    "kind": 1,
                    "name": "gmgl_load_image",
                    "returnType": 2
                },
                {
                    "id": "14765d7d-99c0-475f-b6cc-345b85d531b6",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 1,
                    "args": [
                        2
                    ],
                    "externalName": "gmgl_free_image",
                    "help": "gmgl_free_image(imageIndex)",
                    "hidden": false,
                    "kind": 1,
                    "name": "gmgl_free_image",
                    "returnType": 2
                },
                {
                    "id": "0c1929c1-e910-444a-a7d0-31a55f79f1d2",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 1,
                    "args": [
                        2
                    ],
                    "externalName": "gmgl_get_image_width",
                    "help": "gmgl_get_image_width(image)",
                    "hidden": false,
                    "kind": 1,
                    "name": "gmgl_get_image_width",
                    "returnType": 2
                },
                {
                    "id": "869a6a67-44e2-4160-bab2-3771c431bc75",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 1,
                    "args": [
                        2
                    ],
                    "externalName": "gmgl_get_image_height",
                    "help": "gmgl_get_image_height(image)",
                    "hidden": false,
                    "kind": 1,
                    "name": "gmgl_get_image_height",
                    "returnType": 2
                },
                {
                    "id": "85a6675f-5055-4136-af07-ec13aabc7575",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 1,
                    "args": [
                        2
                    ],
                    "externalName": "gmgl_get_image_channel_num",
                    "help": "gmgl_get_image_channel_num(image)",
                    "hidden": false,
                    "kind": 1,
                    "name": "gmgl_get_image_channel_num",
                    "returnType": 2
                },
                {
                    "id": "6e2269eb-671d-4a66-9ea6-70c2406185ee",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 0,
                    "args": [
                        
                    ],
                    "externalName": "glfw_init",
                    "help": "glfw_init()",
                    "hidden": false,
                    "kind": 1,
                    "name": "glfw_init",
                    "returnType": 2
                },
                {
                    "id": "e859faa9-147b-4307-a575-840d0c0a3daa",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 0,
                    "args": [
                        
                    ],
                    "externalName": "glfw_update",
                    "help": "glfw_update()",
                    "hidden": false,
                    "kind": 1,
                    "name": "glfw_update",
                    "returnType": 2
                },
                {
                    "id": "39df4c0e-a307-4d46-ab8e-418f526ea065",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 0,
                    "args": [
                        
                    ],
                    "externalName": "glfw_terminate",
                    "help": "glfw_terminate()",
                    "hidden": false,
                    "kind": 1,
                    "name": "glfw_terminate",
                    "returnType": 2
                },
                {
                    "id": "71835f1d-aa8a-4221-af4e-c0c3d73c61fe",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 3,
                    "args": [
                        2,
                        2,
                        1
                    ],
                    "externalName": "glfw_create_window",
                    "help": "glfw_create_window(width, height, title)",
                    "hidden": false,
                    "kind": 1,
                    "name": "glfw_create_window",
                    "returnType": 2
                },
                {
                    "id": "70232ba1-5523-46f9-84d2-f66dd8542174",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 0,
                    "args": [
                        
                    ],
                    "externalName": "glfw_default_window_hints",
                    "help": "glfw_default_window_hints()",
                    "hidden": false,
                    "kind": 1,
                    "name": "glfw_default_window_hints",
                    "returnType": 2
                },
                {
                    "id": "549cb2ee-6ee5-439e-aa3e-3976c62d3286",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 2,
                    "args": [
                        2,
                        2
                    ],
                    "externalName": "glfw_window_hint",
                    "help": "glfw_window_hint(hint, value)",
                    "hidden": false,
                    "kind": 1,
                    "name": "glfw_window_hint",
                    "returnType": 2
                },
                {
                    "id": "c3257e53-fb91-461c-bb05-544bea21adc9",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 1,
                    "args": [
                        1
                    ],
                    "externalName": "glfw_set_window_title",
                    "help": "glfw_set_window_title(title)",
                    "hidden": false,
                    "kind": 1,
                    "name": "glfw_set_window_title",
                    "returnType": 2
                },
                {
                    "id": "6ef722bb-c592-4868-ab96-ee7bdb35a187",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 1,
                    "args": [
                        1
                    ],
                    "externalName": "glfw_set_window_icon",
                    "help": "glfw_set_window_icon(path)",
                    "hidden": false,
                    "kind": 1,
                    "name": "glfw_set_window_icon",
                    "returnType": 2
                },
                {
                    "id": "a8164531-ca5e-4f2e-ba45-2b373d46e4f8",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 0,
                    "args": [
                        
                    ],
                    "externalName": "glfw_get_window_x",
                    "help": "glfw_get_window_x()",
                    "hidden": false,
                    "kind": 1,
                    "name": "glfw_get_window_x",
                    "returnType": 2
                },
                {
                    "id": "c68ab9cc-c79e-46fc-9d79-cd2d65b4dcaf",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 0,
                    "args": [
                        
                    ],
                    "externalName": "glfw_get_window_y",
                    "help": "glfw_get_window_y()",
                    "hidden": false,
                    "kind": 1,
                    "name": "glfw_get_window_y",
                    "returnType": 2
                },
                {
                    "id": "aea95dec-a2cd-45be-9223-25456cb5b2a6",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 2,
                    "args": [
                        2,
                        2
                    ],
                    "externalName": "glfw_set_window_pos",
                    "help": "glfw_set_window_pos(x, y)",
                    "hidden": false,
                    "kind": 1,
                    "name": "glfw_set_window_pos",
                    "returnType": 2
                },
                {
                    "id": "b6e3c8e0-a485-4412-8121-9eb3f8736843",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 0,
                    "args": [
                        
                    ],
                    "externalName": "glfw_get_window_width",
                    "help": "glfw_get_window_width()",
                    "hidden": false,
                    "kind": 1,
                    "name": "glfw_get_window_width",
                    "returnType": 2
                },
                {
                    "id": "4ccaa327-5feb-4c95-b09f-29c7707671a3",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 0,
                    "args": [
                        
                    ],
                    "externalName": "glfw_get_window_height",
                    "help": "glfw_get_window_height()",
                    "hidden": false,
                    "kind": 1,
                    "name": "glfw_get_window_height",
                    "returnType": 2
                },
                {
                    "id": "cf7665a2-1897-46e3-ae48-05fa3be40927",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 4,
                    "args": [
                        2,
                        2,
                        2,
                        2
                    ],
                    "externalName": "glfw_set_window_size_limits",
                    "help": "glfw_set_window_size_limits(minwidth, minheight, maxwidth, maxheight)",
                    "hidden": false,
                    "kind": 1,
                    "name": "glfw_set_window_size_limits",
                    "returnType": 2
                },
                {
                    "id": "c5f9048e-d3ee-485f-98ba-4eeeb37543a6",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 2,
                    "args": [
                        2,
                        2
                    ],
                    "externalName": "glfw_set_window_aspect_ratio",
                    "help": "glfw_set_window_aspect_ratio(numer, denom)",
                    "hidden": false,
                    "kind": 1,
                    "name": "glfw_set_window_aspect_ratio",
                    "returnType": 2
                },
                {
                    "id": "65ec69f2-c5c6-49de-90a3-394f019ae621",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 2,
                    "args": [
                        2,
                        2
                    ],
                    "externalName": "glfw_set_window_size",
                    "help": "glfw_set_window_size(width, height)",
                    "hidden": false,
                    "kind": 1,
                    "name": "glfw_set_window_size",
                    "returnType": 2
                },
                {
                    "id": "305637c0-00a2-4fb6-b3df-702b03c94547",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 0,
                    "args": [
                        
                    ],
                    "externalName": "glfw_get_framebuffer_width",
                    "help": "glfw_get_framebuffer_width()",
                    "hidden": false,
                    "kind": 1,
                    "name": "glfw_get_framebuffer_width",
                    "returnType": 2
                },
                {
                    "id": "684c6b44-27c5-44b2-b21d-0aafa670a7c9",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 0,
                    "args": [
                        
                    ],
                    "externalName": "glfw_get_framebuffer_height",
                    "help": "glfw_get_framebuffer_height()",
                    "hidden": false,
                    "kind": 1,
                    "name": "glfw_get_framebuffer_height",
                    "returnType": 2
                },
                {
                    "id": "9bc998bb-2df5-413e-93e9-904417c6a7b9",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 0,
                    "args": [
                        
                    ],
                    "externalName": "glfw_iconify_window",
                    "help": "glfw_iconify_window()",
                    "hidden": false,
                    "kind": 1,
                    "name": "glfw_iconify_window",
                    "returnType": 2
                },
                {
                    "id": "dd5475c4-8118-4705-9fc2-b0d8fe7b4743",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 0,
                    "args": [
                        
                    ],
                    "externalName": "glfw_restore_window",
                    "help": "glfw_restore_window()",
                    "hidden": false,
                    "kind": 1,
                    "name": "glfw_restore_window",
                    "returnType": 2
                },
                {
                    "id": "88842db8-6029-414c-a17e-6c3cd8f46631",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 0,
                    "args": [
                        
                    ],
                    "externalName": "glfw_maximize_window",
                    "help": "glfw_maximize_window()",
                    "hidden": false,
                    "kind": 1,
                    "name": "glfw_maximize_window",
                    "returnType": 2
                },
                {
                    "id": "e5155ef1-d33c-4a38-b5ee-7eb4d7cade27",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 0,
                    "args": [
                        
                    ],
                    "externalName": "glfw_show_window",
                    "help": "glfw_show_window()",
                    "hidden": false,
                    "kind": 1,
                    "name": "glfw_show_window",
                    "returnType": 2
                },
                {
                    "id": "126ff50e-951e-41e1-a017-78ddd24c3bb0",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 0,
                    "args": [
                        
                    ],
                    "externalName": "glfw_hide_window",
                    "help": "glfw_hide_window()",
                    "hidden": false,
                    "kind": 1,
                    "name": "glfw_hide_window",
                    "returnType": 2
                },
                {
                    "id": "745c04c5-f5c1-40c6-98ee-879d7bfbb808",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 0,
                    "args": [
                        
                    ],
                    "externalName": "glfw_focus_window",
                    "help": "glfw_focus_window()",
                    "hidden": false,
                    "kind": 1,
                    "name": "glfw_focus_window",
                    "returnType": 2
                },
                {
                    "id": "7bba0411-6ebc-47c0-b3c3-ec77cb8274e4",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 1,
                    "args": [
                        2
                    ],
                    "externalName": "glfw_get_window_attrib",
                    "help": "glfw_get_window_attrib(attrib)",
                    "hidden": false,
                    "kind": 1,
                    "name": "glfw_get_window_attrib",
                    "returnType": 2
                },
                {
                    "id": "bc1dd10f-4fef-4725-8f18-41dc664b07bd",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 0,
                    "args": [
                        
                    ],
                    "externalName": "glfw_poll_events",
                    "help": "glfw_poll_events()",
                    "hidden": false,
                    "kind": 1,
                    "name": "glfw_poll_events",
                    "returnType": 2
                },
                {
                    "id": "bada81d2-9e68-4cf2-b5a4-06dfbb7d6f80",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 0,
                    "args": [
                        
                    ],
                    "externalName": "glfw_wait_events",
                    "help": "glfw_wait_events()",
                    "hidden": false,
                    "kind": 1,
                    "name": "glfw_wait_events",
                    "returnType": 2
                },
                {
                    "id": "4929c990-85d1-4c11-970f-9e5c0c93d58f",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 1,
                    "args": [
                        2
                    ],
                    "externalName": "glfw_wait_events_timeout",
                    "help": "glfw_wait_events_timeout(timeout)",
                    "hidden": false,
                    "kind": 1,
                    "name": "glfw_wait_events_timeout",
                    "returnType": 2
                },
                {
                    "id": "2f935932-0086-44ba-a086-a4f1e46afd07",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 0,
                    "args": [
                        
                    ],
                    "externalName": "glfw_post_empty_event",
                    "help": "glfw_post_empty_event()",
                    "hidden": false,
                    "kind": 1,
                    "name": "glfw_post_empty_event",
                    "returnType": 2
                },
                {
                    "id": "370af6e2-359c-49aa-8412-a5d4680ee099",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 0,
                    "args": [
                        
                    ],
                    "externalName": "glfw_swap_buffers",
                    "help": "glfw_swap_buffers()",
                    "hidden": false,
                    "kind": 1,
                    "name": "glfw_swap_buffers",
                    "returnType": 2
                },
                {
                    "id": "7ff63cef-32b6-4460-ad9f-2734f30f56c7",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 2,
                    "args": [
                        2,
                        2
                    ],
                    "externalName": "glfw_set_input_mode",
                    "help": "glfw_set_input_mode(mode, value)",
                    "hidden": false,
                    "kind": 1,
                    "name": "glfw_set_input_mode",
                    "returnType": 2
                },
                {
                    "id": "8a80f42f-0745-429e-821a-697879e4fccd",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 1,
                    "args": [
                        2
                    ],
                    "externalName": "glfw_get_input_mode",
                    "help": "glfw_get_input_mode(mode)",
                    "hidden": false,
                    "kind": 1,
                    "name": "glfw_get_input_mode",
                    "returnType": 2
                },
                {
                    "id": "f95b2714-551b-4d63-9e92-4f1059e90416",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 1,
                    "args": [
                        2
                    ],
                    "externalName": "glfw_get_key",
                    "help": "glfw_get_key(key)",
                    "hidden": false,
                    "kind": 1,
                    "name": "glfw_get_key",
                    "returnType": 2
                },
                {
                    "id": "6c60577f-e9e0-4320-8232-8fb555fbee17",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 1,
                    "args": [
                        2
                    ],
                    "externalName": "glfw_get_mouse_button",
                    "help": "glfw_get_mouse_button(button)",
                    "hidden": false,
                    "kind": 1,
                    "name": "glfw_get_mouse_button",
                    "returnType": 2
                },
                {
                    "id": "5be86c58-c7ed-414c-a4b9-38d540a70f73",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 0,
                    "args": [
                        
                    ],
                    "externalName": "glfw_get_mouse_x",
                    "help": "glfw_get_mouse_x()",
                    "hidden": false,
                    "kind": 1,
                    "name": "glfw_get_mouse_x",
                    "returnType": 2
                },
                {
                    "id": "493a11c5-4433-4457-85b8-c49e41f927e8",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 0,
                    "args": [
                        
                    ],
                    "externalName": "glfw_get_mouse_y",
                    "help": "glfw_get_mouse_y()",
                    "hidden": false,
                    "kind": 1,
                    "name": "glfw_get_mouse_y",
                    "returnType": 2
                },
                {
                    "id": "7dc766d0-2fa4-4838-8454-20366fd29914",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 2,
                    "args": [
                        2,
                        2
                    ],
                    "externalName": "glfw_set_mouse_pos",
                    "help": "glfw_set_mouse_pos(x, y)",
                    "hidden": false,
                    "kind": 1,
                    "name": "glfw_set_mouse_pos",
                    "returnType": 2
                },
                {
                    "id": "3b49c685-1646-4096-b610-5c38f8b5c35e",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 1,
                    "args": [
                        1
                    ],
                    "externalName": "glfw_set_clipboard_string",
                    "help": "glfw_set_clipboard_string(string)",
                    "hidden": false,
                    "kind": 1,
                    "name": "glfw_set_clipboard_string",
                    "returnType": 2
                },
                {
                    "id": "086b7ea9-f373-4e85-a26f-1ee0b542089b",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 0,
                    "args": [
                        
                    ],
                    "externalName": "glfw_get_time",
                    "help": "glfw_get_time()",
                    "hidden": false,
                    "kind": 1,
                    "name": "glfw_get_time",
                    "returnType": 2
                },
                {
                    "id": "87232d5f-e028-4a9d-9deb-f57580843af1",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 1,
                    "args": [
                        2
                    ],
                    "externalName": "glfw_set_time",
                    "help": "glfw_set_time(time)",
                    "hidden": false,
                    "kind": 1,
                    "name": "glfw_set_time",
                    "returnType": 2
                },
                {
                    "id": "65608ea3-ae73-4265-b69c-a6fbcdcb769f",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 4,
                    "args": [
                        2,
                        2,
                        2,
                        2
                    ],
                    "externalName": "gl_viewport",
                    "help": "gl_viewport(x, y, width, height)",
                    "hidden": false,
                    "kind": 1,
                    "name": "gl_viewport",
                    "returnType": 2
                },
                {
                    "id": "00b4708e-dcdf-40a1-af7b-66a5728094eb",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 1,
                    "args": [
                        2
                    ],
                    "externalName": "gl_enable",
                    "help": "gl_enable(cap)",
                    "hidden": false,
                    "kind": 1,
                    "name": "gl_enable",
                    "returnType": 2
                },
                {
                    "id": "49b9da98-b884-47eb-b236-13d75a96c9de",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 1,
                    "args": [
                        2
                    ],
                    "externalName": "gl_disable",
                    "help": "gl_disable(cap)",
                    "hidden": false,
                    "kind": 1,
                    "name": "gl_disable",
                    "returnType": 2
                },
                {
                    "id": "5da829d4-79f5-4759-8f24-2c9ea0a19348",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 1,
                    "args": [
                        2
                    ],
                    "externalName": "gl_depth_mask",
                    "help": "gl_depth_mask(flag)",
                    "hidden": false,
                    "kind": 1,
                    "name": "gl_depth_mask",
                    "returnType": 2
                },
                {
                    "id": "de89dec6-de03-4fc2-b3fd-9090d6c960c4",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 1,
                    "args": [
                        2
                    ],
                    "externalName": "gl_depth_func",
                    "help": "gl_depth_func(func)",
                    "hidden": false,
                    "kind": 1,
                    "name": "gl_depth_func",
                    "returnType": 2
                },
                {
                    "id": "883c0d15-c276-4b67-b545-6966cc4b73a5",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 1,
                    "args": [
                        2
                    ],
                    "externalName": "gl_stencil_mask",
                    "help": "gl_stencil_mask(mask)",
                    "hidden": false,
                    "kind": 1,
                    "name": "gl_stencil_mask",
                    "returnType": 2
                },
                {
                    "id": "ec5d63ef-b110-4eaf-8d65-58b8fa62c7c3",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 3,
                    "args": [
                        2,
                        2,
                        2
                    ],
                    "externalName": "gl_stencil_func",
                    "help": "gl_stencil_func(func, ref, mask)",
                    "hidden": false,
                    "kind": 1,
                    "name": "gl_stencil_func",
                    "returnType": 2
                },
                {
                    "id": "2bfc68ee-c1e4-4204-8259-6598434fc0ca",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 3,
                    "args": [
                        2,
                        2,
                        2
                    ],
                    "externalName": "gl_stencil_op",
                    "help": "gl_stencil_op(fail, zfail, zpass)",
                    "hidden": false,
                    "kind": 1,
                    "name": "gl_stencil_op",
                    "returnType": 2
                },
                {
                    "id": "83a7c829-506b-4c91-946e-9a607c3abd62",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 2,
                    "args": [
                        2,
                        2
                    ],
                    "externalName": "gl_blend_func",
                    "help": "gl_blend_func(sfactor, dfactor)",
                    "hidden": false,
                    "kind": 1,
                    "name": "gl_blend_func",
                    "returnType": 2
                },
                {
                    "id": "c918e0c0-46a8-4266-a5a2-96ec0e0ebcfb",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 4,
                    "args": [
                        2,
                        2,
                        2,
                        2
                    ],
                    "externalName": "gl_blend_func_separate",
                    "help": "gl_blend_func_separate(sfactorRGB, dfactorRGB, sfactorAlpha, dfactorAlpha)",
                    "hidden": false,
                    "kind": 1,
                    "name": "gl_blend_func_separate",
                    "returnType": 2
                },
                {
                    "id": "e5d07bc9-e1ad-4f07-8b70-9f46c549fc4d",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 1,
                    "args": [
                        2
                    ],
                    "externalName": "gl_blend_equation",
                    "help": "gl_blend_equation(mode)",
                    "hidden": false,
                    "kind": 1,
                    "name": "gl_blend_equation",
                    "returnType": 2
                },
                {
                    "id": "10b6e840-eda3-460a-923c-dadfee3b2626",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 1,
                    "args": [
                        2
                    ],
                    "externalName": "gl_cull_face",
                    "help": "gl_cull_face(mode)",
                    "hidden": false,
                    "kind": 1,
                    "name": "gl_cull_face",
                    "returnType": 2
                },
                {
                    "id": "17ee9b79-89ee-4557-a129-26cb2cb8a62e",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 1,
                    "args": [
                        2
                    ],
                    "externalName": "gl_front_face",
                    "help": "gl_front_face(mode)",
                    "hidden": false,
                    "kind": 1,
                    "name": "gl_front_face",
                    "returnType": 2
                },
                {
                    "id": "99e0b78c-3d11-4e63-a617-8e8c98dc5011",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 4,
                    "args": [
                        2,
                        2,
                        2,
                        2
                    ],
                    "externalName": "gl_clear_color",
                    "help": "gl_clear_color(r, g, b, a)",
                    "hidden": false,
                    "kind": 1,
                    "name": "gl_clear_color",
                    "returnType": 2
                },
                {
                    "id": "7fbe19d0-1996-48d0-98c1-6ba407ad7705",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 1,
                    "args": [
                        2
                    ],
                    "externalName": "gl_clear",
                    "help": "gl_clear(mask)",
                    "hidden": false,
                    "kind": 1,
                    "name": "gl_clear",
                    "returnType": 2
                },
                {
                    "id": "fb80c6de-1f0e-4758-b488-923a92bb0e7a",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 3,
                    "args": [
                        2,
                        2,
                        2
                    ],
                    "externalName": "gl_draw_arrays",
                    "help": "gl_draw_arrays(mode, first, count)",
                    "hidden": false,
                    "kind": 1,
                    "name": "gl_draw_arrays",
                    "returnType": 2
                },
                {
                    "id": "8f1982f2-e1b8-43b9-b4da-38720444e03b",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 2,
                    "args": [
                        2,
                        2
                    ],
                    "externalName": "gl_draw_elements",
                    "help": "gl_draw_elements(mode, count)",
                    "hidden": false,
                    "kind": 1,
                    "name": "gl_draw_elements",
                    "returnType": 2
                },
                {
                    "id": "39a618f6-3617-4784-9be9-ce899665b510",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 0,
                    "args": [
                        
                    ],
                    "externalName": "gl_gen_buffer",
                    "help": "gl_gen_buffer()",
                    "hidden": false,
                    "kind": 1,
                    "name": "gl_gen_buffer",
                    "returnType": 2
                },
                {
                    "id": "af0b8e01-b0db-4c52-be8b-5bfaf777bf76",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 2,
                    "args": [
                        2,
                        2
                    ],
                    "externalName": "gl_bind_buffer",
                    "help": "gl_bind_buffer(target, bufferIndex)",
                    "hidden": false,
                    "kind": 1,
                    "name": "gl_bind_buffer",
                    "returnType": 2
                },
                {
                    "id": "6c2f8d6d-dea5-4f5d-8f16-3dbec2334b5b",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 1,
                    "args": [
                        2
                    ],
                    "externalName": "gl_delete_buffer",
                    "help": "gl_delete_buffer(bufferIndex)",
                    "hidden": false,
                    "kind": 1,
                    "name": "gl_delete_buffer",
                    "returnType": 2
                },
                {
                    "id": "a4aac722-987b-4509-912f-849c884c5b1c",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 4,
                    "args": [
                        2,
                        2,
                        1,
                        2
                    ],
                    "externalName": "gl_buffer_data",
                    "help": "gl_buffer_data(target, size, vertices, usage)",
                    "hidden": false,
                    "kind": 1,
                    "name": "gl_buffer_data",
                    "returnType": 2
                },
                {
                    "id": "a22ad940-e06c-47f3-a24e-4cad3527fdb2",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 0,
                    "args": [
                        
                    ],
                    "externalName": "gl_gen_vertex_array",
                    "help": "gl_gen_vertex_array()",
                    "hidden": false,
                    "kind": 1,
                    "name": "gl_gen_vertex_array",
                    "returnType": 2
                },
                {
                    "id": "60450512-bebb-492c-9c02-355825db6a85",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 1,
                    "args": [
                        2
                    ],
                    "externalName": "gl_bind_vertex_array",
                    "help": "gl_bind_vertex_array(varrayIndex)",
                    "hidden": false,
                    "kind": 1,
                    "name": "gl_bind_vertex_array",
                    "returnType": 2
                },
                {
                    "id": "8b60215b-c31d-4aa9-854f-d4abc80feae3",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 1,
                    "args": [
                        2
                    ],
                    "externalName": "gl_delete_vertex_array",
                    "help": "gl_delete_vertex_array(varrayIndex)",
                    "hidden": false,
                    "kind": 1,
                    "name": "gl_delete_vertex_array",
                    "returnType": 2
                },
                {
                    "id": "97c1955e-068e-45d0-968f-8660979c8cbc",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 6,
                    "args": [
                        2,
                        2,
                        2,
                        2,
                        2,
                        2
                    ],
                    "externalName": "gl_vertex_attrib_pointer",
                    "help": "gl_vertex_attrib_pointer(index, size, type, normalized, stride, offset)",
                    "hidden": false,
                    "kind": 1,
                    "name": "gl_vertex_attrib_pointer",
                    "returnType": 2
                },
                {
                    "id": "45066c2e-b5fa-4713-824c-2f8680043fad",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 1,
                    "args": [
                        2
                    ],
                    "externalName": "gl_enable_vertex_attrib_array",
                    "help": "gl_enable_vertex_attrib_array(index)",
                    "hidden": false,
                    "kind": 1,
                    "name": "gl_enable_vertex_attrib_array",
                    "returnType": 2
                },
                {
                    "id": "d91dd5e9-62d2-4425-ba33-3c07fb397b4e",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 0,
                    "args": [
                        
                    ],
                    "externalName": "gl_gen_texture",
                    "help": "gl_gen_texture()",
                    "hidden": false,
                    "kind": 1,
                    "name": "gl_gen_texture",
                    "returnType": 2
                },
                {
                    "id": "89a549a2-2324-47a0-9928-52eebd8b0bcc",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 2,
                    "args": [
                        2,
                        2
                    ],
                    "externalName": "gl_bind_texture",
                    "help": "gl_bind_texture(target, textureIndex)",
                    "hidden": false,
                    "kind": 1,
                    "name": "gl_bind_texture",
                    "returnType": 2
                },
                {
                    "id": "782b2ddc-0831-4a61-94f2-9ac3f1c0f2f7",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 1,
                    "args": [
                        2
                    ],
                    "externalName": "gl_delete_texture",
                    "help": "gl_delete_texture(textureIndex)",
                    "hidden": false,
                    "kind": 1,
                    "name": "gl_delete_texture",
                    "returnType": 2
                },
                {
                    "id": "351330fc-2520-46b1-b132-100517bbd67c",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 1,
                    "args": [
                        2
                    ],
                    "externalName": "gl_active_texture",
                    "help": "gl_active_texture(unit)",
                    "hidden": false,
                    "kind": 1,
                    "name": "gl_active_texture",
                    "returnType": 2
                },
                {
                    "id": "f204a943-8e17-46be-a357-9598e45f130d",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 7,
                    "args": [
                        2,
                        2,
                        2,
                        2,
                        2,
                        2,
                        2
                    ],
                    "externalName": "gl_texImage2D",
                    "help": "gl_texImage2D(target, level, internalformat, border, format, type, imageIndex)",
                    "hidden": false,
                    "kind": 1,
                    "name": "gl_texImage2D",
                    "returnType": 2
                },
                {
                    "id": "70732e48-3559-46b8-a52d-746a6a438fb0",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 1,
                    "args": [
                        2
                    ],
                    "externalName": "gl_generate_mipmap",
                    "help": "gl_generate_mipmap(target)",
                    "hidden": false,
                    "kind": 1,
                    "name": "gl_generate_mipmap",
                    "returnType": 2
                },
                {
                    "id": "d0b24e9c-6b19-4e17-8807-8139aad37d35",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 0,
                    "args": [
                        
                    ],
                    "externalName": "gl_gen_framebuffer",
                    "help": "gl_gen_framebuffer()",
                    "hidden": false,
                    "kind": 1,
                    "name": "gl_gen_framebuffer",
                    "returnType": 2
                },
                {
                    "id": "bc929ebd-a8ca-4990-976b-9f7022ad8a54",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 2,
                    "args": [
                        2,
                        2
                    ],
                    "externalName": "gl_bind_framebuffer",
                    "help": "gl_bind_framebuffer(target, framebufferIndex)",
                    "hidden": false,
                    "kind": 1,
                    "name": "gl_bind_framebuffer",
                    "returnType": 2
                },
                {
                    "id": "fb0d4454-0290-4a6c-8994-a75f6b032d78",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 1,
                    "args": [
                        2
                    ],
                    "externalName": "gl_delete_framebuffer",
                    "help": "gl_delete_framebuffer(framebufferIndex)",
                    "hidden": false,
                    "kind": 1,
                    "name": "gl_delete_framebuffer",
                    "returnType": 2
                },
                {
                    "id": "9bffbed4-e534-4a6b-ba23-b1748d736eb3",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 2,
                    "args": [
                        2,
                        1
                    ],
                    "externalName": "gl_create_shader",
                    "help": "gl_create_shader(type, source)",
                    "hidden": false,
                    "kind": 1,
                    "name": "gl_create_shader",
                    "returnType": 2
                },
                {
                    "id": "0cec0e31-d5f9-4eac-9caf-c64a1751f072",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 1,
                    "args": [
                        2
                    ],
                    "externalName": "gl_delete_shader",
                    "help": "gl_delete_shader(shaderIndex)",
                    "hidden": false,
                    "kind": 1,
                    "name": "gl_delete_shader",
                    "returnType": 2
                },
                {
                    "id": "19d799e3-0e26-4206-ab46-178003548dae",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 0,
                    "args": [
                        
                    ],
                    "externalName": "gl_create_program",
                    "help": "gl_create_program()",
                    "hidden": false,
                    "kind": 1,
                    "name": "gl_create_program",
                    "returnType": 2
                },
                {
                    "id": "464029d7-0f7f-4a98-8fe2-9d5fbd0ca529",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 2,
                    "args": [
                        2,
                        2
                    ],
                    "externalName": "gl_attach_shader",
                    "help": "gl_attach_shader(programIndex, shaderIndex)",
                    "hidden": false,
                    "kind": 1,
                    "name": "gl_attach_shader",
                    "returnType": 2
                },
                {
                    "id": "30072e85-3d10-474e-8879-15560cb8546f",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 1,
                    "args": [
                        2
                    ],
                    "externalName": "gl_link_program",
                    "help": "gl_link_program(programIndex)",
                    "hidden": false,
                    "kind": 1,
                    "name": "gl_link_program",
                    "returnType": 2
                },
                {
                    "id": "8e67961e-ef31-414f-8d64-aa8d71a5dda1",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 1,
                    "args": [
                        2
                    ],
                    "externalName": "gl_use_program",
                    "help": "gl_use_program(programIndex)",
                    "hidden": false,
                    "kind": 1,
                    "name": "gl_use_program",
                    "returnType": 2
                },
                {
                    "id": "2b4e7ba2-7217-4151-bd63-aebaa57239c2",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 2,
                    "args": [
                        2,
                        1
                    ],
                    "externalName": "gl_get_uniform_location",
                    "help": "gl_get_uniform_location(programIndex, name)",
                    "hidden": false,
                    "kind": 1,
                    "name": "gl_get_uniform_location",
                    "returnType": 2
                },
                {
                    "id": "6cfa03b7-b3aa-48ce-a367-eb12d4e27a97",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 2,
                    "args": [
                        2,
                        2
                    ],
                    "externalName": "gl_uniform1f",
                    "help": "gl_uniform1f(location, x)",
                    "hidden": false,
                    "kind": 1,
                    "name": "gl_uniform1f",
                    "returnType": 2
                },
                {
                    "id": "deba780c-5750-4ed1-a204-92b3c2024250",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 3,
                    "args": [
                        2,
                        2,
                        2
                    ],
                    "externalName": "gl_uniform2f",
                    "help": "gl_uniform2f(location, x, y)",
                    "hidden": false,
                    "kind": 1,
                    "name": "gl_uniform2f",
                    "returnType": 2
                },
                {
                    "id": "b01caa89-867a-4f38-9b36-20bf54aa2ac9",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 4,
                    "args": [
                        2,
                        2,
                        2,
                        2
                    ],
                    "externalName": "gl_uniform3f",
                    "help": "gl_uniform3f(location, x, y, z)",
                    "hidden": false,
                    "kind": 1,
                    "name": "gl_uniform3f",
                    "returnType": 2
                },
                {
                    "id": "7da822a6-9927-4809-9172-2d712c6fa36c",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 5,
                    "args": [
                        2,
                        2,
                        2,
                        2,
                        2
                    ],
                    "externalName": "gl_uniform4f",
                    "help": "gl_uniform4f(location, x, y, z, w)",
                    "hidden": false,
                    "kind": 1,
                    "name": "gl_uniform4f",
                    "returnType": 2
                },
                {
                    "id": "a461bb2e-7668-4078-8371-1da360a04b9f",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 2,
                    "args": [
                        2,
                        2
                    ],
                    "externalName": "gl_uniform1i",
                    "help": "gl_uniform1i(location, x)",
                    "hidden": false,
                    "kind": 1,
                    "name": "gl_uniform1i",
                    "returnType": 2
                },
                {
                    "id": "8c59e9fa-8062-42c1-b8d3-c0a7f44ab9e0",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 3,
                    "args": [
                        2,
                        2,
                        2
                    ],
                    "externalName": "gl_uniform2i",
                    "help": "gl_uniform2i(location, x, y)",
                    "hidden": false,
                    "kind": 1,
                    "name": "gl_uniform2i",
                    "returnType": 2
                },
                {
                    "id": "1ead08d0-66a1-4908-8c47-2b98d969ea5e",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 4,
                    "args": [
                        2,
                        2,
                        2,
                        2
                    ],
                    "externalName": "gl_uniform3i",
                    "help": "gl_uniform3i(location, x, y, z)",
                    "hidden": false,
                    "kind": 1,
                    "name": "gl_uniform3i",
                    "returnType": 2
                },
                {
                    "id": "b51a34d1-e608-4898-b8f4-2c7dfe072b21",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 5,
                    "args": [
                        2,
                        2,
                        2,
                        2,
                        2
                    ],
                    "externalName": "gl_uniform4i",
                    "help": "gl_uniform4i(location, x, y, z, w)",
                    "hidden": false,
                    "kind": 1,
                    "name": "gl_uniform4i",
                    "returnType": 2
                },
                {
                    "id": "80ac767a-7061-4055-ba40-0a6636c7fc02",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 2,
                    "args": [
                        2,
                        2
                    ],
                    "externalName": "gl_uniform1ui",
                    "help": "gl_uniform1ui(location, x)",
                    "hidden": false,
                    "kind": 1,
                    "name": "gl_uniform1ui",
                    "returnType": 2
                },
                {
                    "id": "23f503d0-31ed-4a14-92a5-254d302eeea2",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 3,
                    "args": [
                        2,
                        2,
                        2
                    ],
                    "externalName": "gl_uniform2ui",
                    "help": "gl_uniform2ui(location, x, y)",
                    "hidden": false,
                    "kind": 1,
                    "name": "gl_uniform2ui",
                    "returnType": 2
                },
                {
                    "id": "739eb216-9dc5-4a59-a9c9-d30d2c153346",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 4,
                    "args": [
                        2,
                        2,
                        2,
                        2
                    ],
                    "externalName": "gl_uniform3ui",
                    "help": "gl_uniform3ui(location, x, y, z)",
                    "hidden": false,
                    "kind": 1,
                    "name": "gl_uniform3ui",
                    "returnType": 2
                },
                {
                    "id": "3ad704ac-b1a7-4258-8b71-ea28da212e28",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 5,
                    "args": [
                        2,
                        2,
                        2,
                        2,
                        2
                    ],
                    "externalName": "gl_uniform4ui",
                    "help": "gl_uniform4ui(location, x, y, z, w)",
                    "hidden": false,
                    "kind": 1,
                    "name": "gl_uniform4ui",
                    "returnType": 2
                },
                {
                    "id": "7845a070-12b8-4b88-a52c-b9f031d22513",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 3,
                    "args": [
                        2,
                        2,
                        1
                    ],
                    "externalName": "gl_uniform1fv",
                    "help": "gl_uniform1fv(location, size, value)",
                    "hidden": false,
                    "kind": 1,
                    "name": "gl_uniform1fv",
                    "returnType": 2
                },
                {
                    "id": "7a854fde-cf18-4022-9f21-21115e787e43",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 3,
                    "args": [
                        2,
                        2,
                        1
                    ],
                    "externalName": "gl_uniform2fv",
                    "help": "gl_uniform2fv(location, size, value)",
                    "hidden": false,
                    "kind": 1,
                    "name": "gl_uniform2fv",
                    "returnType": 2
                },
                {
                    "id": "f8578999-0ea6-4c3f-95d5-a2fe54b46507",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 3,
                    "args": [
                        2,
                        2,
                        1
                    ],
                    "externalName": "gl_uniform3fv",
                    "help": "gl_uniform3fv(location, size, value)",
                    "hidden": false,
                    "kind": 1,
                    "name": "gl_uniform3fv",
                    "returnType": 2
                },
                {
                    "id": "02b26be4-b8d0-4192-a97c-07a65f575ea1",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 3,
                    "args": [
                        2,
                        2,
                        1
                    ],
                    "externalName": "gl_uniform4fv",
                    "help": "gl_uniform4fv(location, size, value)",
                    "hidden": false,
                    "kind": 1,
                    "name": "gl_uniform4fv",
                    "returnType": 2
                },
                {
                    "id": "f2936042-cfc3-43d5-9eb8-ff1b1463e71a",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 3,
                    "args": [
                        2,
                        2,
                        1
                    ],
                    "externalName": "gl_uniform1iv",
                    "help": "gl_uniform1iv(location, size, value)",
                    "hidden": false,
                    "kind": 1,
                    "name": "gl_uniform1iv",
                    "returnType": 2
                },
                {
                    "id": "93a17f4a-c64b-4960-a8f9-e5d7d2e3fb9e",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 3,
                    "args": [
                        2,
                        2,
                        1
                    ],
                    "externalName": "gl_uniform2iv",
                    "help": "gl_uniform2iv(location, size, value)",
                    "hidden": false,
                    "kind": 1,
                    "name": "gl_uniform2iv",
                    "returnType": 2
                },
                {
                    "id": "d4a9bcc8-8786-4ac0-a2cc-436ef04b6712",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 3,
                    "args": [
                        2,
                        2,
                        1
                    ],
                    "externalName": "gl_uniform3iv",
                    "help": "gl_uniform3iv(location, size, value)",
                    "hidden": false,
                    "kind": 1,
                    "name": "gl_uniform3iv",
                    "returnType": 2
                },
                {
                    "id": "5aedb072-bc4f-4159-98b7-112474945edd",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 3,
                    "args": [
                        2,
                        2,
                        1
                    ],
                    "externalName": "gl_uniform4iv",
                    "help": "gl_uniform4iv(location, size, value)",
                    "hidden": false,
                    "kind": 1,
                    "name": "gl_uniform4iv",
                    "returnType": 2
                },
                {
                    "id": "0853068f-b53b-4133-8339-73ed467210ed",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 3,
                    "args": [
                        2,
                        2,
                        1
                    ],
                    "externalName": "gl_uniform1uiv",
                    "help": "gl_uniform1uiv(location, size, value)",
                    "hidden": false,
                    "kind": 1,
                    "name": "gl_uniform1uiv",
                    "returnType": 2
                },
                {
                    "id": "25c73a6c-a132-4b50-9f29-d057a0732310",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 3,
                    "args": [
                        2,
                        2,
                        1
                    ],
                    "externalName": "gl_uniform2uiv",
                    "help": "gl_uniform2uiv(location, size, value)",
                    "hidden": false,
                    "kind": 1,
                    "name": "gl_uniform2uiv",
                    "returnType": 2
                },
                {
                    "id": "359493b1-b3ee-4597-85ed-5c8486482870",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 3,
                    "args": [
                        2,
                        2,
                        1
                    ],
                    "externalName": "gl_uniform3uiv",
                    "help": "gl_uniform3uiv(location, size, value)",
                    "hidden": false,
                    "kind": 1,
                    "name": "gl_uniform3uiv",
                    "returnType": 2
                },
                {
                    "id": "b311e861-2fc6-4e6b-a357-433c552e9ae4",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 3,
                    "args": [
                        2,
                        2,
                        1
                    ],
                    "externalName": "gl_uniform4uiv",
                    "help": "gl_uniform4uiv(location, size, value)",
                    "hidden": false,
                    "kind": 1,
                    "name": "gl_uniform4uiv",
                    "returnType": 2
                },
                {
                    "id": "036586e6-7e83-4434-b96a-86832d96980e",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 4,
                    "args": [
                        2,
                        2,
                        2,
                        1
                    ],
                    "externalName": "gl_uniform_mat2fv",
                    "help": "gl_uniform_mat2fv(location, count, transpose, value)",
                    "hidden": false,
                    "kind": 1,
                    "name": "gl_uniform_mat2fv",
                    "returnType": 2
                },
                {
                    "id": "bdf61e09-5714-435e-95cc-26c19c0ecceb",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 4,
                    "args": [
                        2,
                        2,
                        2,
                        1
                    ],
                    "externalName": "gl_uniform_mat3fv",
                    "help": "gl_uniform_mat3fv(location, count, transpose, value)",
                    "hidden": false,
                    "kind": 1,
                    "name": "gl_uniform_mat3fv",
                    "returnType": 2
                },
                {
                    "id": "c0f8c585-2a61-433b-b42a-3a6ff92a4854",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 4,
                    "args": [
                        2,
                        2,
                        2,
                        1
                    ],
                    "externalName": "gl_uniform_mat4fv",
                    "help": "gl_uniform_mat4fv(location, count, transpose, value)",
                    "hidden": false,
                    "kind": 1,
                    "name": "gl_uniform_mat4fv",
                    "returnType": 2
                },
                {
                    "id": "385a0a7e-0dc9-4da7-a3ce-24ce40f0944c",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 4,
                    "args": [
                        2,
                        2,
                        2,
                        1
                    ],
                    "externalName": "gl_uniform_mat2x3fv",
                    "help": "gl_uniform_mat2x3fv(location, count, transpose, value)",
                    "hidden": false,
                    "kind": 1,
                    "name": "gl_uniform_mat2x3fv",
                    "returnType": 2
                },
                {
                    "id": "003f06a4-9fd5-4034-8d20-c6925ecdb151",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 4,
                    "args": [
                        2,
                        2,
                        2,
                        1
                    ],
                    "externalName": "gl_uniform_mat3x2fv",
                    "help": "gl_uniform_mat3x2fv(location, count, transpose, value)",
                    "hidden": false,
                    "kind": 1,
                    "name": "gl_uniform_mat3x2fv",
                    "returnType": 2
                },
                {
                    "id": "6f0ecd26-7e29-495a-a5c7-199c64c580e5",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 4,
                    "args": [
                        2,
                        2,
                        2,
                        1
                    ],
                    "externalName": "gl_uniform_mat2x4fv",
                    "help": "gl_uniform_mat2x4fv(location, count, transpose, value)",
                    "hidden": false,
                    "kind": 1,
                    "name": "gl_uniform_mat2x4fv",
                    "returnType": 2
                },
                {
                    "id": "da589678-94b4-493d-858c-b556bee8ae1d",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 4,
                    "args": [
                        2,
                        2,
                        2,
                        1
                    ],
                    "externalName": "gl_uniform_mat4x2fv",
                    "help": "gl_uniform_mat4x2fv(location, count, transpose, value)",
                    "hidden": false,
                    "kind": 1,
                    "name": "gl_uniform_mat4x2fv",
                    "returnType": 2
                },
                {
                    "id": "635f443f-dac1-4e31-9756-db7fcdfd5655",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 4,
                    "args": [
                        2,
                        2,
                        2,
                        1
                    ],
                    "externalName": "gl_uniform_mat3x4fv",
                    "help": "gl_uniform_mat3x4fv(location, count, transpose, value)",
                    "hidden": false,
                    "kind": 1,
                    "name": "gl_uniform_mat3x4fv",
                    "returnType": 2
                },
                {
                    "id": "ce0723a8-d16e-448b-b978-18d30c592c6a",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 4,
                    "args": [
                        2,
                        2,
                        2,
                        1
                    ],
                    "externalName": "gl_uniform_mat4x3fv",
                    "help": "gl_uniform_mat4x3fv(location, count, transpose, value)",
                    "hidden": false,
                    "kind": 1,
                    "name": "gl_uniform_mat4x3fv",
                    "returnType": 2
                },
                {
                    "id": "17805b31-3ad7-4393-8dc6-06598f9f089b",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 3,
                    "args": [
                        2,
                        2,
                        2
                    ],
                    "externalName": "gl_tex_parameterf",
                    "help": "gl_tex_parameterf(target, pname, param)",
                    "hidden": false,
                    "kind": 1,
                    "name": "gl_tex_parameterf",
                    "returnType": 2
                },
                {
                    "id": "29af104d-488b-4cc4-bbe2-192b05b45b5f",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 3,
                    "args": [
                        2,
                        2,
                        2
                    ],
                    "externalName": "gl_tex_parameteri",
                    "help": "gl_tex_parameteri(target, pname, param)",
                    "hidden": false,
                    "kind": 1,
                    "name": "gl_tex_parameteri",
                    "returnType": 2
                },
                {
                    "id": "9aa6c185-9654-4f8b-8459-2245e3caec81",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 3,
                    "args": [
                        2,
                        2,
                        2
                    ],
                    "externalName": "gl_texture_parameterf",
                    "help": "gl_texture_parameterf(textureIndex, pname, param)",
                    "hidden": false,
                    "kind": 1,
                    "name": "gl_texture_parameterf",
                    "returnType": 2
                },
                {
                    "id": "135d08c8-89ee-4da4-860b-9f9e589c9c23",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 3,
                    "args": [
                        2,
                        2,
                        2
                    ],
                    "externalName": "gl_texture_parameteri",
                    "help": "gl_texture_parameteri(textureIndex, pname, param)",
                    "hidden": false,
                    "kind": 1,
                    "name": "gl_texture_parameteri",
                    "returnType": 2
                },
                {
                    "id": "f01006c7-cef1-49ca-8f3d-a44bc1d07e9c",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 3,
                    "args": [
                        2,
                        2,
                        1
                    ],
                    "externalName": "gl_tex_parameterfv",
                    "help": "gl_tex_parameterfv(target, pname, param)",
                    "hidden": false,
                    "kind": 1,
                    "name": "gl_tex_parameterfv",
                    "returnType": 2
                },
                {
                    "id": "97fb43bd-d3bd-4d19-956e-8e7f32604144",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 3,
                    "args": [
                        2,
                        2,
                        1
                    ],
                    "externalName": "gl_tex_parameteriv",
                    "help": "gl_tex_parameteriv(target, pname, param)",
                    "hidden": false,
                    "kind": 1,
                    "name": "gl_tex_parameteriv",
                    "returnType": 2
                },
                {
                    "id": "80d4efd2-0d3b-4e62-b085-2e6685e1de38",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 3,
                    "args": [
                        2,
                        2,
                        1
                    ],
                    "externalName": "gl_texture_parameterfv",
                    "help": "gl_texture_parameterfv(textureIndex, pname, param)",
                    "hidden": false,
                    "kind": 1,
                    "name": "gl_texture_parameterfv",
                    "returnType": 2
                },
                {
                    "id": "4cce2de3-6b03-44d9-8ffd-121721fc3730",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 3,
                    "args": [
                        2,
                        2,
                        1
                    ],
                    "externalName": "gl_texture_parameteriv",
                    "help": "gl_texture_parameteriv(textureIndex, pname, param)",
                    "hidden": false,
                    "kind": 1,
                    "name": "gl_texture_parameteriv",
                    "returnType": 2
                },
                {
                    "id": "0494fe3f-1017-4711-bf9a-3d6c61d6eb36",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 3,
                    "args": [
                        2,
                        2,
                        1
                    ],
                    "externalName": "gl_tex_parameterIiv",
                    "help": "gl_tex_parameterIiv(target, pname, param)",
                    "hidden": false,
                    "kind": 1,
                    "name": "gl_tex_parameterIiv",
                    "returnType": 2
                },
                {
                    "id": "80cfcb61-45bb-4eb9-bea8-d1b781bc9065",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 3,
                    "args": [
                        2,
                        2,
                        1
                    ],
                    "externalName": "gl_tex_parameterIuiv",
                    "help": "gl_tex_parameterIuiv(target, pname, param)",
                    "hidden": false,
                    "kind": 1,
                    "name": "gl_tex_parameterIuiv",
                    "returnType": 2
                },
                {
                    "id": "3cb94bb5-c5e5-44cd-be37-f5bf8ed1a5fc",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 3,
                    "args": [
                        2,
                        2,
                        1
                    ],
                    "externalName": "gl_texture_parameterIiv",
                    "help": "gl_texture_parameterIiv(textureIndex, pname, param)",
                    "hidden": false,
                    "kind": 1,
                    "name": "gl_texture_parameterIiv",
                    "returnType": 2
                },
                {
                    "id": "5789d87b-b6aa-4247-a358-5a43435c637e",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 3,
                    "args": [
                        2,
                        2,
                        1
                    ],
                    "externalName": "gl_texture_parameterIuiv",
                    "help": "gl_texture_parameterIuiv(textureIndex, pname, param)",
                    "hidden": false,
                    "kind": 1,
                    "name": "gl_texture_parameterIuiv",
                    "returnType": 2
                }
            ],
            "init": "",
            "kind": 1,
            "order": [
                "96fe0dfc-a6e0-476b-aa89-a409fb1c30c6",
                "3b53333b-c647-461d-9e92-194b8cdb5d9e",
                "f2773f76-720d-4d99-8395-17236b181d74",
                "14765d7d-99c0-475f-b6cc-345b85d531b6",
                "0c1929c1-e910-444a-a7d0-31a55f79f1d2",
                "869a6a67-44e2-4160-bab2-3771c431bc75",
                "85a6675f-5055-4136-af07-ec13aabc7575",
                "6e2269eb-671d-4a66-9ea6-70c2406185ee",
                "e859faa9-147b-4307-a575-840d0c0a3daa",
                "39df4c0e-a307-4d46-ab8e-418f526ea065",
                "71835f1d-aa8a-4221-af4e-c0c3d73c61fe",
                "70232ba1-5523-46f9-84d2-f66dd8542174",
                "549cb2ee-6ee5-439e-aa3e-3976c62d3286",
                "c3257e53-fb91-461c-bb05-544bea21adc9",
                "6ef722bb-c592-4868-ab96-ee7bdb35a187",
                "a8164531-ca5e-4f2e-ba45-2b373d46e4f8",
                "c68ab9cc-c79e-46fc-9d79-cd2d65b4dcaf",
                "aea95dec-a2cd-45be-9223-25456cb5b2a6",
                "b6e3c8e0-a485-4412-8121-9eb3f8736843",
                "4ccaa327-5feb-4c95-b09f-29c7707671a3",
                "65ec69f2-c5c6-49de-90a3-394f019ae621",
                "cf7665a2-1897-46e3-ae48-05fa3be40927",
                "c5f9048e-d3ee-485f-98ba-4eeeb37543a6",
                "305637c0-00a2-4fb6-b3df-702b03c94547",
                "684c6b44-27c5-44b2-b21d-0aafa670a7c9",
                "9bc998bb-2df5-413e-93e9-904417c6a7b9",
                "dd5475c4-8118-4705-9fc2-b0d8fe7b4743",
                "88842db8-6029-414c-a17e-6c3cd8f46631",
                "e5155ef1-d33c-4a38-b5ee-7eb4d7cade27",
                "126ff50e-951e-41e1-a017-78ddd24c3bb0",
                "745c04c5-f5c1-40c6-98ee-879d7bfbb808",
                "7bba0411-6ebc-47c0-b3c3-ec77cb8274e4",
                "bc1dd10f-4fef-4725-8f18-41dc664b07bd",
                "bada81d2-9e68-4cf2-b5a4-06dfbb7d6f80",
                "4929c990-85d1-4c11-970f-9e5c0c93d58f",
                "2f935932-0086-44ba-a086-a4f1e46afd07",
                "370af6e2-359c-49aa-8412-a5d4680ee099",
                "7ff63cef-32b6-4460-ad9f-2734f30f56c7",
                "8a80f42f-0745-429e-821a-697879e4fccd",
                "f95b2714-551b-4d63-9e92-4f1059e90416",
                "6c60577f-e9e0-4320-8232-8fb555fbee17",
                "5be86c58-c7ed-414c-a4b9-38d540a70f73",
                "493a11c5-4433-4457-85b8-c49e41f927e8",
                "7dc766d0-2fa4-4838-8454-20366fd29914",
                "3b49c685-1646-4096-b610-5c38f8b5c35e",
                "086b7ea9-f373-4e85-a26f-1ee0b542089b",
                "87232d5f-e028-4a9d-9deb-f57580843af1",
                "65608ea3-ae73-4265-b69c-a6fbcdcb769f",
                "00b4708e-dcdf-40a1-af7b-66a5728094eb",
                "49b9da98-b884-47eb-b236-13d75a96c9de",
                "5da829d4-79f5-4759-8f24-2c9ea0a19348",
                "de89dec6-de03-4fc2-b3fd-9090d6c960c4",
                "883c0d15-c276-4b67-b545-6966cc4b73a5",
                "ec5d63ef-b110-4eaf-8d65-58b8fa62c7c3",
                "2bfc68ee-c1e4-4204-8259-6598434fc0ca",
                "83a7c829-506b-4c91-946e-9a607c3abd62",
                "c918e0c0-46a8-4266-a5a2-96ec0e0ebcfb",
                "e5d07bc9-e1ad-4f07-8b70-9f46c549fc4d",
                "10b6e840-eda3-460a-923c-dadfee3b2626",
                "17ee9b79-89ee-4557-a129-26cb2cb8a62e",
                "99e0b78c-3d11-4e63-a617-8e8c98dc5011",
                "7fbe19d0-1996-48d0-98c1-6ba407ad7705",
                "fb80c6de-1f0e-4758-b488-923a92bb0e7a",
                "8f1982f2-e1b8-43b9-b4da-38720444e03b",
                "39a618f6-3617-4784-9be9-ce899665b510",
                "af0b8e01-b0db-4c52-be8b-5bfaf777bf76",
                "6c2f8d6d-dea5-4f5d-8f16-3dbec2334b5b",
                "a4aac722-987b-4509-912f-849c884c5b1c",
                "a22ad940-e06c-47f3-a24e-4cad3527fdb2",
                "60450512-bebb-492c-9c02-355825db6a85",
                "8b60215b-c31d-4aa9-854f-d4abc80feae3",
                "97c1955e-068e-45d0-968f-8660979c8cbc",
                "45066c2e-b5fa-4713-824c-2f8680043fad",
                "d91dd5e9-62d2-4425-ba33-3c07fb397b4e",
                "89a549a2-2324-47a0-9928-52eebd8b0bcc",
                "782b2ddc-0831-4a61-94f2-9ac3f1c0f2f7",
                "351330fc-2520-46b1-b132-100517bbd67c",
                "f204a943-8e17-46be-a357-9598e45f130d",
                "70732e48-3559-46b8-a52d-746a6a438fb0",
                "d0b24e9c-6b19-4e17-8807-8139aad37d35",
                "bc929ebd-a8ca-4990-976b-9f7022ad8a54",
                "fb0d4454-0290-4a6c-8994-a75f6b032d78",
                "9bffbed4-e534-4a6b-ba23-b1748d736eb3",
                "0cec0e31-d5f9-4eac-9caf-c64a1751f072",
                "19d799e3-0e26-4206-ab46-178003548dae",
                "464029d7-0f7f-4a98-8fe2-9d5fbd0ca529",
                "30072e85-3d10-474e-8879-15560cb8546f",
                "8e67961e-ef31-414f-8d64-aa8d71a5dda1",
                "2b4e7ba2-7217-4151-bd63-aebaa57239c2",
                "6cfa03b7-b3aa-48ce-a367-eb12d4e27a97",
                "deba780c-5750-4ed1-a204-92b3c2024250",
                "b01caa89-867a-4f38-9b36-20bf54aa2ac9",
                "7da822a6-9927-4809-9172-2d712c6fa36c",
                "a461bb2e-7668-4078-8371-1da360a04b9f",
                "8c59e9fa-8062-42c1-b8d3-c0a7f44ab9e0",
                "1ead08d0-66a1-4908-8c47-2b98d969ea5e",
                "b51a34d1-e608-4898-b8f4-2c7dfe072b21",
                "80ac767a-7061-4055-ba40-0a6636c7fc02",
                "23f503d0-31ed-4a14-92a5-254d302eeea2",
                "739eb216-9dc5-4a59-a9c9-d30d2c153346",
                "3ad704ac-b1a7-4258-8b71-ea28da212e28",
                "7845a070-12b8-4b88-a52c-b9f031d22513",
                "7a854fde-cf18-4022-9f21-21115e787e43",
                "f8578999-0ea6-4c3f-95d5-a2fe54b46507",
                "02b26be4-b8d0-4192-a97c-07a65f575ea1",
                "f2936042-cfc3-43d5-9eb8-ff1b1463e71a",
                "93a17f4a-c64b-4960-a8f9-e5d7d2e3fb9e",
                "d4a9bcc8-8786-4ac0-a2cc-436ef04b6712",
                "5aedb072-bc4f-4159-98b7-112474945edd",
                "0853068f-b53b-4133-8339-73ed467210ed",
                "25c73a6c-a132-4b50-9f29-d057a0732310",
                "359493b1-b3ee-4597-85ed-5c8486482870",
                "b311e861-2fc6-4e6b-a357-433c552e9ae4",
                "036586e6-7e83-4434-b96a-86832d96980e",
                "bdf61e09-5714-435e-95cc-26c19c0ecceb",
                "c0f8c585-2a61-433b-b42a-3a6ff92a4854",
                "385a0a7e-0dc9-4da7-a3ce-24ce40f0944c",
                "003f06a4-9fd5-4034-8d20-c6925ecdb151",
                "6f0ecd26-7e29-495a-a5c7-199c64c580e5",
                "da589678-94b4-493d-858c-b556bee8ae1d",
                "635f443f-dac1-4e31-9756-db7fcdfd5655",
                "ce0723a8-d16e-448b-b978-18d30c592c6a",
                "17805b31-3ad7-4393-8dc6-06598f9f089b",
                "29af104d-488b-4cc4-bbe2-192b05b45b5f",
                "9aa6c185-9654-4f8b-8459-2245e3caec81",
                "135d08c8-89ee-4da4-860b-9f9e589c9c23",
                "f01006c7-cef1-49ca-8f3d-a44bc1d07e9c",
                "97fb43bd-d3bd-4d19-956e-8e7f32604144",
                "80d4efd2-0d3b-4e62-b085-2e6685e1de38",
                "4cce2de3-6b03-44d9-8ffd-121721fc3730",
                "0494fe3f-1017-4711-bf9a-3d6c61d6eb36",
                "80cfcb61-45bb-4eb9-bea8-d1b781bc9065",
                "3cb94bb5-c5e5-44cd-be37-f5bf8ed1a5fc",
                "5789d87b-b6aa-4247-a358-5a43435c637e"
            ],
            "origname": "",
            "uncompress": false
        }
    ],
    "gradleinject": "",
    "helpfile": "",
    "installdir": "",
    "iosProps": false,
    "iosSystemFrameworkEntries": [
        
    ],
    "iosThirdPartyFrameworkEntries": [
        
    ],
    "iosplistinject": "",
    "license": "",
    "maccompilerflags": "",
    "maclinkerflags": "",
    "macsourcedir": "",
    "packageID": "",
    "productID": "",
    "sourcedir": "",
    "tvosProps": false,
    "tvosSystemFrameworkEntries": [
        
    ],
    "tvosThirdPartyFrameworkEntries": [
        
    ],
    "tvosclassname": "",
    "tvosmaccompilerflags": "",
    "tvosmaclinkerflags": "",
    "tvosplistinject": "",
    "version": "0.0.1"
}