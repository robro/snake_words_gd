class_name SplashSpawner
extends Node2D

@export var interval : float = 3.0
@export var transition_delay : float = 1.0
@export var grid : Grid
@export var title_snake : TitleSnake
@export var title_splash : SplashProperties

var splash_timer := Timer.new()
var transition_timer := Timer.new()


func _ready() -> void:
	assert(grid is Grid)
	assert(title_snake is TitleSnake)
	assert(title_splash is SplashProperties)

	splash_timer.wait_time = 2.0
	splash_timer.autostart = true
	splash_timer.connect("timeout", _on_splash_timer_timeout)
	add_child(splash_timer)

	transition_timer.wait_time = transition_delay
	transition_timer.one_shot = true
	transition_timer.connect("timeout", _on_transition_timer_timeout)
	add_child(transition_timer)
	
	add_to_group("emitters")


func _on_splash_timer_timeout() -> void:
	splash_timer.wait_time = interval
	splash_timer.start()
	transition_timer.start()
	add_child(Splash.new(
		grid,
		title_snake.get_children().filter(
			func(c: Node) -> bool: return c is SnakePart
		)[0].position,
		title_splash,
	))


func _on_transition_timer_timeout() -> void:
	Colors.next_palette()
