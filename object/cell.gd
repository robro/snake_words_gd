class_name Cell
extends Node2D

var _char : String
var _color : Colors.Type
var _add_color : Color


func _init(text: String, color: Colors.Type, add_color: Color = Color.BLACK) -> void:
	assert(text.length() <= 1)
	_char = text
	_color = color
	_add_color = add_color
