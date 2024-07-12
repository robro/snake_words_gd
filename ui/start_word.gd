extends Label

@export var flash_speed := 0.075
@export var normal_color : Colors.Type
@export var flash_color : Colors.Type
@onready var color_type := normal_color

var flash_timer := Timer.new()
var flashing : bool = false


func _ready() -> void:
	add_theme_color_override("font_color", Colors.palette[normal_color])
	flash_timer.wait_time = flash_speed
	flash_timer.timeout.connect(_on_flash_timer_timeout)
	add_child(flash_timer)


func _process(_delta: float) -> void:
	add_theme_color_override("font_color", Colors.palette[color_type])


func _on_flash_timer_timeout() -> void:
	flashing = false if flashing else true
	visible = false if flashing else true


func _on_starting_state_entered() -> void:
	color_type = flash_color
	flash_timer.start()
