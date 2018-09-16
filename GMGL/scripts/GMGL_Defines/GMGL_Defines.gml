#macro GMGL_ACTIVE_CHECK_TIME 10 //check every ten seconds
#macro GMGL_TRUE 1
#macro GMGL_FALSE 0
#macro GMGL_FAIL -1
#macro GMGL_SUCCES 1

#macro GMGL_ARRAY_BUFFER 0x8892
#macro GMGL_ELEMENT_ARRAY_BUFFER 0x8893

#macro GMGL_CONTEXT_VERSION_MAJOR	0x00022002
#macro GMGL_CONTEXT_VERSION_MINOR	0x00022003
#macro GMGL_OPENGL_PROFILE			0x00022008

#macro GMGL_OPENGL_ANY_PROFILE		0
#macro GMGL_OPENGL_CORE_PROFILE		0x00032001
#macro GMGL_OPENGL_COMPAT_PROFILE	0x00032002

#macro GMGL_COMPUTE_SHADER 0x91B9
#macro GMGL_VERTEX_SHADER 0x8B31
#macro GMGL_TESS_CONTROL_SHADER 0x8E88
#macro GMGL_TESS_EVALUATION_SHADER 0x8E87
#macro GMGL_GEOMETRY_SHADER 0x8DD9
#macro GMGL_FRAGMENT_SHADER 0x8B30

#macro GMGL_TRIANGLES 0x0004

#macro GMGL_STATIC_DRAW 0x88E4

#macro GMGL_TEXTURE_WRAP_S 0x2802
#macro GMGL_TEXTURE_WRAP_T 0x2803
#macro GMGL_TEXTURE_MIN_FILTER 0x2801
#macro GMGL_TEXTURE_MAG_FILTER 0x2800

#macro GMGL_REPEAT 0x2901
#macro GMGL_LINEAR 0x2601
#macro GMGL_LINEAR_MIPMAP_LINEAR 0x2703

#macro GMGL_RGB 0x1907
#macro GMGL_RGBA 0x1908

#macro GMGL_TEXTURE0 0x84C0
#macro GMGL_TEXTURE1 0x84C1
#macro GMGL_TEXTURE2 0x84C2
#macro GMGL_TEXTURE3 0x84C3
#macro GMGL_TEXTURE4 0x84C4
#macro GMGL_TEXTURE5 0x84C5
#macro GMGL_TEXTURE6 0x84C6
#macro GMGL_TEXTURE7 0x84C7
#macro GMGL_TEXTURE8 0x84C8
#macro GMGL_TEXTURE9 0x84C9
#macro GMGL_TEXTURE10 0x84CA
#macro GMGL_TEXTURE11 0x84CB
#macro GMGL_TEXTURE12 0x84CC
#macro GMGL_TEXTURE13 0x84CD
#macro GMGL_TEXTURE14 0x84CE
#macro GMGL_TEXTURE15 0x84CF

#macro GMGL_COLOR_BUFFER_BIT 0x00004000
#macro GMGL_DEPTH_BUFFER_BIT 0x00000100
#macro GMGL_ACCUM_BUFFER_BIT 0x00000200
#macro GMGL_STENCIL_BUFFER_BIT 0x00000400

