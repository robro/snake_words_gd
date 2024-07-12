extends ColorRect

@export var color_type := Colors.Type.SECONDARY


func _process(_delta: float) -> void:
	color = Colors.palette[color_type]
	

func _on_seeking_state_entered() -> void:
	visible = false


func _on_word_failed_state_entered() -> void:
	visible = true


func _on_game_over_state_entered() -> void:
	visible = true
