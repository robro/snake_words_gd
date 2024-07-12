class_name Grid
extends Resource

@export var rows : int = 12
@export var cols : int = 12

var cells : Array[Array] = []
signal updated


func _init() -> void:
	for y in rows:
		var row : Array[Cell] = []
		for x in cols:
			row.append(Cell.new())
		cells.append(row)


func fill(cell: Cell) -> void:
	for y in rows:
		for x in cols:
			cells[y][x].ascii = cell.ascii
			cells[y][x].color_type = cell.color_type
			cells[y][x].blend_color = cell.blend_color


func set_cell(
	pos: Vector2,
	ascii: String,
	color_type: Colors.Type,
	blend_color: Color,
) -> void:
	if contains(pos):
		cells[pos.y][pos.x].ascii = ascii
		cells[pos.y][pos.x].color_type = color_type
		cells[pos.y][pos.x].blend_color = blend_color
		emit_signal("updated")


func set_blend_color(pos: Vector2, blend_color: Color) -> void:
	if contains(pos):
		cells[pos.y][pos.x].blend_color = cells[pos.y][pos.x].blend_color.blend(blend_color)


func contains(point: Vector2) -> bool:
	return Rect2(0, 0, cols, rows).has_point(point)
