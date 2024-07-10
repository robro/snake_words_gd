class_name Particle
extends Node2D

var _pos: Vector2i
var _colors: Array[int]
var _lifetime: float
var _timer := Timer.new()

signal is_done

func _init(pos: Vector2i, colors: Array[int], lifetime: float) -> void:
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

	for i in _colors.size():
		if i < 2:
			gradient.set_offset(i, i / float(_colors.size() - 1))
			gradient.set_color(i, Palette.color[_colors[i]])
		else:
			gradient.add_point(i / float(_colors.size() - 1), Palette.color[_colors[i]])

	return gradient.sample(((_timer.time_left / _lifetime) - 1) * -1)


func _on_timer_timeout() -> void:
	emit_signal("is_done")
	queue_free()
