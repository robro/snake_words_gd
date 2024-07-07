class_name Grid
extends Node2D

## Number of rows
@export var rows : int = 12
## Number of columns
@export var cols : int = 12
## Size of each grid cell in pixels
@export_range(0, 100, 1, "suffix:px") var cell_size : int = 64
## Font of all characters
@export var font : Font
## Represents an empty cell
@export var empty_char : String = '.'

var cells : Array[Cell]
var grid_color : Color


func _ready():
	assert(font is Font)
	for y in rows:
		for x in cols:
			var cell = Cell.new()
			cells.append(cell)
			cell.position = Vector2(x * cell_size, y * cell_size)


func _process(_delta):
	clear()
	for child in get_children():
		if child.has_method("draw_to_grid"):
			child.draw_to_grid(self)

	queue_redraw()


func _draw():
	for cell in cells:
		draw_char(font, cell.position, cell._char, cell_size, cell._color)


func clear():
	for cell in cells:
		cell._char = empty_char
		cell._color = grid_color


func in_grid(pos: Vector2i) -> bool:
	return Rect2i(0, 0, cols, rows).has_point(pos)


func get_idx_from_pos(pos : Vector2i) -> int:
	return pos.y * cols + pos.x


func set_color(pos: Vector2i, color: Color) -> void:
	if not in_grid(pos):
		return
	var cell := cells[get_idx_from_pos(pos)]
	cell._color = color


func set_char(pos: Vector2i, text: String) -> void:
	assert(len(text) == 1)
	if not in_grid(pos):
		return
	var cell := cells[get_idx_from_pos(pos)]
	cell.text = text


func set_cell(pos: Vector2i, text: String, color: Color) -> void:
	assert(len(text) == 1)
	if not in_grid(pos):
		return
	var cell := cells[get_idx_from_pos(pos)]
	cell._char = text
	cell._color = color
