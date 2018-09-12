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
    "copyToTargets": -1,
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
                {
                    "id": "5273c5b0-9096-48b4-8b16-0bb9ed93ab64",
                    "modelName": "GMExtensionConstant",
                    "mvc": "1.0",
                    "constantName": "GMGL_CONTEXT_VERSION_MAJOR",
                    "hidden": false,
                    "value": "0x00022002"
                },
                {
                    "id": "540f8e5d-2c87-478a-9053-76ec5f7cd690",
                    "modelName": "GMExtensionConstant",
                    "mvc": "1.0",
                    "constantName": "GMGL_CONTEXT_VERSION_MINOR",
                    "hidden": false,
                    "value": "0x00022003"
                },
                {
                    "id": "42519b14-40f8-4438-bef2-c9f97e940ad6",
                    "modelName": "GMExtensionConstant",
                    "mvc": "1.0",
                    "constantName": "GMGL_OPENGL_PROFILE",
                    "hidden": false,
                    "value": "0x00022008"
                },
                {
                    "id": "be94e237-227b-4337-ab72-0080e12d3b20",
                    "modelName": "GMExtensionConstant",
                    "mvc": "1.0",
                    "constantName": "GMGL_OPENGL_ANY_PROFILE",
                    "hidden": false,
                    "value": "0"
                },
                {
                    "id": "4a7d92b1-caed-4bf1-a09d-3d8573375894",
                    "modelName": "GMExtensionConstant",
                    "mvc": "1.0",
                    "constantName": "GMGL_OPENGL_CORE_PROFILE",
                    "hidden": false,
                    "value": "0x00032001"
                },
                {
                    "id": "1ed9e89e-5e47-43b7-974a-2506af893169",
                    "modelName": "GMExtensionConstant",
                    "mvc": "1.0",
                    "constantName": "GMGL_OPENGL_COMPAT_PROFILE",
                    "hidden": false,
                    "value": "0x00032002"
                },
                {
                    "id": "6d7e9b01-e38d-468c-ac36-ab7bc69685d9",
                    "modelName": "GMExtensionConstant",
                    "mvc": "1.0",
                    "constantName": "GMGL_STATIC_DRAW",
                    "hidden": false,
                    "value": "0x88E4"
                },
                {
                    "id": "65b3a3f1-0345-4792-86de-db7f1054c8f4",
                    "modelName": "GMExtensionConstant",
                    "mvc": "1.0",
                    "constantName": "GMGL_DYNAMIC_DRAW",
                    "hidden": false,
                    "value": "0x88E8"
                },
                {
                    "id": "fb53e523-2a62-4948-b669-8026d328feaf",
                    "modelName": "GMExtensionConstant",
                    "mvc": "1.0",
                    "constantName": "GMGL_STREAM_DRAW",
                    "hidden": false,
                    "value": "0x88E0"
                }
            ],
            "copyToTargets": -1,
            "filename": "GMGL.dll",
            "final": "",
            "functions": [
                {
                    "id": "6e2269eb-671d-4a66-9ea6-70c2406185ee",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 0,
                    "args": [
                        
                    ],
                    "externalName": "gmgl_init",
                    "help": "gmgl_init();",
                    "hidden": false,
                    "kind": 1,
                    "name": "gmgl_init",
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
                    "help": "gmgl_is_active();",
                    "hidden": false,
                    "kind": 1,
                    "name": "gmgl_is_active",
                    "returnType": 2
                },
                {
                    "id": "979af822-2d37-4208-a9c5-6f7ede64bafe",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 0,
                    "args": [
                        
                    ],
                    "externalName": "gmgl_update",
                    "help": "gmgl_update();",
                    "hidden": false,
                    "kind": 1,
                    "name": "gmgl_update",
                    "returnType": 2
                },
                {
                    "id": "8034266c-b3a1-43fe-9603-941ca9e78f4b",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 0,
                    "args": [
                        
                    ],
                    "externalName": "gmgl_terminate",
                    "help": "gmgl_terminate();",
                    "hidden": false,
                    "kind": 1,
                    "name": "gmgl_terminate",
                    "returnType": 2
                },
                {
                    "id": "c5c49ea4-821c-4a37-a674-8cc608e6af83",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 0,
                    "args": [
                        
                    ],
                    "externalName": "gmgl_default_window_hints",
                    "help": "gmgl_default_window_hints();",
                    "hidden": false,
                    "kind": 1,
                    "name": "gmgl_default_window_hints",
                    "returnType": 2
                },
                {
                    "id": "0e2d95cd-18b1-41fa-8b35-7286c0d0a10e",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 0,
                    "args": [
                        2,
                        2
                    ],
                    "externalName": "gmgl_window_hint",
                    "help": "gmgl_window_hint(hint,value);",
                    "hidden": false,
                    "kind": 1,
                    "name": "gmgl_window_hint",
                    "returnType": 2
                },
                {
                    "id": "6dd096ad-0a9b-4b8c-9ee6-bcc8c60226ef",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 0,
                    "args": [
                        2,
                        2,
                        1
                    ],
                    "externalName": "gmgl_create_window",
                    "help": "gmgl_create_window(width,height,title);",
                    "hidden": false,
                    "kind": 1,
                    "name": "gmgl_create_window",
                    "returnType": 2
                },
                {
                    "id": "67e6aed5-23f7-42ab-a3ec-7e62a417446a",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 0,
                    "args": [
                        2,
                        2,
                        2,
                        2
                    ],
                    "externalName": "gmgl_clear_color",
                    "help": "gmgl_clear_color(r,g,b,a);",
                    "hidden": false,
                    "kind": 1,
                    "name": "gmgl_clear_color",
                    "returnType": 2
                },
                {
                    "id": "87b2899f-ce18-4019-8b51-5191fb3ad9c3",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 0,
                    "args": [
                        
                    ],
                    "externalName": "gmgl_gen_buffer",
                    "help": "gmgl_gen_buffer();",
                    "hidden": false,
                    "kind": 1,
                    "name": "gmgl_gen_buffer",
                    "returnType": 2
                },
                {
                    "id": "4fea30ab-440b-4730-9e4b-a8d6f8b29541",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 0,
                    "args": [
                        2,
                        2
                    ],
                    "externalName": "gmgl_bind_buffer",
                    "help": "gmgl_bind_buffer(target,buffer);",
                    "hidden": false,
                    "kind": 1,
                    "name": "gmgl_bind_buffer",
                    "returnType": 2
                },
                {
                    "id": "aadc4aeb-3338-41ef-890f-b5c3ed2ed58e",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 0,
                    "args": [
                        2,
                        2,
                        1,
                        2
                    ],
                    "externalName": "gmgl_buffer_data",
                    "help": "gmgl_buffer_data(target,size,vertices,usage);",
                    "hidden": false,
                    "kind": 1,
                    "name": "gmgl_buffer_data",
                    "returnType": 2
                },
                {
                    "id": "be55a9ab-598c-4118-802a-2223eca63504",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 0,
                    "args": [
                        2,
                        1
                    ],
                    "externalName": "gmgl_create_shader",
                    "help": "gmgl_create_shader(type,source);",
                    "hidden": false,
                    "kind": 1,
                    "name": "gmgl_create_shader",
                    "returnType": 2
                },
                {
                    "id": "1cfff8a6-3964-41f5-b7fb-86956034d820",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 0,
                    "args": [
                        2
                    ],
                    "externalName": "gmgl_delete_shader",
                    "help": "gmgl_delete_shader(shader);",
                    "hidden": false,
                    "kind": 1,
                    "name": "gmgl_delete_shader",
                    "returnType": 2
                },
                {
                    "id": "f9a9c6a5-1fff-4851-8b58-5b506e2a8669",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 0,
                    "args": [
                        
                    ],
                    "externalName": "gmgl_create_program",
                    "help": "gmgl_create_program();",
                    "hidden": false,
                    "kind": 1,
                    "name": "gmgl_create_program",
                    "returnType": 2
                },
                {
                    "id": "c8da6b00-37fd-4e3e-90bd-811938641c8d",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 0,
                    "args": [
                        2,
                        2
                    ],
                    "externalName": "gmgl_attach_shader",
                    "help": "gmgl_attach_shader(program,shader);",
                    "hidden": false,
                    "kind": 1,
                    "name": "gmgl_attach_shader",
                    "returnType": 2
                },
                {
                    "id": "be0741ee-52a6-4a79-a258-42b96424ad1c",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 0,
                    "args": [
                        2
                    ],
                    "externalName": "gmgl_link_program",
                    "help": "gmgl_link_program(program);",
                    "hidden": false,
                    "kind": 1,
                    "name": "gmgl_link_program",
                    "returnType": 2
                },
                {
                    "id": "9fb83c98-c456-42cb-a868-db81458e89fb",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 0,
                    "args": [
                        2
                    ],
                    "externalName": "gmgl_use_program",
                    "help": "gmgl_use_program(program);",
                    "hidden": false,
                    "kind": 1,
                    "name": "gmgl_use_program",
                    "returnType": 2
                },
                {
                    "id": "0f153cb0-2f37-45ff-854e-2e01643acc2e",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 0,
                    "args": [
                        2,
                        2,
                        2
                    ],
                    "externalName": "gmgl_draw_arrays",
                    "help": "gmgl_draw_arrays(mode,first,count);",
                    "hidden": false,
                    "kind": 1,
                    "name": "gmgl_draw_arrays",
                    "returnType": 2
                },
                {
                    "id": "667b42fe-2b1c-45f4-ab3a-45fe22dbc78c",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 0,
                    "args": [
                        
                    ],
                    "externalName": "gmgl_gen_vertex_array",
                    "help": "gmgl_gen_vertex_array();",
                    "hidden": false,
                    "kind": 1,
                    "name": "gmgl_gen_vertex_array",
                    "returnType": 2
                },
                {
                    "id": "9d59587b-036b-47ab-a0f6-2ada7c337102",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 0,
                    "args": [
                        2
                    ],
                    "externalName": "gmgl_bind_vertex_array",
                    "help": "gmgl_bind_vertex_array(varray);",
                    "hidden": false,
                    "kind": 1,
                    "name": "gmgl_bind_vertex_array",
                    "returnType": 2
                },
                {
                    "id": "a325f738-5e95-4c6d-abd3-4eeec059ec6d",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 0,
                    "args": [
                        2,
                        2,
                        2,
                        2,
                        2
                    ],
                    "externalName": "gmgl_vertex_attrib_pointer",
                    "help": "gmgl_vertex_attrib_pointer(index,size,normalized,stride,offset);",
                    "hidden": false,
                    "kind": 1,
                    "name": "gmgl_vertex_attrib_pointer",
                    "returnType": 2
                },
                {
                    "id": "99065a11-41e2-4c8e-8df7-ca581571684a",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 0,
                    "args": [
                        2
                    ],
                    "externalName": "gmgl_enable_vertex_attrib_array",
                    "help": "gmgl_enable_vertex_attrib_array(index);",
                    "hidden": false,
                    "kind": 1,
                    "name": "gmgl_enable_vertex_attrib_array",
                    "returnType": 2
                }
            ],
            "init": "",
            "kind": 1,
            "order": [
                "3b53333b-c647-461d-9e92-194b8cdb5d9e",
                "6e2269eb-671d-4a66-9ea6-70c2406185ee",
                "979af822-2d37-4208-a9c5-6f7ede64bafe",
                "8034266c-b3a1-43fe-9603-941ca9e78f4b",
                "c5c49ea4-821c-4a37-a674-8cc608e6af83",
                "0e2d95cd-18b1-41fa-8b35-7286c0d0a10e",
                "6dd096ad-0a9b-4b8c-9ee6-bcc8c60226ef",
                "67e6aed5-23f7-42ab-a3ec-7e62a417446a",
                "be55a9ab-598c-4118-802a-2223eca63504",
                "1cfff8a6-3964-41f5-b7fb-86956034d820",
                "f9a9c6a5-1fff-4851-8b58-5b506e2a8669",
                "c8da6b00-37fd-4e3e-90bd-811938641c8d",
                "be0741ee-52a6-4a79-a258-42b96424ad1c",
                "9fb83c98-c456-42cb-a868-db81458e89fb",
                "0f153cb0-2f37-45ff-854e-2e01643acc2e",
                "87b2899f-ce18-4019-8b51-5191fb3ad9c3",
                "4fea30ab-440b-4730-9e4b-a8d6f8b29541",
                "aadc4aeb-3338-41ef-890f-b5c3ed2ed58e",
                "667b42fe-2b1c-45f4-ab3a-45fe22dbc78c",
                "9d59587b-036b-47ab-a0f6-2ada7c337102",
                "a325f738-5e95-4c6d-abd3-4eeec059ec6d",
                "99065a11-41e2-4c8e-8df7-ca581571684a"
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