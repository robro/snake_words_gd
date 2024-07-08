extends Label

var blink_timer := Timer.new()


func _ready():
	blink_timer.wait_time = 0.5
	blink_timer.timeout.connect(blink)
	add_child(blink_timer)
	reset()


func _process(_delta):
	text = "█".lpad(Global.partial_word.length() + 1).rpad(Global.target_word.length())


func blink():
	var color = (
		Palette.BACKGROUND
		if get_theme_color("font_color") == Palette.PRIMARY
		else Palette.PRIMARY
	)
	add_theme_color_override("font_color", color)


func reset():
	add_theme_color_override("font_color", Palette.PRIMARY)
	blink_timer.start()
