extends Label

@export var food_spawner : FoodSpawner


func _ready():
	assert(food_spawner is FoodSpawner)
	add_theme_color_override("font_color", Palette.secondary)


func _process(_delta):
	if food_spawner.all_edible():
		text = (Global.target_word.substr(Global.partial_word.length())
			.lpad(Global.target_word.length()))
	else:
		var scrambled = ""
		for _i in Global.target_word.length():
			scrambled += char(randi_range(0, 25) + 97)
		text = scrambled
