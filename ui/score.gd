extends Label

## Points per second
@export var tally_rate : float = 100.0
@export var _color := Colors.Type.SECONDARY

var tally_score : float = 0.0


func _ready() -> void:
	add_theme_color_override("font_color", Colors.palette[_color])


func _process(delta: float) -> void:
	add_theme_color_override("font_color", Colors.palette[_color])
	tally_score = min(Global.score, tally_score + tally_rate * delta)
	text = str(int(tally_score))


func _on_game_over_state_entered() -> void:
	tally_score = Global.score
