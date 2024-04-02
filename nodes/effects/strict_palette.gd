@tool
class_name StrictPaletteMaterial extends ShaderMaterial

@export var cell_size: int = 1
@export var color_palette: Texture2D
@export var update_palette: bool:
	set(v):
		_load_palette()


@warning_ignore("integer_division")
func _load_palette():
	var img = color_palette.get_image()
	var color_array: Array[Color] = []
	
	
	for x in img.get_width() / cell_size:
		for y in img.get_height() / cell_size:
			var color: Color = img.get_pixel(x, y) 
			
			if color in color_array: continue
			color_array.append(color)
	set_shader_parameter("palette", PackedColorArray(color_array))
	set_shader_parameter("color_count", len(color_array))
