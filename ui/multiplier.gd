extends Label


func _ready():
	Palette.connect("palette_change", _on_palette_change)


func _process(_delta):
	text = "x" + str(Global.multiplier)


func _on_palette_change():
	add_theme_color_override("font_color", Palette.color[Palette.SECONDARY])


func _on_word_finished_state_entered():
	add_theme_color_override("font_color", Palette.color[Palette.PRIMARY])


func _on_seeking_state_entered():
	add_theme_color_override("font_color", Palette.color[Palette.SECONDARY])
