extends Label

func _ready():
	add_theme_color_override("font_color", Palette.primary)


func _process(_delta):
	text = Global.partial_word.rpad(5)
