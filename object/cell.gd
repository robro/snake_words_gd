class_name Cell
extends Node2D

var _char : String
var _color : Palette.Type


func _init(text: String, color: Palette.Type):
	assert(len(text) == 1)
	_char = text
	_color = color
