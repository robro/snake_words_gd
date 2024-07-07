class_name FoodSpawner
extends Node2D

@onready var _grid : Grid = get_parent()
var food_list : Array[Food]
var positions : Array[Vector2i]


func _ready():
	assert(_grid is Grid)


func get_positions() -> Array[Vector2i]:
	return positions


func draw_to_grid(grid: Grid):
	for food in food_list:
		grid.set_cell(food.position, food._char, food._color)


func _on_spawn_food(text: String):
	for chararcter in text:
		var pos := _grid.get_free_pos()
		if pos < Vector2i.ZERO:
			print("no free space")
			return
		var food = Food.new(pos, chararcter, Color.RED)
		food_list.append(food)
		positions.append(pos)
