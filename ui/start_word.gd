extends Label

@export var flash_speed := 0.075
@export var _color : Palette.Type

var flash_timer := Timer.new()
var flashing : bool = false


func _ready() -> void:
	Palette.connect("palette_change", _on_palette_change)
	add_theme_color_override("font_color", Palette.color[_color])
	flash_timer.wait_time = flash_speed
	flash_timer.timeout.connect(_on_flash_timer_timeout)
	add_child(flash_timer)


func _on_flash_timer_timeout() -> void:
	flashing = false if flashing else true
	var color := Palette.Type.HIGHLIGHT if flashing else Palette.Type.BACKGROUND
	add_theme_color_override("font_color", Palette.color[color])


func _on_starting_state_entered() -> void:
	flashing = true
	add_theme_color_override("font_color", Palette.color[Palette.Type.HIGHLIGHT])
	flash_timer.start()


func _on_palette_change() -> void:
	add_theme_color_override("font_color", Palette.color[_color])
