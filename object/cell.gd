class_name Cell
extends Node2D

var _char : String
var _color : int
var _add_color : Color


func _init(text: String, color: int, add_color: Color = Color.BLACK) -> void:
	assert(len(text) == 1)
	_char = text
	_color = color
	_add_color = add_color
