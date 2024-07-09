class_name Particle
extends Node2D

var _pos: Vector2i
var _color: int
var _lifetime: float
var _timer := Timer.new()

signal is_done

func _init(pos: Vector2i, color: int, lifetime: float) -> void:
	assert(lifetime > 0)
	assert(color >= 0 and color < Palette.color.size())

	_pos = pos
	_color = color
	_lifetime = lifetime

	_timer.wait_time = lifetime
	_timer.one_shot = true
	_timer.autostart = true
	_timer.connect("timeout", _on_timer_timeout)
	add_to_group("particles")
	add_child(_timer)


func get_color() -> Color:
	return Color.BLACK.lerp(Palette.color[_color], _timer.time_left / _lifetime)


func _on_timer_timeout() -> void:
	emit_signal("is_done")
	queue_free()
