extends Label

## Points per second
@export var tally_rate : float = 100.0

var tally_score : float = 0.0


func _ready():
	add_theme_color_override("font_color", Palette.secondary)


func _process(delta):
	tally_score = min(Global.score, tally_score + tally_rate * delta)
	text = str(int(tally_score))
