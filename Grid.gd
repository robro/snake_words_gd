class_name Grid
extends Node2D


## Number of rows
@export var rows : int = 12
## Number of columns
@export var cols : int = 12
## Size of each grid cell in pixels
@export var cell_size : int = 64


func _ready():
	for y in rows:
		for x in cols:
			var cell = Cell.new()
			add_child(cell)
			cell.position = Vector2(x * cell_size, y * cell_size)


func _process(_delta):
	pass


func clear():
	for cell : Cell in get_children():
		cell.text = cell.default_text


func has_position(pos: Vector2i) -> bool:
	return Rect2i(0, 0, cols, rows).has_point(pos)


func get_idx_from_pos(pos : Vector2i) -> int:
	return pos.y * cols + pos.x


func set_color(pos: Vector2i, color: Color) -> void:
	if !has_position(pos):
		return
	var cell := get_child(get_idx_from_pos(pos)) as Cell
	cell.label_settings.font_color = color


func set_char(pos: Vector2i, text: String) -> void:
	assert(len(text) == 1)
	if !has_position(pos):
		return
	var cell := get_child(get_idx_from_pos(pos)) as Cell
	cell.text = text


func set_cell(pos: Vector2i, text: String, color: Color) -> void:
	assert(len(text) == 1)
	if !has_position(pos):
		return
	var cell := get_child(get_idx_from_pos(pos)) as Cell
	cell.text = text
	cell.label_settings.font_color = color


func test():
	set_color(Vector2i(randi_range(0, cols), randi_range(0, rows)), Color.BLACK)
