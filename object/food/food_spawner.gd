class_name FoodSpawner
extends Node2D

@export var inedible_time := 0.5
@export var color_type := Colors.Type.PRIMARY
@export var grid : Grid


func _ready() -> void:
	assert(grid is Grid)


func _process(_delta: float) -> void:
	for node in get_children():
		if node is Food:
			grid.set_cell(
				node.position,
				node.get_char(),
				node.cell.color_type,
				node.cell.blend_color,
			)


func spawn_food(text: String) -> void:
	for ascii in text:
		var pos := get_free_pos()
		if pos < Vector2.ZERO:
			print("no free space")
			return

		add_child(Food.new(pos, Cell.new(ascii, color_type), inedible_time))


func clear() -> void:
	for node in get_children():
		if node is Food:
			node.queue_free()


func all_edible() -> bool:
	for node in get_children():
		if node is Food and not node.is_edible():
			return false

	return true


func get_free_pos() -> Vector2:
	var occupied := get_tree().get_nodes_in_group("physical").map(
		func(n: Node) -> Vector2: return n.position
	)
	var free : Array[Vector2] = []
	for y in grid.cells.size():
		for x in grid.cells[y].size():
			var try_pos := Vector2(x, y)
			var try_idx := occupied.find(try_pos)
			if try_idx == -1:
				free.append(try_pos)
			else:
				occupied.remove_at(try_idx)

	if free.is_empty():
		return Vector2(-1, -1)

	return free[randi_range(0, free.size() - 1)]
