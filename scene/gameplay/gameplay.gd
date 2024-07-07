extends Node2D

@onready var food_spawner : FoodSpawner = $FoodSpawner
@onready var snake : Snake = $Snake

var target_word := "snake"
var partial_word := ""


func _ready():
	snake.connect("moved_to", _on_snake_moved_to)
	food_spawner.connect("no_food", _on_food_spawner_no_food)
	_on_food_spawner_no_food()


func _on_food_spawner_no_food():
	food_spawner.spawn_food(target_word)
	var color = Color.WHITE if partial_word == target_word else Color.DARK_GRAY
	for i in range(len(partial_word)):
		snake.parts[-i - 1]._color = color
	partial_word = ""


func _on_snake_moved_to(pos: Vector2i):
	for food : Food in food_spawner.get_children():
		if food._pos == pos:
			snake.add_part(food)
			food_spawner.remove(food)
			partial_word += food._char
			if not target_word.begins_with(partial_word):
				food_spawner.clear()

			return
