class_name Cell
extends Node2D

var ascii : String
var color_type : Colors.Type
var blend_color : Color


func _init(
	_ascii: String = " ",
	_color_type: Colors.Type = Colors.Type.BACKGROUND,
	_blend_color: Color = Color(0, 0, 0, 0),
) -> void:
	assert(_ascii.length() == 1)
	ascii = _ascii
	color_type = _color_type
	blend_color = _blend_color
