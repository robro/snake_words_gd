extends Label

## Points per second
@export var tally_rate : float = 100.0

var tally_score : float = 0.0


func _ready():
	Palette.connect("palette_change", _on_palette_change)


func _process(delta):
	tally_score = min(Global.score, tally_score + tally_rate * delta)
	text = str(int(tally_score))


func _on_palette_change():
	add_theme_color_override("font_color", Palette.colors[Palette.Type.SECONDARY])
