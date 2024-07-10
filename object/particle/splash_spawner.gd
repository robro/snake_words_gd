class_name SplashSpawner
extends Node2D

@export var _interval : float = 3.0
@export var _grid : Grid
@export var _title_snake : TitleSnake
@export var _colors : Array[int]

var _timer := Timer.new()


func _ready() -> void:
	assert(_grid is Grid)
	assert(_title_snake is TitleSnake)

	_timer.wait_time = _interval
	_timer.autostart = true
	_timer.connect("timeout", _on_timer_timeout)
	add_child(_timer)
	add_to_group("emitters")


func _on_timer_timeout() -> void:
	Palette.next_palette()
	add_child(Splash.new(
		_grid,
		_title_snake.get_children().filter(
			func(c: Node) -> bool: return c is SnakePart
		)[0]._pos,
		1,
		30,
		0.1,
		_colors,
		1
	))
