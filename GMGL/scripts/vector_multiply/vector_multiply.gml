/// @desc vector_multiply(vector,scalar);
/// @arg vector,scalar
var v1 = argument0;
var v2 = argument1;
for (var i = 0; i < 3; ++i) {
	v1[i] *= is_array(v2) ? v2[i] : v2;
}

return v1;