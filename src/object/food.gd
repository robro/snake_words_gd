class_name Food
extends Node2D

var _char
var _color


func _init(pos: Vector2i, text: String, color: Color):
	position = pos
	_char = text
	_color = color
