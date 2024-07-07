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


func _ready():
	assert(font is Font)
	for y in rows:
		for x in cols:
			var cell = Cell.new(empty_char, Palette.SECONDARY)
			add_child(cell)


func _process(_delta):
	clear()
	var drawables = get_tree().get_nodes_in_group("drawable")
	drawables.sort_custom(func(a, b): return a.z_index < b.z_index)
	for node in drawables:
		node.draw_to(self)

	queue_redraw()


func _draw():
	var i: int = 0
	for cell : Cell in get_children():
		var pos = pos_from_idx(i) * cell_size
		draw_rect(Rect2(pos.x, pos.y, cell_size, cell_size,), Palette.BACKGROUND)
		draw_char(font, pos + char_offset, cell._char, cell_size, cell._color)
		i += 1


func clear():
	for cell: Cell in get_children():
		cell._char = empty_char
		cell._color = Palette.SECONDARY


func in_grid(pos: Vector2i) -> bool:
	return Rect2i(0, 0, cols, rows).has_point(pos)


func get_free_pos() -> Vector2i:
	var occupied : Array[int] = []
	for node in get_tree().get_nodes_in_group("drawable"):
		if node.has_method("positions"):
			for pos in node.positions():
				if in_grid(pos):
					occupied.append(idx_from_pos(pos))

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


func set_color_at(pos: Vector2i, color: Color) -> void:
	if not in_grid(pos):
		return
	var cell : Cell = get_children()[idx_from_pos(pos)]
	cell._color = color


func set_char_at(pos: Vector2i, text: String) -> void:
	assert(len(text) == 1)
	if not in_grid(pos):
		return
	var cell : Cell = get_children()[idx_from_pos(pos)]
	cell.text = text


func set_cell(pos: Vector2i, text: String, color: Color) -> void:
	assert(len(text) == 1)
	if not in_grid(pos):
		return
	var cell : Cell = get_children()[idx_from_pos(pos)]
	cell._char = text
	cell._color = color
