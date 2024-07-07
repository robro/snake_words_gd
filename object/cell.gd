class_name Cell
extends Node2D

var _char : String
var _color : Color


func _init(text: String, color: Color):
	assert(len(text) == 1)
	_char = text
	_color = color
