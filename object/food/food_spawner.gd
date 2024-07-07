class_name FoodSpawner
extends Node2D

@onready var _grid : Grid = $"../Grid"

signal no_food


func _ready():
	child_order_changed.connect(_on_child_order_changed)

func positions() -> Array:
	return get_children().map(func(c): return c._pos)


func draw_to(grid: Grid):
	for food : Food in get_children():
		grid.set_cell(food._pos, food._char, food._color)


func spawn_food(text: String):
	for t in text:
		var pos : Vector2i = _grid.get_free_pos()
		if pos < Vector2i.ZERO:
			print("no free space")
			return
		var food = Food.new(pos, t, Palette.PRIMARY)
		add_child(food)


func clear():
	for food: Food in get_children():
		food.queue_free()


func remove(food: Food):
	food.queue_free()


func _on_child_order_changed():
	if get_children().is_empty():
		emit_signal("no_food")
