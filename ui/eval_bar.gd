extends ColorRect


func _on_seeking_state_entered():
	color = Palette.colors[Palette.Type.BACKGROUND]


func _on_word_failed_state_entered():
	color = Palette.colors[Palette.Type.SECONDARY]


func _on_game_over_state_entered():
	color = Palette.colors[Palette.Type.SECONDARY]
