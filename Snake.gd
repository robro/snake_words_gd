class_name Snake
extends Node2D

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

@export var text : String = "snake"
@export var color : Color = Color.WHITE
@export var facing : Facing = Facing.RIGHT
@export var tick : float = 0.5
@export var start_pos : Vector2i = Vector2i.ZERO
@export var grid : Grid

var timer : Timer
var parts : Array[SnakePart]
var offsets : Array[Vector2i]
var tail : Vector2i


func _init():
	for i in len(text):
		parts.append(SnakePart.new(text[i], color))
		offsets.append(offset[facing] * -i)


func _ready():
	assert(grid is Grid)
	timer = Timer.new()
	add_child(timer)
	timer.wait_time = tick
	timer.timeout.connect(move)
	timer.start()


func _process(_delta):
	pass

func move():
	tail = offsets.pop_back()
	offsets.insert(0, offsets[0] + offset[facing])

	grid.clear()
	for i in len(parts):
		grid.set_cell(offsets[i] + start_pos, parts[i].text, parts[i].color)

	facing = Facing.values()[randi_range(0, len(Facing) - 1)]
