extends ColorRect


func _ready() -> void:
	Palette.connect("palette_change", _on_palette_change)


func _on_palette_change() -> void:
	color = Palette.color[Palette.Type.BACKGROUND]
