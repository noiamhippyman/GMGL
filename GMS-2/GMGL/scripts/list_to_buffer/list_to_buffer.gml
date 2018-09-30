/// @desc list_to_buffer(list,buffer,type);
/// @arg list,buffer,type
var list = argument0;
var buffer = argument1;
var type = argument2;
var count = ds_list_size(list);
buffer_seek(buffer, buffer_seek_start, 0);
for (var i = 0; i < count; ++i) {
	buffer_write(buffer, type, list[|i]);
}