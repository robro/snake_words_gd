extends Label

@export var _flash_speed := 0.075
@export var _normal_color : Colors.Type
@export var _flash_color : Colors.Type
@onready var _color := _normal_color

var _flash_timer := Timer.new()
var _flashing : bool = false


func _ready() -> void:
	add_theme_color_override("font_color", Colors.color[_normal_color])
	_flash_timer.wait_time = _flash_speed
	_flash_timer.timeout.connect(_on_flash_timer_timeout)
	add_child(_flash_timer)


func _process(_delta: float) -> void:
	add_theme_color_override("font_color", Colors.color[_color])


func _on_flash_timer_timeout() -> void:
	_flashing = false if _flashing else true
	visible = false if _flashing else true


func _on_starting_state_entered() -> void:
	_color = _flash_color
	_flash_timer.start()
