class_name Food
extends Node2D

var _pos : Vector2i
var _char : String
var _color : int
var _timer := Timer.new()


func _init(pos: Vector2i, text: String, color: int, wait: float) -> void:
	assert(len(text) == 1)
	assert(color >= 0 and color < Palette.color.size())
	assert(wait > 0)

	_pos = pos
	_char = text
	_color = color

	_timer.wait_time = wait
	_timer.autostart = true
	_timer.one_shot = true
	add_child(_timer)
	add_to_group("drawable")
	add_to_group("food")


func get_char() -> String:
	if _timer.time_left:
		return Global.rand_char()
	else:
		return _char


func is_edible() -> bool:
	return false if (_timer.time_left) else true


func draw_to(grid: Grid) -> void:
	grid.set_cell(_pos, get_char(), _color)
