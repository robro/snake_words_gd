class_name Gameplay
extends Node2D

@onready var food_spawner : FoodSpawner = $FoodSpawner
@onready var snake : Snake = $Snake
@onready var grid : Grid = $Grid
@onready var cursor : Label = $WordContainer/Cursor


func _init():
	Palette.next_palette()


func _ready():
	snake.connect("moved_to", _on_snake_moved_to)
	snake.connect("collided", _on_snake_collided)
	init_board()


func init_board():
	var color = (
		Palette.highlight
		if Global.partial_word == Global.target_word
		else Palette.shadow
	)
	for i in Global.partial_word.length():
		snake.parts[-i - 1]._color = color

	food_spawner.spawn_food(Global.target_word, grid)
	Global.partial_word = ""


func _on_snake_moved_to(pos: Vector2i):
	for food : Food in food_spawner.get_children():
		if not food.is_edible():
			continue
		if food._pos != pos:
			continue

		snake.append(Cell.new(food._char, food._color))
		Global.partial_word += food._char
		food_spawner.remove(food)
		cursor.reset()

		if not Global.target_word.begins_with(Global.partial_word):
			food_spawner.clear()
			# go to wrong word state
			init_board()
		elif Global.partial_word == Global.target_word:
			# go to correct word state
			init_board()


func _on_snake_collided():
	get_tree().reload_current_scene()
