extends Node

@export var _start_delay : float = 1.0
@export var _title_snake : TitleSnake
@export var _state_chart : StateChart

var _start_timer := Timer.new()


func _ready() -> void:
	assert(_state_chart is StateChart)
	assert(_title_snake is TitleSnake)

	_start_timer.wait_time = _start_delay
	_start_timer.one_shot = true
	_start_timer.connect("timeout", _on_start_timer_timeout)
	add_child(_start_timer)
	Colors.next_palette()


func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		_state_chart.send_event("press_start")


func _on_starting_state_entered() -> void:
	for node in get_tree().get_nodes_in_group("emitters"):
		node.queue_free()
	_title_snake.queue_free()
	_start_timer.start()


func _on_start_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://scene/gameplay/gameplay.tscn")
