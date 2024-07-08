extends Label

var blink_timer := Timer.new()


func _ready():
	blink_timer.wait_time = 0.5
	blink_timer.timeout.connect(blink)
	add_child(blink_timer)
	reset()


func _process(_delta):
	var new_text = "█".lpad(Global.partial_word.length() + 1).rpad(Global.target_word.length())
	if new_text != text:
		text = new_text
		reset()


func blink():
	var color = (
		Palette.background
		if get_theme_color("font_color") == Palette.primary
		else Palette.primary
	)
	add_theme_color_override("font_color", color)


func reset():
	add_theme_color_override("font_color", Palette.primary)
	blink_timer.start()
