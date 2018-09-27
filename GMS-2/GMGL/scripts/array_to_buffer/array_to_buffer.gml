/// @desc array_to_buffer(array,buffer,type);
/// @arg array,buffer,type
var array = argument0;
var buffer = argument1;
var type = argument2;
var count = array_length_1d(array);
buffer_seek(buffer, buffer_seek_start, 0);
for (var i = 0; i < count; ++i) {
	buffer_write(buffer, type, array[i]);
}