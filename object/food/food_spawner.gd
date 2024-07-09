class_name FoodSpawner
extends Node2D

@export var inedible_time : float = 0.5
@export_enum(
	"primary",
	"secondary",
	"background",
	"highlight",
	"shadow"
) var color : int

var foods : Array[Food]


func positions() -> Array:
	return foods.map(func(c: Food) -> Vector2i: return c._pos)


func draw_to(grid: Grid) -> void:
	for food in foods:
		grid.set_cell(food._pos, food.char(), food._color)


func spawn_food(text: String, grid: Grid) -> void:
	for char_ in text:
		var pos := grid.get_free_pos()
		if pos < Vector2i.ZERO:
			print("no free space")
			return

		var food := Food.new(pos, char_, color, inedible_time)
		foods.append(food)
		add_child(food)


func clear() -> void:
	foods.clear()


func remove(food: Food) -> void:
	var idx : int = foods.find(food)
	if idx >= 0:
		foods.remove_at(idx)


func all_edible() -> bool:
	return foods.all(func(f: Food) -> bool: return f.is_edible())
