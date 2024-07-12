extends Label

@export var _color := Colors.Type.SECONDARY
@export var food_spawner : FoodSpawner


func _ready() -> void:
	assert(food_spawner is FoodSpawner)
	add_theme_color_override("font_color", Colors.palette[_color])


func _process(_delta: float) -> void:
	add_theme_color_override("font_color", Colors.palette[_color])

	if food_spawner.all_edible():
		text = (Global.target_word.substr(Global.partial_word.length())
			.lpad(Global.target_word.length()))
	else:
		var scrambled := ""
		for _i in Global.target_word.length():
			scrambled += Global.rand_char()
		text = scrambled
