extends Label

@onready var food_spawner = $"../../FoodSpawner"


func _ready():
	add_theme_color_override("font_color", Palette.secondary)


func _process(_delta):
	if food_spawner.all_edible():
		text = (Global.target_word.substr(Global.partial_word.length())
			.lpad(Global.target_word.length()))
	else:
		var scrambled = ""
		for food : Food in food_spawner.get_children():
			scrambled += food.char()
		text = scrambled
