extends Label

func _ready():
	Palette.connect("palette_change", _on_palette_change)


func _process(_delta):
	text = Global.partial_word.rpad(Global.target_word.length())


func _on_palette_change():
	add_theme_color_override("font_color", Palette.colors[Palette.Type.PRIMARY])
