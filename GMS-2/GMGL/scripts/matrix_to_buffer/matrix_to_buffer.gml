/// @desc matrix_to_buffer(matrix,buffer);
/// @arg matrix,buffer
var matrix = argument0;
var buffer = argument1;
buffer_seek(buffer,buffer_seek_start,0);
for (var i = 0; i < 16; ++i) {
	buffer_write(buffer,buffer_f32,matrix[i]);
}