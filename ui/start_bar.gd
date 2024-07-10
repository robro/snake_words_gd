extends ColorRect


func _ready() -> void:
	Colors.connect("palette_change", _on_palette_change)


func _on_palette_change() -> void:
	color = Colors.color[Colors.Type.BACKGROUND]
