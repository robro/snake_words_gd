class_name Food
extends Node2D

var _pos
var _char
var _color


func _init(pos: Vector2i, text: String, color: Color):
	assert(len(text) == 1)
	_pos = pos
	_char = text
	_color = color
