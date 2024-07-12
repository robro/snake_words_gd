class_name GridRenderer
extends Node2D

@export var font : Font
@export var font_size : int = 64
@export var cell_size : int = 64
@export var grid_color := Colors.Type.BACKGROUND
@export var empty_char := "."
@export var grid : Grid

@onready var empty_cell := Cell.new(empty_char, grid_color)
@onready var offset := Vector2(cell_size / 4, cell_size - cell_size / 4)


func _init() -> void:
	process_priority = -10


func _ready() -> void:
	assert(font is Font)
	assert(grid is Grid)
	grid.connect("updated", _on_grid_updated)


func _process(_delta: float) -> void:
	grid.fill(empty_cell)


func _on_grid_updated() -> void:
	queue_redraw()


func _draw() -> void:
	for y in grid.cells.size():
		for x in grid.cells[y].size():
			if grid.cells[y][x] is Cell:
				draw_char(
					font,
					Vector2(x, y) * cell_size + offset,
					grid.cells[y][x].ascii,
					font_size,
					(Colors.palette[grid.cells[y][x].color_type]
						.blend(grid.cells[y][x].blend_color))
				)
