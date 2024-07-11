class_name FoodSpawner
extends Node2D

@export var inedible_time : float = 0.5
@export var _color := Colors.Type.PRIMARY


func spawn_food(text: String, grid: Grid) -> void:
	for char_ in text:
		var pos := grid.get_free_pos()
		if pos < Vector2i.ZERO:
			print("no free space")
			return

		add_child(Food.new(pos, char_, _color, inedible_time))


func clear() -> void:
	for node in get_children():
		if node is Food:
			node.queue_free()


func all_edible() -> bool:
	for node in get_children():
		if node is Food and not node.is_edible():
			return false

	return true
