#pragma once
#if defined(WIN32)
#define GMS_DLL extern "C" __declspec(dllexport)
#define GMS_DLL_DEPRECATED GMS_DLL
#elif defined(GNUC)
#define GMS_DLL extern "C" __attribute__ ((visibility("default"))) 
#else
#define GMS_DLL extern "C"
#endif


#define GMS_NOONE -4

#define GMS_SUCCESS 1
#define GMS_FAIL -1

#define GMS_TRUE 1
#define GMS_FALSE 0

const int EVENT_OTHER_SOCIAL = 70;

typedef int gml_ds_map;
void(*gml_event_perform_async)(gml_ds_map map, int event_type) = nullptr;
int(*gml_ds_map_create_ext)(int n, ...) = nullptr;
bool(*gml_ds_map_set_double)(gml_ds_map map, char* key, double value) = nullptr;
bool(*gml_ds_map_set_string)(gml_ds_map map, char* key, char* value) = nullptr;
GMS_DLL double RegisterCallbacks(char* arg1, char* arg2, char* arg3, char* arg4) {
	gml_event_perform_async = (void(*)(gml_ds_map, int))arg1;
	gml_ds_map_create_ext = (int(*)(int, ...))arg2;
	gml_ds_map_set_double = (bool(*)(gml_ds_map, char*, double))arg3;
	gml_ds_map_set_string = (bool(*)(gml_ds_map, char*, char*))arg4;
	return 0;
}
gml_ds_map gml_ds_map_create() {
	return gml_ds_map_create_ext(0);
}