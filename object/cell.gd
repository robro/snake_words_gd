class_name Cell
extends Node2D

var _char : String
var _color : int


func _init(text: String, color: int):
	assert(len(text) == 1)
	_char = text
	_color = color
