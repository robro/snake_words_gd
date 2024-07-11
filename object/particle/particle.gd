class_name Particle
extends Node2D

var _pos: Vector2i
var _colors: Array[Colors.Type]
var _lifetime: float
var _timer := Timer.new()

signal is_done

func _init(pos: Vector2i, colors: Array[Colors.Type], lifetime: float) -> void:
	assert(lifetime > 0)

	_pos = pos
	_colors = colors
	_lifetime = lifetime

	_timer.wait_time = lifetime
	_timer.one_shot = true
	_timer.autostart = true
	_timer.connect("timeout", _on_timer_timeout)
	add_to_group("particles")
	add_child(_timer)


func get_color() -> Color:
	var gradient := Gradient.new()
	var color_count := _colors.size()

	gradient.colors = _colors.map(func(c: int) -> Color: return Colors.color[c])
	gradient.colors[-1].a = 0.0
	gradient.offsets = range(color_count).map(
		func(n: int) -> float: return n / float(color_count - 1)
	)
	gradient.interpolation_mode = Gradient.GRADIENT_INTERPOLATE_CUBIC
	return gradient.sample(((_timer.time_left / _lifetime) - 1) * -1)


func _on_timer_timeout() -> void:
	emit_signal("is_done")
	queue_free()