#macro GMGL_ALPHA_TEST 0x0BC0
#macro GMGL_AUTO_NORMAL 0x0D80
#macro GMGL_BLEND 0x0BE2
#macro GMGL_CLIP_PLANE0 0x3000
#macro GMGL_CLIP_PLANE1 0x3001
#macro GMGL_CLIP_PLANE2 0x3002
#macro GMGL_CLIP_PLANE3 0x3003
#macro GMGL_CLIP_PLANE4 0x3004
#macro GMGL_CLIP_PLANE5 0x3005
#macro GMGL_COLOR_LOGIC_OP 0x0BF2
#macro GMGL_COLOR_MATERIAL 0x0B57
#macro GMGL_COLOR_SUM 0x8458
#macro GMGL_COLOR_TABLE 0x80D0
#macro GMGL_CONVOLUTION_1D 0x8010
#macro GMGL_CONVOLUTION_2D 0x8011
#macro GMGL_CULL_FACE 0x0B44
#macro GMGL_DEPTH_TEST 0x0B71
#macro GMGL_DITHER 0x0BD0
#macro GMGL_FOG 0x0B60
#macro GMGL_HISTOGRAM 0x8024
#macro GMGL_INDEX_LOGIC_OP 0x0BF1
#macro GMGL_LIGHT0 0x4000
#macro GMGL_LIGHT1 0x4001
#macro GMGL_LIGHT2 0x4002
#macro GMGL_LIGHT3 0x4003
#macro GMGL_LIGHT4 0x4004
#macro GMGL_LIGHT5 0x4005
#macro GMGL_LIGHT6 0x4006
#macro GMGL_LIGHT7 0x4007
#macro GMGL_LIGHTING 0x0B50
#macro GMGL_LINE_SMOOTH 0x0B20
#macro GMGL_LINE_STIPPLE 0x0B24
#macro GMGL_MAP1_COLOR_4 0x0D90
#macro GMGL_MAP1_INDEX 0x0D91
#macro GMGL_MAP1_NORMAL 0x0D92
#macro GMGL_MAP1_TEXTURE_COORD_1 0x0D93
#macro GMGL_MAP1_TEXTURE_COORD_2 0x0D94
#macro GMGL_MAP1_TEXTURE_COORD_3 0x0D95
#macro GMGL_MAP1_TEXTURE_COORD_4 0x0D96
#macro GMGL_MAP1_VERTEX_3 0x0D97
#macro GMGL_MAP1_VERTEX_4 0x0D98
#macro GMGL_MAP2_COLOR_4 0x0DB0
#macro GMGL_MAP2_INDEX 0x0DB1
#macro GMGL_MAP2_NORMAL 0x0DB2
#macro GMGL_MAP2_TEXTURE_COORD_1 0x0DB3
#macro GMGL_MAP2_TEXTURE_COORD_2 0x0DB4
#macro GMGL_MAP2_TEXTURE_COORD_3 0x0DB5
#macro GMGL_MAP2_TEXTURE_COORD_4 0x0DB6
#macro GMGL_MAP2_VERTEX_3 0x0DB7
#macro GMGL_MAP2_VERTEX_4 0x0DB8
#macro GMGL_MINMAX 0x802E
#macro GMGL_MULTISAMPLE 0x809D
#macro GMGL_NORMALIZE 0x0BA1
#macro GMGL_POINT_SMOOTH 0x0B10
#macro GMGL_POINT_SPRITE 0x8861
#macro GMGL_POLYGON_OFFSET_FILL 0x8037
#macro GMGL_POLYGON_OFFSET_LINE 0x2A02
#macro GMGL_POLYGON_OFFSET_POINT 0x2A01
#macro GMGL_POLYGON_SMOOTH 0x0B41
#macro GMGL_POLYGON_STIPPLE 0x0B42
#macro GMGL_POST_COLOR_MATRIX_COLOR_TABLE 0x80D2
#macro GMGL_POST_CONVOLUTION_COLOR_TABLE 0x80D1
#macro GMGL_RESCALE_NORMAL 0x803A
#macro GMGL_SAMPLE_ALPHA_TO_COVERAGE 0x809E
#macro GMGL_SAMPLE_ALPHA_TO_ONE 0x809F
#macro GMGL_SAMPLE_COVERAGE 0x80A0
#macro GMGL_SEPARABLE_2D 0x8012
#macro GMGL_SCISSOR_TEST 0x0C11
#macro GMGL_STENCIL_TEST 0x0B90
#macro GMGL_TEXTURE_1D 0x0DE0
#macro GMGL_TEXTURE_2D 0x0DE1
#macro GMGL_TEXTURE_3D 0x806F
#macro GMGL_TEXTURE_CUBE_MAP 0x8512
#macro GMGL_TEXTURE_GEN_Q 0x0C63
#macro GMGL_TEXTURE_GEN_R 0x0C62
#macro GMGL_TEXTURE_GEN_S 0x0C60
#macro GMGL_TEXTURE_GEN_T 0x0C61
#macro GMGL_VERTEX_PROGRAM_POINT_SIZE 0x8642
#macro GMGL_VERTEX_PROGRAM_TWO_SIDE 0x8643

