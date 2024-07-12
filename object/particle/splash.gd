class_name Splash
extends Node2D

var grid : Grid
var size : int
var max_size : int
var tick_time : float
var color_types : Array[Colors.Type]
var lifetime : float
var queue : Array[Array]
var visited : Dictionary
var active_particles : int = 0
var tick_timer := Timer.new()

const offsets : Array[Vector2] = [
	Vector2.UP,
	Vector2.DOWN,
	Vector2.LEFT,
	Vector2.RIGHT,
]


func _init(
	_grid: Grid,
	_position: Vector2,
	_props: SplashProperties,
) -> void:
	grid = _grid
	position = _position
	size = _props.start_size
	max_size = _props.max_size
	tick_time = _props.tick_time
	color_types = _props.color_types
	lifetime = _props.lifetime

	tick_timer.wait_time = tick_time
	tick_timer.autostart = true
	tick_timer.connect("timeout", _on_tick_timer_timeout)
	add_child(tick_timer)

	queue.append([0, position])
	visited[position] = null
	process_priority = -1

	add_to_group("emitters")


func _ready() -> void:
	_on_tick_timer_timeout()


func _process(_delta: float) -> void:
	for node in get_children():
		if node is Particle:
			grid.set_blend_color(node.position, node.get_color())


func _on_tick_timer_timeout() -> void:
	while size <= max_size and not queue.is_empty():
		if queue[0][0] > size:
			size += 1
			return

		var current : Array = queue.pop_front()
		var curr_size : int = current[0]
		var curr_pos : Vector2 = current[1]
		var particle := Particle.new(curr_pos, color_types, lifetime)
		particle.connect("is_done", _on_particle_is_done)
		add_child(particle)
		active_particles += 1

		if curr_size == max_size:
			continue

		for offset in offsets:
			var next_pos := curr_pos + offset
			if grid.contains(next_pos) and not visited.has(next_pos):
				queue.append([size + 1, next_pos])
				visited[next_pos] = null


func _on_particle_is_done() -> void:
	active_particles -= 1
	if active_particles == 0:
		queue_free()
