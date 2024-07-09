extends Label


func _ready():
	Palette.connect("palette_change", _on_palette_change)


func _process(_delta):
	text = str(Global.combo) + " combo"


func _on_game_over_state_processing(_delta):
	text = str(Global.max_combo) + " combo"


func _on_palette_change():
	add_theme_color_override("font_color", Palette.color[Palette.SECONDARY])
