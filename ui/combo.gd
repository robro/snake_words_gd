extends Label

@export var color_type := Colors.Type.SECONDARY


func _ready() -> void:
	add_theme_color_override("font_color", Colors.palette[color_type])


func _process(_delta: float) -> void:
	add_theme_color_override("font_color", Colors.palette[color_type])
	text = str(Global.combo) + " combo"


func _on_game_over_state_processing(_delta: float) -> void:
	text = str(Global.max_combo) + " combo"
