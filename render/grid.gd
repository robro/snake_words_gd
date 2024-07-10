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

@onready var char_offset := Vector2i(cell_size / 4, cell_size - cell_size / 4)

var grid_color := Palette.SECONDARY
var cells : Array[Cell]


func _ready() -> void:
	assert(font is Font)
	for i in range(rows * cols):
		cells.append(Cell.new(empty_char, grid_color))


func _process(_delta: float) -> void:
	clear()
	for p in get_tree().get_nodes_in_group("particles"):
		if p is Particle and contains(p._pos):
			cells[idx_from_pos(p._pos)]._add_color += p.get_color()

	var drawables := get_tree().get_nodes_in_group("drawable")
	drawables.sort_custom(func(a: Node2D, b: Node2D) -> bool: return a.z_index < b.z_index)
	for node in drawables:
		node.draw_to(self)

	queue_redraw()


func _draw() -> void:
	for i in cells.size():
		draw_char(
			font,
			pos_from_idx(i) * cell_size + char_offset,
			cells[i]._char,
			cell_size,
			Palette.color[cells[i]._color] + cells[i]._add_color
		)


func clear() -> void:
	for cell in cells:
		cell._char = empty_char
		cell._color = grid_color
		cell._add_color = Color.BLACK


func contains(pos: Vector2i) -> bool:
	return Rect2i(0, 0, cols, rows).has_point(pos)


func get_free_pos() -> Vector2i:
	var occupied : Array[int] = []
	for node in get_tree().get_nodes_in_group("drawable"):
		if contains(node._pos):
			occupied.append(idx_from_pos(node._pos))

	var free := range(cols * rows)
	for idx in occupied:
		free.erase(idx)

	if free.is_empty():
		return Vector2i(-1, -1)

	return pos_from_idx(free[randi_range(0, len(free) - 1)])


func idx_from_pos(pos : Vector2i) -> int:
	return pos.y * cols + pos.x


func pos_from_idx(idx: int) -> Vector2i:
	return Vector2i(idx % cols, idx / cols)


func set_cell(pos: Vector2i, text: String, color: int, add_color: Color = Color.BLACK) -> void:
	assert(len(text) == 1)
	if not contains(pos):
		return
	var cell := cells[idx_from_pos(pos)]
	cell._char = text
	cell._color = color
	cell._add_color = add_color


func _on_game_over_state_entered() -> void:
	grid_color = Palette.BACKGROUND
