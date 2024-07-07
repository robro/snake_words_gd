class_name Cell
extends Node2D

var _char : String
var _color : Color


func set_char(text: String):
	assert(len(text) == 1)
	_char = text


func set_color(color: Color):
	_color = color
