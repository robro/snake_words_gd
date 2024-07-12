extends ColorRect

@export var _color := Colors.Type.SECONDARY


func _process(_delta: float) -> void:
	color = Colors.palette[_color]
	

func _on_seeking_state_entered() -> void:
	visible = false


func _on_word_failed_state_entered() -> void:
	visible = true


func _on_game_over_state_entered() -> void:
	visible = true
