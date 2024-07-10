extends Label

@export var blink_speed := 0.5
@export_enum(
	"primary",
	"secondary",
	"background",
	"highlight",
	"shadow"
) var _color : int

var blink_timer := Timer.new()
var blinking := false


func _ready() -> void:
	Palette.connect("palette_change", _on_palette_change)
	blink_timer.wait_time = blink_speed
	blink_timer.timeout.connect(_on_timer_timeout)
	blink_timer.autostart = true
	add_child(blink_timer)
	set_color()


func set_color() -> void:
	var color := Palette.BACKGROUND if blinking else _color
	add_theme_color_override("font_color", Palette.color[color])


func _on_timer_timeout() -> void:
	blinking = false if blinking else true
	set_color()


func _on_starting_state_entered() -> void:
	visible = false


func _on_palette_change() -> void:
	set_color()