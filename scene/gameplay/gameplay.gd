class_name Gameplay
extends Node2D

@export_group("Colors")
@export var primary := Color.RED
@export var secondary := Color.DARK_RED
@export var background := Color.BLACK
@export var highlight := Color.WHITE_SMOKE
@export var shadow := Color.DIM_GRAY

@onready var food_spawner : FoodSpawner = $FoodSpawner
@onready var snake : Snake = $Snake
@onready var grid : Grid = $Grid
@onready var cursor : Label = $WordContainer/Cursor


func _init():
	Palette.PRIMARY = primary
	Palette.SECONDARY = secondary
	Palette.BACKGROUND = background
	Palette.HIGHLIGHT = highlight
	Palette.SHADOW = shadow


func _ready():
	snake.connect("moved_to", _on_snake_moved_to)
	init_board()


func init_board():
	var color = (
		Palette.HIGHLIGHT
		if Global.partial_word == Global.target_word
		else Palette.SHADOW
	)
	for i in range(len(Global.partial_word)):
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
