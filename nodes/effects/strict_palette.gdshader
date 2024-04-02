shader_type canvas_item;

const int MAX_COLORS = 1024;

uniform sampler2D screen_texture : hint_screen_texture, filter_nearest;
uniform int color_count;
uniform vec3[MAX_COLORS] palette : source_color;

vec3 rgbToLinear(vec3 rgb) {
	return pow(rgb, vec3(2.2));
}

vec3 rgbToXyz(vec3 rgb) {
	mat3 rgbToXYZ = mat3(
    vec3(0.4124, 0.3576, 0.1805),
    vec3(0.2126, 0.7152, 0.0722),
    vec3(0.0193, 0.1192, 0.9505)
	);
	
	return rgbToXYZ * rgb;
}

vec3 xyzToLab(vec3 xyz) {
	float epsilon = 0.008856;
	float kappa = 903.3;
	
	vec3 XYZn = vec3(0.9505, 1.0, 1.0890);
	vec3 XYZr = xyz / XYZn;
	
	vec3 Lab;
	Lab.x = (XYZr.x > epsilon) ? (pow(XYZr.x, 1.0 / 3.0)) : ((kappa * XYZr.x + 16.0) / 116.0);
	Lab.y = (XYZr.y > epsilon) ? (pow(XYZr.y, 1.0 / 3.0)) : ((kappa * XYZr.y + 16.0) / 116.0);
	Lab.z = (XYZr.z > epsilon) ? (pow(XYZr.z, 1.0 / 3.0)) : ((kappa * XYZr.z + 16.0) / 116.0);
	
	Lab.x = (Lab.x * 100.0) - 16.0;
	Lab.y = (Lab.y * 128.0) - 128.0;
	Lab.z = (Lab.z * 128.0) - 128.0;
	
	return Lab;
}

vec3 closestColor(vec3 rgb) {
	vec3 labC = xyzToLab(rgbToXyz(rgbToLinear(rgb)));
	
	int minIndex = 0;
	vec3 minColor = palette[minIndex];
	
	for (int i = 0; i < color_count; i++) {
		vec3 ilab = xyzToLab(rgbToXyz(rgbToLinear(palette[i])));
		
		if (distance(labC, ilab) < distance(labC, minColor)) {
			minColor = ilab;
			minIndex = i;
		}
	}
	
	return palette[minIndex];
}

void fragment() {
	vec3 screen_col = texture(screen_texture, SCREEN_UV).xyz;
	
	screen_col = COLOR.xyz * screen_col;
	
	vec3 colorVector = closestColor(screen_col);
	
	COLOR.xyz = colorVector;
}
