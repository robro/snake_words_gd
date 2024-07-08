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
	Palette.HIGHLIGHT = highlight
	Palette.PRIMARY = primary
	Palette.SECONDARY = secondary
	Palette.BACKGROUND = background
	Palette.SHADOW = shadow


func _ready():
	snake.connect("moved_to", _on_snake_moved_to)
	food_spawner.connect("no_food", _on_food_spawner_no_food)
	timer.wait_time = 1
	timer.one_shot = true
	timer.timeout.connect(_on_timer_timeout)
	add_child(timer)
	_on_timer_timeout()


func _on_food_spawner_no_food():
	timer.start()


func _on_snake_moved_to(pos: Vector2i):
	for food : Food in food_spawner.get_children():
		if food.is_edible() and food._pos == pos:
			snake.add_part(food)
			food_spawner.remove(food)
			partial_word += food._char
			if not target_word.begins_with(partial_word):
				food_spawner.clear()


func _on_timer_timeout():
	food_spawner.spawn_food(target_word, grid)
	var color = Palette.HIGHLIGHT if partial_word == target_word else Palette.SHADOW
	for i in range(len(partial_word)):
		snake.parts[-i - 1]._color = color
	partial_word = ""
