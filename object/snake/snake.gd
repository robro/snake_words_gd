class_name Snake
extends Node2D

@export var text := "snake"
@export var facing := Facing.RIGHT
@export var init_position := Vector2.ZERO
@export var color_type := Colors.Type.HIGHLIGHT
@export var tick_time := 0.5
@export var grid : Grid

@onready var next_facing := facing
@onready var tail_position := init_position
var is_alive := true
var tick_timer := Timer.new()

enum Facing {
	UP,
	DOWN,
	LEFT,
	RIGHT,
}

const offset = {
	Facing.UP: Vector2.UP,
	Facing.DOWN: Vector2.DOWN,
	Facing.LEFT: Vector2.LEFT,
	Facing.RIGHT: Vector2.RIGHT,
}

signal moved_to(p: Vector2)
signal collided


func _ready() -> void:
	assert(grid is Grid)

	for i in text.length():
		add_child(SnakePart.new(
			init_position + offset[facing] * -i,
			Cell.new(text[i], color_type)
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


func _input(event: InputEvent) -> void:
	if not is_alive:
		return

	if event.is_action_pressed("Up") and facing != Facing.DOWN:
		next_facing = Facing.UP
	elif event.is_action_pressed("Down") and facing != Facing.UP:
		next_facing = Facing.DOWN
	elif event.is_action_pressed("Left") and facing != Facing.RIGHT:
		next_facing = Facing.LEFT
	elif event.is_action_pressed("Right") and facing != Facing.LEFT:
		next_facing = Facing.RIGHT


func try_to_move() -> void:
	facing = next_facing
	var parts := get_children().filter(
		func(node: Node) -> bool: return node is SnakePart
	)
	var next_pos : Vector2 = parts[0].position + offset[facing]
	if not grid.contains(next_pos):
		emit_signal("collided")
		return

	for part : SnakePart in parts:
		if next_pos == part.position:
			emit_signal("collided")
			return

	tail_position = parts[-1].position
	if parts.size() > 1:
		for i in range(parts.size() - 2, -1, -1):
			parts[i + 1].position = parts[i].position

	parts[0].position = next_pos
	emit_signal("moved_to", next_pos)


func append(cell: Cell) -> void:
	add_child(SnakePart.new(tail_position, cell))
