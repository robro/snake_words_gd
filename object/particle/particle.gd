class_name Particle
extends Node2D

var color_types: Array[Colors.Type]
var lifetime: float
var life_timer := Timer.new()

signal is_done

func _init(
	_position: Vector2,
	_color_types: Array[Colors.Type],
	_lifetime: float
) -> void:
	assert(_lifetime > 0)

	position = _position
	color_types = _color_types
	lifetime = _lifetime

	life_timer.wait_time = lifetime
	life_timer.one_shot = true
	life_timer.autostart = true
	life_timer.connect("timeout", _on_life_timer_timeout)
	add_to_group("particles")
	add_child(life_timer)


func get_color() -> Color:
	var gradient := Gradient.new()
	var color_count := color_types.size()

	gradient.colors = color_types.map(
		func(c: int) -> Color: return Colors.palette[c]
	)
	gradient.colors[-1].a = 0
	gradient.offsets = range(color_count).map(
		func(n: int) -> float: return n / float(color_count - 1)
	)
	gradient.interpolation_mode = Gradient.GRADIENT_INTERPOLATE_CUBIC
	return gradient.sample(((life_timer.time_left / lifetime) - 1) * -1)


func _on_life_timer_timeout() -> void:
	emit_signal("is_done")
	queue_free()
