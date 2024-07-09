class_name Snake
extends Node2D

@export var text : String = "snake"
@export var facing : Facing = Facing.RIGHT
@export var tick : float = 0.5
@export var start_pos : Vector2i = Vector2i.ZERO
@onready var next_facing := facing
@onready var tail : Vector2i = start_pos
@onready var grid : Grid = $"../Grid"

var alive := true

enum Facing {
	UP,
	DOWN,
	LEFT,
	RIGHT,
}

const offset = {
	Facing.UP: Vector2i.UP,
	Facing.DOWN: Vector2i.DOWN,
	Facing.LEFT: Vector2i.LEFT,
	Facing.RIGHT: Vector2i.RIGHT,
}

var timer : Timer
var parts : Array[Cell]
var _positions : Array[Vector2i]

signal moved_to(p: Vector2i)
signal collided


func _ready():
	assert(grid is Grid)

	for i in len(text):
		parts.append(Cell.new(text[i], Palette.Type.HIGHLIGHT))
		_positions.append(start_pos + offset[facing] * -i)

	timer = Timer.new()
	timer.wait_time = tick
	timer.autostart = true
	timer.timeout.connect(try_to_move)
	add_child(timer)


func _input(event):
	if not alive:
		return
		
	if event.is_action_pressed("Up") and facing != Facing.DOWN:
		next_facing = Facing.UP
	elif event.is_action_pressed("Down") and facing != Facing.UP:
		next_facing = Facing.DOWN
	elif event.is_action_pressed("Left") and facing != Facing.RIGHT:
		next_facing = Facing.LEFT
	elif event.is_action_pressed("Right") and facing != Facing.LEFT:
		next_facing = Facing.RIGHT


func try_to_move():
	facing = next_facing
	var next_pos = _positions[0] + offset[facing]
	if not grid.contains(next_pos):
		emit_signal("collided")
		return

	for pos in _positions.slice(1, _positions.size()):
		if next_pos == pos:
			emit_signal("collided")
			return

	_positions.insert(0, next_pos)
	tail = _positions.pop_back()
	emit_signal("moved_to", next_pos)


func append(cell: Cell):
	parts.append(cell)
	_positions.append(tail)


func draw_to(_grid: Grid):
	for i in parts.size():
		_grid.set_cell(_positions[i], parts[i]._char, parts[i]._color)


func positions() -> Array[Vector2i]:
	return _positions