#region Keycodes

/* The unknown key */
#macro GMGL_KEY_UNKNOWN            -1

/* Printable keys */
#macro GMGL_KEY_SPACE              32
#macro GMGL_KEY_APOSTROPHE         39  /* ' */
#macro GMGL_KEY_COMMA              44  /* , */
#macro GMGL_KEY_MINUS              45  /* - */
#macro GMGL_KEY_PERIOD             46  /* . */
#macro GMGL_KEY_SLASH              47  /* / */
#macro GMGL_KEY_0                  48
#macro GMGL_KEY_1                  49
#macro GMGL_KEY_2                  50
#macro GMGL_KEY_3                  51
#macro GMGL_KEY_4                  52
#macro GMGL_KEY_5                  53
#macro GMGL_KEY_6                  54
#macro GMGL_KEY_7                  55
#macro GMGL_KEY_8                  56
#macro GMGL_KEY_9                  57
#macro GMGL_KEY_SEMICOLON          59  /* ; */
#macro GMGL_KEY_EQUAL              61  /* = */
#macro GMGL_KEY_A                  65
#macro GMGL_KEY_B                  66
#macro GMGL_KEY_C                  67
#macro GMGL_KEY_D                  68
#macro GMGL_KEY_E                  69
#macro GMGL_KEY_F                  70
#macro GMGL_KEY_G                  71
#macro GMGL_KEY_H                  72
#macro GMGL_KEY_I                  73
#macro GMGL_KEY_J                  74
#macro GMGL_KEY_K                  75
#macro GMGL_KEY_L                  76
#macro GMGL_KEY_M                  77
#macro GMGL_KEY_N                  78
#macro GMGL_KEY_O                  79
#macro GMGL_KEY_P                  80
#macro GMGL_KEY_Q                  81
#macro GMGL_KEY_R                  82
#macro GMGL_KEY_S                  83
#macro GMGL_KEY_T                  84
#macro GMGL_KEY_U                  85
#macro GMGL_KEY_V                  86
#macro GMGL_KEY_W                  87
#macro GMGL_KEY_X                  88
#macro GMGL_KEY_Y                  89
#macro GMGL_KEY_Z                  90
#macro GMGL_KEY_LEFT_BRACKET       91  /* [ */
#macro GMGL_KEY_BACKSLASH          92  /* \ */
#macro GMGL_KEY_RIGHT_BRACKET      93  /* ] */
#macro GMGL_KEY_GRAVE_ACCENT       96  /* ` */
#macro GMGL_KEY_WORLD_1            161 /* non-US #1 */
#macro GMGL_KEY_WORLD_2            162 /* non-US #2 */

