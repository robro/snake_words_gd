extends Label

@export var food_spawner : FoodSpawner


func _ready() -> void:
	assert(food_spawner is FoodSpawner)
	Palette.connect("palette_change", _on_palette_change)


func _process(_delta: float) -> void:
	if food_spawner.all_edible():
		text = (Global.target_word.substr(Global.partial_word.length())
			.lpad(Global.target_word.length()))
	else:
		var scrambled := ""
		for _i in Global.target_word.length():
			scrambled += Global.rand_char()
		text = scrambled


func _on_palette_change() -> void:
	add_theme_color_override("font_color", Palette.color[Palette.Type.SECONDARY])
