class_name Grid
extends Resource

@export var rows : int:
	set(v):
		rows = v
		cells.resize(rows)
@export var cols : int:
	set(v):
		cols = v
		for row in cells:
			row.resize(cols)

var cells : Array[Array] = []
signal updated


func fill(cell: Cell) -> void:
	for y in cells.size():
		for x in cells[y].size():
			set_cell(Vector2(x, y), cell.ascii, cell.color_type, cell.blend_color)


func set_cell(
	pos: Vector2,
	ascii: String,
	color_type: Colors.Type,
	blend_color: Color,
) -> void:
	if not contains(pos):
		return

	if cells[pos.y][pos.x] is Cell:
		cells[pos.y][pos.x].ascii = ascii
		cells[pos.y][pos.x].color_type = color_type
		cells[pos.y][pos.x].blend_color = blend_color
	else:
		cells[pos.y][pos.x] = Cell.new(ascii, color_type, blend_color)

	emit_signal("updated")


func set_blend_color(pos: Vector2, blend_color: Color) -> void:
	if not contains(pos) or not cells[pos.y][pos.x] is Cell:
		return

	cells[pos.y][pos.x].blend_color = cells[pos.y][pos.x].blend_color.blend(blend_color)


func contains(point: Vector2) -> bool:
	if cells.is_empty():
		return false

	return Rect2(0, 0, cells[0].size(), cells.size()).has_point(point)
