class_name Snake
extends Node2D

@export var _text : String = "snake"
@export var _facing : Facing = Facing.RIGHT
@export var _tick : float = 0.5
@export var _start_pos : Vector2i = Vector2i.ZERO
@export var _grid : Grid
@onready var _next_facing := _facing
@onready var _tail : Vector2i = _start_pos

var _alive := true
var _timer := Timer.new()

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

signal moved_to(p: Vector2i)
signal collided


func _ready() -> void:
	assert(_grid is Grid)

	for i in len(_text):
		add_child(SnakePart.new(
			_start_pos + offset[_facing] * -i,
			_text[i],
			Palette.HIGHLIGHT,
		))

	_timer.wait_time = _tick
	_timer.autostart = true
	_timer.timeout.connect(try_to_move)
	add_child(_timer)


func _input(event: InputEvent) -> void:
	if not _alive:
		return

	if event.is_action_pressed("Up") and _facing != Facing.DOWN:
		_next_facing = Facing.UP
	elif event.is_action_pressed("Down") and _facing != Facing.UP:
		_next_facing = Facing.DOWN
	elif event.is_action_pressed("Left") and _facing != Facing.RIGHT:
		_next_facing = Facing.LEFT
	elif event.is_action_pressed("Right") and _facing != Facing.LEFT:
		_next_facing = Facing.RIGHT


func try_to_move() -> void:
	_facing = _next_facing
	var parts := get_children().filter(func(c: Node) -> bool: return c is SnakePart)
	var next_pos : Vector2i = parts[0]._pos + offset[_facing]
	if not _grid.contains(next_pos):
		emit_signal("collided")
		return

	for part : SnakePart in parts:
		if next_pos == part._pos:
			emit_signal("collided")
			return

	_tail = parts[-1]._pos
	if parts.size() > 1:
		for i in range(parts.size() - 2, -1, -1):
			parts[i + 1]._pos = parts[i]._pos

	parts[0]._pos = next_pos
	emit_signal("moved_to", next_pos)


func append(text: String, color: int) -> void:
	add_child(SnakePart.new(_tail, text, color))
