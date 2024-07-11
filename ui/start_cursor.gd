extends Label

@export var blink_speed := 0.5
@export var on_color : Colors.Type
@export var off_color : Colors.Type

var blink_timer := Timer.new()
var blinking := false


func _ready() -> void:
	blink_timer.wait_time = blink_speed
	blink_timer.timeout.connect(_on_timer_timeout)
	blink_timer.autostart = true
	add_child(blink_timer)


func _process(_delta: float) -> void:
	add_theme_color_override(
		"font_color",
		Colors.color[off_color if blinking else on_color]
	)


func _on_timer_timeout() -> void:
	blinking = false if blinking else true


func _on_starting_state_entered() -> void:
	visible = false
