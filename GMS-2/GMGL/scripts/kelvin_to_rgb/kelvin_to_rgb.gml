/// @desc kelvin_to_rgb(kelvin);
/// @arg kelvin
var k = argument0 / 100;

var r,g,b;

if (k <= 66) {
	r = 255;
} else {
	r = k - 60;
	r = 329.698727446 * (r ^ -0.1332047592);
}

if (k <= 66) {
	g = k;
	g = 99.4708025861 * ln(g) - 161.1195681661;
} else {
	g = k - 60;
	g = 288.1221695283 * (g ^ -0.0755148492);
}

if (k >= 66) {
	b = 255;
} else {
	if (k <= 19) {
		b = 0;
	} else {
		b = k - 10;
		b = 138.5177312231 * ln(b) - 305.0447927307;
	}
}

return [clamp(r,0,255)/255,clamp(g,0,255)/255,clamp(b,0,255)/255];