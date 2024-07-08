extends Label


func _ready():
	add_theme_color_override("font_color", Palette.secondary)


func _process(_delta):
	text = "x" + str(Global.multiplier)