extends Node

@export var start_delay : float = 1.0
@export var transition_time : float = 1.0
@export var state_chart : StateChart
@export var grid_renderer : GridRenderer

var start_timer := Timer.new()


func _ready() -> void:
	assert(state_chart is StateChart)
	assert(grid_renderer is GridRenderer)

	start_timer.wait_time = start_delay
	start_timer.one_shot = true
	start_timer.connect("timeout", _on_start_timer_timeout)
	add_child(start_timer)
	Colors.transition_time = transition_time
	Colors.next_palette()


func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		state_chart.send_event("press_start")


func _on_starting_state_entered() -> void:
	grid_renderer.queue_free()
	start_timer.start()


func _on_start_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://scene/gameplay/gameplay.tscn")
