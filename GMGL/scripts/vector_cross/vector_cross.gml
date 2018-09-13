/// @desc vector_cross(vector,vector);
/// @arg vector,vector
var v1 = argument0;
var v2 = argument1;

var ax = v1[0];
var ay = v1[1];
var az = v1[2];
var bx = v2[0];
var by = v2[1];
var bz = v2[2];
return [ay * bz - az * by, az * bx - ax * bz, ax * by - ay * bx];