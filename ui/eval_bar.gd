extends ColorRect


func _on_seeking_state_entered() -> void:
	color = Palette.color[Palette.Type.BACKGROUND]


func _on_word_failed_state_entered() -> void:
	color = Palette.color[Palette.Type.SECONDARY]


func _on_game_over_state_entered() -> void:
	color = Palette.color[Palette.Type.SECONDARY]
