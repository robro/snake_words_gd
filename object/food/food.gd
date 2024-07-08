class_name Food
extends Node2D

var _pos : Vector2i
var _char : String
var _color : Color
var timer : Timer


func _init(pos: Vector2i, text: String, color: Color, wait: float):
	assert(len(text) == 1)
	_pos = pos
	_char = text
	_color = color

	timer = Timer.new()
	timer.wait_time = wait
	timer.autostart = true
	timer.one_shot = true
	add_child(timer)


func char() -> String:
	if (timer.time_left):
		return char(randi_range(0, 26) + 97)
	else:
		return _char


func is_edible() -> bool:
	return false if (timer.time_left) else true
