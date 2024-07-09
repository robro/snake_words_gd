class_name FoodSpawner
extends Node2D

@export var inedible_time : float = 0.5


func positions() -> Array:
	return get_children().map(func(c): return c._pos)


func draw_to(grid: Grid):
	for food : Food in get_children():
		grid.set_cell(food._pos, food.char(), food._color)


func spawn_food(text: String, grid: Grid):
	for char_ in text:
		var pos : Vector2i = grid.get_free_pos()
		if pos < Vector2i.ZERO:
			print("no free space")
			return

		add_child(Food.new(pos, char_, Palette.Type.PRIMARY, inedible_time))


func clear():
	for food : Food in get_children():
		remove(food)


func remove(food: Food):
	food.queue_free()
	remove_child(food)


func all_edible() -> bool:
	return get_children().all(func(f): return f.is_edible())
