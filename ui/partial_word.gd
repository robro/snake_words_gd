extends Label

@export var flash_speed := 0.075
@export var blink_speed := 0.5
@export var normal_color := Colors.Type.PRIMARY
@export var success_color := Colors.Type.HIGHLIGHT
@export var failure_color := Colors.Type.BACKGROUND
@onready var color_type := normal_color

var flash_timer := Timer.new()


func _ready() -> void:
	add_theme_color_override("font_color", Colors.palette[color_type])
	flash_timer.timeout.connect(_on_timer_timeout)
	add_child(flash_timer)


func _process(_delta: float) -> void:
	text = Global.partial_word.rpad(Global.target_word.length())
	add_theme_color_override("font_color", Colors.palette[color_type])


func _on_seeking_state_entered() -> void:
	color_type = normal_color
	visible = true


func _on_timer_timeout() -> void:
	visible = false if visible else true


func _on_word_finished_state_entered() -> void:
	color_type = success_color
	flash_timer.wait_time = flash_speed
	flash_timer.start()


func _on_word_failed_state_entered() -> void:
	color_type = failure_color
	flash_timer.wait_time = flash_speed
	flash_timer.start()


func _on_game_over_state_entered() -> void:
	color_type = failure_color
	flash_timer.wait_time = blink_speed
	flash_timer.start()


func _on_word_finished_state_exited() -> void:
	flash_timer.stop()


func _on_word_failed_state_exited() -> void:
	flash_timer.stop()
