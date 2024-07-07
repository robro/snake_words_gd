class_name Food
extends Node2D

@onready var spawner : FoodSpawner = get_parent()

var _pos
var _char
var _color


func _init(pos: Vector2i, text: String, color: Color):
	_pos = pos
	_char = text
	_color = color


func _ready():
	assert(spawner is FoodSpawner)
	spawner.connect("food_eaten", _on_food_eaten)


func _on_food_eaten(pos: Vector2i):
	if pos != _pos:
		return
	# get eaten
	print("food eaten at" + str(_pos))
