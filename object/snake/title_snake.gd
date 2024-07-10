class_name TitleSnake
extends Node2D

@export var _name : String = "snake_words"
@export_enum(
	"primary",
	"secondary",
	"background",
	"highlight",
	"shadow"
) var _color : int = 3
# @export var _facing : Facing = Facing.RIGHT
@export var _tick : float = 0.5
@export var _start_pos : Vector2i = Vector2i.ZERO
@export var _min_moves : int = 3
@export var _max_moves : int = 5
@export var _bounds : Rect2i = Rect2i(0, 0, 12, 12)
@onready var _tail : Vector2i = _start_pos
@onready var _moves := rand_moves()

var _timer := Timer.new()
var _turn_right := true
var _facing_idx := 0

const facing_list = [
	Vector2i.RIGHT,
	Vector2i.DOWN,
	Vector2i.LEFT,
	Vector2i.UP,
]


func _ready() -> void:
	assert(_max_moves > 0)

	for i in len(_name):
		add_child(SnakePart.new(
			_start_pos + facing_list[_facing_idx] * -i,
			_name[i],
			_color,
		))

	_timer.wait_time = _tick
	_timer.autostart = true
	_timer.timeout.connect(try_to_move)
	add_child(_timer)


func try_to_move() -> void:
	var parts := get_children().filter(
		func(c: Node) -> bool: return c is SnakePart
	)
	var next_pos : Vector2i = parts[0]._pos + facing_list[_facing_idx]
	while not _bounds.has_point(next_pos):
		_turn_right = true
		turn()
		_moves = rand_moves()
		next_pos = parts[0]._pos + facing_list[_facing_idx]

	_tail = parts[-1]._pos
	if parts.size() > 1:
		for i in range(parts.size() - 2, -1, -1):
			parts[i + 1]._pos = parts[i]._pos

	parts[0]._pos = next_pos

	_moves -= 1
	if _moves == 0:
		turn()
		_moves = rand_moves()
		_turn_right = false if _turn_right else true


func turn() -> void:
	var direction := 1 if _turn_right else -1
	_facing_idx += direction
	if _facing_idx < 0:
		_facing_idx = 3
	else:
		_facing_idx %= 4


func rand_moves() -> int:
	return randi_range(_min_moves, _max_moves)
