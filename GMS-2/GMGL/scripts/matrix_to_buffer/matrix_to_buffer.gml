/// @desc matrix_to_buffer(matrix,buffer,type);
/// @arg matrix,buffer,type
var matrix = argument0;
var buffer = argument1;
var type = argument2;
buffer_seek(buffer,buffer_seek_start,0);
for (var i = 0; i < 16; ++i) {
	buffer_write(buffer,type,matrix[i]);
}