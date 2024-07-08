extends Label


func _ready():
	add_theme_color_override("font_color", Palette.SECONDARY)


func _process(_delta):
	text = (Global.target_word.substr(Global.partial_word.length())
		.lpad(Global.target_word.length()))
