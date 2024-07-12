class_name Food
extends Node2D

var cell : Cell
var inedible_timer := Timer.new()


func _init(_position: Vector2, _cell: Cell, _inedible_time: float) -> void:
	assert(_inedible_time > 0)

	position = _position
	cell = _cell

	inedible_timer.wait_time = _inedible_time
	inedible_timer.autostart = true
	inedible_timer.one_shot = true

	add_child(inedible_timer)
	add_to_group("physical")
	add_to_group("food")


func get_char() -> String:
	return Global.rand_char() if inedible_timer.time_left else cell.ascii


func is_edible() -> bool:
	return false if inedible_timer.time_left else true
