class_name SplashProperties
extends Resource

@export var _start_size: int
@export var _max_size: int
@export var _tick: float
@export var _lifetime: float
@export var _colors: Array[Palette.Type]


func _init(
	start_size: int = 1,
	max_size: int = 5,
	tick: float = 0.04,
	lifetime: float = 0.4,
	colors: Array[Palette.Type] = [Palette.Type.PRIMARY, Palette.Type.BACKGROUND],
) -> void:
	_start_size = start_size
	_max_size = max_size
	_tick = tick
	_lifetime = lifetime
	_colors = colors
