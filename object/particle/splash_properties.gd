class_name SplashProperties
extends Resource

@export var start_size: int
@export var max_size: int
@export var tick_time: float
@export var lifetime: float
@export var color_types: Array[Colors.Type]


func _init(
	_start_size: int = 1,
	_max_size: int = 5,
	_tick_time: float = 0.04,
	_lifetime: float = 0.4,
	_color_types: Array[Colors.Type] = [Colors.Type.PRIMARY, Colors.Type.BACKGROUND],
) -> void:
	start_size = _start_size
	max_size = _max_size
	tick_time = _tick_time
	lifetime = _lifetime
	color_types = _color_types
