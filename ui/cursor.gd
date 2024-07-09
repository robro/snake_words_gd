extends Label

var blink_timer := Timer.new()
var blinking := false
var color := Palette.Type.PRIMARY


func _ready():
	Palette.connect("palette_change", _on_palette_change)
	blink_timer.wait_time = 0.5
	blink_timer.timeout.connect(_on_timer_timeout)
	blink_timer.autostart = true
	add_child(blink_timer)
	set_color()


func _on_timer_timeout():
	blinking = false if blinking else true
	set_color()


func set_color():
	color = Palette.Type.BACKGROUND if blinking else Palette.Type.PRIMARY
	add_theme_color_override("font_color", Palette.colors[color])


func reset():
	blinking = false
	blink_timer.start()
	set_color()


func _on_palette_change():
	set_color()


func _on_seeking_state_processing(_delta):
	var new_text = "█".lpad(Global.partial_word.length() + 1).rpad(Global.target_word.length())
	if new_text != text:
		text = new_text
		reset()


func _on_seeking_state_exited():
	text = ""
