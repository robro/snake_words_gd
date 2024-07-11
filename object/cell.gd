class_name Cell
extends Node2D

var _char : String
var _color : Colors.Type
var _alt_color : Color


func _init(
	text: String, 
	color: Colors.Type, 
	alt_color: Color = Color(0, 0, 0, 0)
) -> void:
	assert(text.length() <= 1)
	_char = text
	_color = color
	_alt_color = alt_color
