extends Label


func _ready() -> void:
	Palette.connect("palette_change", _on_palette_change)


func _process(_delta: float) -> void:
	text = str(Global.combo) + " combo"


func _on_game_over_state_processing(_delta: float) -> void:
	text = str(Global.max_combo) + " combo"


func _on_palette_change() -> void:
	add_theme_color_override("font_color", Palette.color[Palette.Type.SECONDARY])
