class_name Grid
extends Node2D

@export var _rows : int = 12
@export var _cols : int = 12
@export_range(0, 100, 1, "suffix:px") var _cell_size : int = 64
@export var _empty_text : String = "."
@export_enum(
	"primary",
	"secondary",
	"background",
	"highlight",
	"shadow"
) var _color : int = 1
@export var _font : Font
@onready var _offset := Vector2i(_cell_size / 4, _cell_size - _cell_size / 4)

var _cells : Array[Cell]


func _ready() -> void:
	assert(_font is Font)
	for i in range(_rows * _cols):
		_cells.append(Cell.new(_empty_text[i % _empty_text.length()], _color))


func _process(_delta: float) -> void:
	fill(_empty_text)
	for p in get_tree().get_nodes_in_group("particles"):
		if p is Particle and contains(p._pos):
			_cells[idx_from_pos(p._pos)]._add_color += p.get_color()

	var drawables := get_tree().get_nodes_in_group("drawable")
	drawables.sort_custom(
		func(a: Node2D, b: Node2D) -> bool: return a.z_index < b.z_index
	)
	for node in drawables:
		node.draw_to(self)

	queue_redraw()


func _draw() -> void:
	for i in _cells.size():
		draw_char(
			_font,
			pos_from_idx(i) * _cell_size + _offset,
			_cells[i]._char,
			_cell_size,
			Palette.color[_cells[i]._color] + _cells[i]._add_color
		)


func fill(text: String) -> void:
	for i in _cells.size():
		_cells[i]._char = text[i % text.length()]
		_cells[i]._color = _color
		_cells[i]._add_color = Color.BLACK


func contains(pos: Vector2i) -> bool:
	return Rect2i(0, 0, _cols, _rows).has_point(pos)


func get_free_pos() -> Vector2i:
	var occupied : Array[int] = []
	for node in get_tree().get_nodes_in_group("drawable"):
		if contains(node._pos):
			occupied.append(idx_from_pos(node._pos))

	var free := range(_cols * _rows)
	for idx in occupied:
		free.erase(idx)

	if free.is_empty():
		return Vector2i(-1, -1)

	return pos_from_idx(free[randi_range(0, len(free) - 1)])


func idx_from_pos(pos : Vector2i) -> int:
	return pos.y * _cols + pos.x


func pos_from_idx(idx: int) -> Vector2i:
	return Vector2i(idx % _cols, idx / _cols)


func set_cell(
	pos: Vector2i,
	text: String,
	color: int,
	add_color: Color = Color.BLACK
) -> void:
	assert(text.length() == 1)
	if not contains(pos):
		return
	var cell := _cells[idx_from_pos(pos)]
	cell._char = text
	cell._color = color
	cell._add_color = add_color


func _on_game_over_state_entered() -> void:
	_color = Palette.BACKGROUND
