class_name SnakePart
extends Node2D

var _pos : Vector2i
var _char : String
var _color : int


func _init(pos: Vector2i, text: String, color: int) -> void:
	assert(text.length() == 1)
	assert(color >= 0 and color < Palette.color.size())

	_pos = pos
	_char = text
	_color = color

	add_to_group("drawable")


func _ready() -> void:
	z_index = get_parent().z_index


func draw_to(grid: Grid) -> void:
	grid.set_cell(_pos, _char, _color)
