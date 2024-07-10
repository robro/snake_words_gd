extends ColorRect


func _on_seeking_state_entered() -> void:
	color = Colors.color[Colors.Type.BACKGROUND]


func _on_word_failed_state_entered() -> void:
	color = Colors.color[Colors.Type.SECONDARY]


func _on_game_over_state_entered() -> void:
	color = Colors.color[Colors.Type.SECONDARY]
