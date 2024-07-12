class_name TitleSnake
extends Node2D

@export var text : String = "snake_words"
@export var color_type := Colors.Type.PRIMARY
@export var tick_time : float = 0.5
@export var start_pos : Vector2 = Vector2.ZERO
@export var horizontal_moves : int = 3
@export var vertical_moves : int = 5
@export var bounds : Rect2i = Rect2i(0, 0, 12, 12)
@export var grid : Grid

@onready var tail_position : Vector2 = start_pos
@onready var moves := rand_moves()
var tick_timer := Timer.new()
var turn_right := true
var facing_idx := 0

const facing_list = [
	Vector2.RIGHT,
	Vector2.DOWN,
	Vector2.LEFT,
	Vector2.UP,
]


func _ready() -> void:
	assert(grid is Grid)
	assert(vertical_moves > 0)

	for i in len(text):
		add_child(SnakePart.new(
			start_pos + facing_list[facing_idx] * -i,
			Cell.new(text[i], color_type),
		))

	tick_timer.wait_time = tick_time
	tick_timer.autostart = true
	tick_timer.timeout.connect(try_to_move)
	add_child(tick_timer)


func _process(_delta: float) -> void:
	for node in get_children():
		if node is SnakePart:
			grid.set_cell(
				node.position,
				node.cell.ascii,
				node.cell.color_type,
				node.cell.blend_color,
			)


func try_to_move() -> void:
	var parts := get_children().filter(
		func(c: Node) -> bool: return c is SnakePart
	)
	var next_pos : Vector2 = parts[0].position + facing_list[facing_idx]
	while not bounds.has_point(next_pos):
		turn()
		next_pos = parts[0].position + facing_list[facing_idx]

	tail_position = parts[-1].position
	if parts.size() > 1:
		for i in range(parts.size() - 2, -1, -1):
			parts[i + 1].position = parts[i].position

	parts[0].position = next_pos

	moves -= 1
	if moves == 0:
		turn()
		turn_right = false if turn_right else true


func turn() -> void:
	var direction := 1 if turn_right else -1

	facing_idx += direction
	if facing_idx < 0:
		facing_idx = 3
	else:
		facing_idx = facing_idx % 4

	moves = horizontal_moves if facing_idx % 2 == 0 else vertical_moves


func rand_moves() -> int:
	return randi_range(horizontal_moves, vertical_moves)
