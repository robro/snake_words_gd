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

var target_word := "snake"
var partial_word := ""
var timer := Timer.new()


func _init():
	Palette.PRIMARY = primary
	Palette.SECONDARY = secondary
	Palette.BACKGROUND = background
	Palette.HIGHLIGHT = highlight
	Palette.SHADOW = shadow


func _ready():
	snake.connect("moved_to", _on_snake_moved_to)
	food_spawner.connect("no_food", _on_food_spawner_no_food)
	timer.wait_time = 1
	timer.one_shot = true
	timer.timeout.connect(init_board)
	add_child(timer)
	init_board()


func init_board():
	food_spawner.spawn_food(target_word, grid)
	var color = Palette.HIGHLIGHT if partial_word == target_word else Palette.SHADOW
	for i in range(len(partial_word)):
		snake.parts[-i - 1]._color = color

	partial_word = ""


func _on_food_spawner_no_food():
	timer.start()


func _on_snake_moved_to(pos: Vector2i):
	for food : Food in food_spawner.get_children():
		if not food.is_edible():
			continue
		if food._pos != pos:
			continue

		snake.append(Cell.new(food._char, food._color))
		partial_word += food._char
		food_spawner.remove(food)

		if not target_word.begins_with(partial_word):
			food_spawner.clear()
