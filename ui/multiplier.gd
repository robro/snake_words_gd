extends Label


func _ready() -> void:
	Colors.connect("palette_change", _on_palette_change)


func _process(_delta: float) -> void:
	text = "x" + str(Global.multiplier)


func _on_palette_change() -> void:
	add_theme_color_override("font_color", Colors.color[Colors.Type.SECONDARY])


func _on_word_finished_state_entered() -> void:
	add_theme_color_override("font_color", Colors.color[Colors.Type.PRIMARY])


func _on_seeking_state_entered() -> void:
	add_theme_color_override("font_color", Colors.color[Colors.Type.SECONDARY])


func _on_game_over_state_entered() -> void:
	add_theme_color_override("font_color", Colors.color[Colors.Type.SECONDARY])
