extends Node2D

@onready var food_spawner : FoodSpawner = $FoodSpawner
@onready var snake : Snake = $Snake


func _ready():
	snake.connect("moved_to", _on_snake_moved_to)
	food_spawner.connect("no_food", _on_food_spawner_no_food)
	_on_food_spawner_no_food()


func _on_food_spawner_no_food():
	food_spawner.spawn_food("snake")


func _on_snake_moved_to(pos: Vector2i):
	for food : Food in food_spawner.get_children():
		if food._pos == pos:
			snake.add_part(food)
			food_spawner.remove(food)
			return
