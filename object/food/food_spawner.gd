class_name FoodSpawner
extends Node2D

@onready var parent_grid : Grid = get_parent()

signal food_eaten(pos: Vector2i)


func _ready():
	assert(parent_grid is Grid)


func get_positions() -> Array:
	return (get_children()
		.filter(func(c): return c is Food)
		.map(func(c): return c._pos)
	)


func draw_to_grid(grid: Grid):
	for food : Food in get_children().filter(func(c): return c is Food):
		grid.set_cell(food._pos, food._char, food._color)


func _on_spawn_food(text: String):
	for t in text:
		var pos : Vector2i = parent_grid.get_free_pos()
		if pos < Vector2i.ZERO:
			print("no free space")
			return
		var food = Food.new(pos, t, Color.RED)
		add_child(food)


func _on_food_eaten(pos: Vector2i):
	food_eaten.emit(pos)
