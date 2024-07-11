extends Label

@export var _flash_speed := 0.075
@export var _blink_speed := 0.5
@export var _normal_color := Colors.Type.PRIMARY
@export var _success_color := Colors.Type.HIGHLIGHT
@export var _failure_color := Colors.Type.BACKGROUND
@onready var _color := _normal_color

var _timer := Timer.new()


func _ready() -> void:
	add_theme_color_override("font_color", Colors.color[_color])
	_timer.timeout.connect(_on_timer_timeout)
	add_child(_timer)


func _process(_delta: float) -> void:
	text = Global.partial_word.rpad(Global.target_word.length())
	add_theme_color_override("font_color", Colors.color[_color])


func _on_seeking_state_entered() -> void:
	_color = _normal_color
	visible = true


func _on_timer_timeout() -> void:
	visible = false if visible else true


func _on_word_finished_state_entered() -> void:
	_color = _success_color
	_timer.wait_time = _flash_speed
	_timer.start()


func _on_word_failed_state_entered() -> void:
	_color = _failure_color
	_timer.wait_time = _flash_speed
	_timer.start()


func _on_game_over_state_entered() -> void:
	_color = _failure_color
	_timer.wait_time = _blink_speed
	_timer.start()


func _on_word_finished_state_exited() -> void:
	_timer.stop()


func _on_word_failed_state_exited() -> void:
	_timer.stop()
