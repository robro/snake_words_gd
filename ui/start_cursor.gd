extends Label

@export var blink_speed := 0.5

var blink_timer := Timer.new()
var blinking := false
var color := Palette.SHADOW


func _ready() -> void:
	blink_timer.wait_time = blink_speed
	blink_timer.timeout.connect(_on_timer_timeout)
	blink_timer.autostart = true
	add_child(blink_timer)
	set_color()


func set_color() -> void:
	color = Palette.BACKGROUND if blinking else Palette.SHADOW
	add_theme_color_override("font_color", Palette.color[color])


func _on_timer_timeout() -> void:
	blinking = false if blinking else true
	set_color()


func _on_starting_state_entered() -> void:
	visible = false
