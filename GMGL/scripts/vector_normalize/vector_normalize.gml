/// @desc vector_normalize(vector);
/// @arg vector
var v = argument0;
var dist = point_distance_3d(0,0,0,v[0],v[1],v[2]);
for (var i = 0; i < 3; ++i) {
	v[i] /= dist;
}
return v;