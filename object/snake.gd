class_name Snake
extends Node2D

@export var text : String = "snake"
@export var color : Color = Color.WHITE
@export var facing : Facing = Facing.RIGHT
@export var tick : float = 0.5
@export var pos : Vector2i = Vector2i.ZERO

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
var parts : Array[SnakePart]
var positions : Array[Vector2i]
var tail : Vector2i = pos
var next_facing := facing


func _init():
	for i in len(text):
		parts.append(SnakePart.new(text[i], color))
		positions.append(offset[facing] * -i)


func _ready():
	timer = Timer.new()
	add_child(timer)
	timer.wait_time = tick
	timer.timeout.connect(move)
	timer.start()


func _process(_delta):
	pass


func _input(event):
	if not event is InputEvent:
		return
	if event.is_action_pressed("Up") and facing != Facing.DOWN:
		next_facing = Facing.UP
	elif event.is_action_pressed("Down") and facing != Facing.UP:
		next_facing = Facing.DOWN
	elif event.is_action_pressed("Left") and facing != Facing.RIGHT:
		next_facing = Facing.LEFT
	elif event.is_action_pressed("Right") and facing != Facing.LEFT:
		next_facing = Facing.RIGHT


func move():
	facing = next_facing
	tail = positions.pop_back()
	positions.insert(0, positions[0] + offset[facing])


func draw_to_grid(grid: Grid):
	for i in len(parts):
		grid.set_cell(positions[i] + pos, parts[i].text, parts[i].color)


func get_positions() -> Array[Vector2i]:
	return positions