/* Function keys */
#macro GMGL_KEY_ESCAPE             256
#macro GMGL_KEY_ENTER              257
#macro GMGL_KEY_TAB                258
#macro GMGL_KEY_BACKSPACE          259
#macro GMGL_KEY_INSERT             260
#macro GMGL_KEY_DELETE             261
#macro GMGL_KEY_RIGHT              262
#macro GMGL_KEY_LEFT               263
#macro GMGL_KEY_DOWN               264
#macro GMGL_KEY_UP                 265
#macro GMGL_KEY_PAGE_UP            266
#macro GMGL_KEY_PAGE_DOWN          267
#macro GMGL_KEY_HOME               268
#macro GMGL_KEY_END                269
#macro GMGL_KEY_CAPS_LOCK          280
#macro GMGL_KEY_SCROLL_LOCK        281
#macro GMGL_KEY_NUM_LOCK           282
#macro GMGL_KEY_PRINT_SCREEN       283
#macro GMGL_KEY_PAUSE              284
#macro GMGL_KEY_F1                 290
#macro GMGL_KEY_F2                 291
#macro GMGL_KEY_F3                 292
#macro GMGL_KEY_F4                 293
#macro GMGL_KEY_F5                 294
#macro GMGL_KEY_F6                 295
#macro GMGL_KEY_F7                 296
#macro GMGL_KEY_F8                 297
#macro GMGL_KEY_F9                 298
#macro GMGL_KEY_F10                299
#macro GMGL_KEY_F11                300
#macro GMGL_KEY_F12                301
#macro GMGL_KEY_F13                302
#macro GMGL_KEY_F14                303
#macro GMGL_KEY_F15                304
#macro GMGL_KEY_F16                305
#macro GMGL_KEY_F17                306
#macro GMGL_KEY_F18                307
#macro GMGL_KEY_F19                308
#macro GMGL_KEY_F20                309
#macro GMGL_KEY_F21                310
#macro GMGL_KEY_F22                311
#macro GMGL_KEY_F23                312
#macro GMGL_KEY_F24                313
#macro GMGL_KEY_F25                314
#macro GMGL_KEY_KP_0               320
#macro GMGL_KEY_KP_1               321
#macro GMGL_KEY_KP_2               322
#macro GMGL_KEY_KP_3               323
#macro GMGL_KEY_KP_4               324
#macro GMGL_KEY_KP_5               325
#macro GMGL_KEY_KP_6               326
#macro GMGL_KEY_KP_7               327
#macro GMGL_KEY_KP_8               328
#macro GMGL_KEY_KP_9               329
#macro GMGL_KEY_KP_DECIMAL         330
#macro GMGL_KEY_KP_DIVIDE          331
#macro GMGL_KEY_KP_MULTIPLY        332
#macro GMGL_KEY_KP_SUBTRACT        333
#macro GMGL_KEY_KP_ADD             334
#macro GMGL_KEY_KP_ENTER           335
#macro GMGL_KEY_KP_EQUAL           336
#macro GMGL_KEY_LEFT_SHIFT         340
#macro GMGL_KEY_LEFT_CONTROL       341
#macro GMGL_KEY_LEFT_ALT           342
#macro GMGL_KEY_LEFT_SUPER         343
#macro GMGL_KEY_RIGHT_SHIFT        344
#macro GMGL_KEY_RIGHT_CONTROL      345
#macro GMGL_KEY_RIGHT_ALT          346
#macro GMGL_KEY_RIGHT_SUPER        347
#macro GMGL_KEY_MENU               348

#endregion

#region Mouse buttons

#macro GMGL_MOUSE_BUTTON_1   0
#macro GMGL_MOUSE_BUTTON_2   1
#macro GMGL_MOUSE_BUTTON_3   2
#macro GMGL_MOUSE_BUTTON_4   3
#macro GMGL_MOUSE_BUTTON_5   4
#macro GMGL_MOUSE_BUTTON_6   5
#macro GMGL_MOUSE_BUTTON_7   6
#macro GMGL_MOUSE_BUTTON_8   7
#macro GMGL_MOUSE_BUTTON_LEFT   GMGL_MOUSE_BUTTON_1
#macro GMGL_MOUSE_BUTTON_RIGHT   GMGL_MOUSE_BUTTON_2
#macro GMGL_MOUSE_BUTTON_MIDDLE   GMGL_MOUSE_BUTTON_3

#endregion

#macro GMGL_CURSOR                 0x00033001
#macro GMGL_STICKY_KEYS            0x00033002
#macro GMGL_STICKY_MOUSE_BUTTONS   0x00033003

#macro GMGL_CURSOR_NORMAL          0x00034001
#macro GMGL_CURSOR_HIDDEN          0x00034002
#macro GMGL_CURSOR_DISABLED        0x00034003