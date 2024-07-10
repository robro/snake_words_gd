class_name Splash
extends Node2D

var _grid : Grid
var _pos : Vector2i
var _size : int
var _max_size : int
var _tick : float
var _color : int
var _lifetime : float
var _queue : Array[Array]
var _visited : Dictionary
var _active_count : int = 0
var _timer := Timer.new()

const offsets : Array[Vector2i] = [
	Vector2i.UP,
	Vector2i.DOWN,
	Vector2i.LEFT,
	Vector2i.RIGHT,
]


func _init(
	grid: Grid,
	pos: Vector2i,
	start_size: int,
	max_size: int,
	tick: float,
	color: int,
	lifetime: float
) -> void:
	assert(start_size <= max_size)
	assert(tick > 0)
	assert(color >= 0 and color < Palette.color.size())

	_grid = grid
	_pos = pos
	_size = start_size
	_max_size = max_size
	_tick = tick
	_color = color
	_lifetime = lifetime

	_timer.wait_time = tick
	_timer.autostart = true
	_timer.connect("timeout", _on_timer_timeout)
	add_child(_timer)

	_queue.append([0, pos])
	_visited[pos] = null

	add_to_group("emitters")


func _ready() -> void:
	_on_timer_timeout()


func _on_timer_timeout() -> void:
	while _size <= _max_size and not _queue.is_empty():
		if _queue[0][0] > _size:
			_size += 1
			return

		var current : Array = _queue.pop_front()
		var size : int = current[0]
		var pos : Vector2i = current[1]
		var particle := Particle.new(pos, _color, _lifetime)
		particle.connect("is_done", _on_particle_is_done)
		add_child(particle)
		_active_count += 1

		if size == _max_size:
			continue

		for offset in offsets:
			var next_pos := pos + offset
			if _grid.contains(next_pos) and not _visited.has(next_pos):
				_queue.append([size + 1, next_pos])
				_visited[next_pos] = null


func _on_particle_is_done() -> void:
	_active_count -= 1


func _process(_delta: float) -> void:
	if _active_count == 0:
		queue_free()