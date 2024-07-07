extends Node2D

@onready var timer := Timer.new()
@onready var food_spawner : FoodSpawner = $Grid/FoodSpawner
@onready var snake : Snake = $Grid/Snake

signal spawn_food(text: String)
signal food_eaten(pos: Vector2i)


func _ready():
	snake.connect("snake_move_to", _on_snake_move)
	add_child(timer)
	timer.wait_time = 1
	# timer.timeout.connect(_on_timer_timeout)
	timer.start()


func _on_timer_timeout():
	spawn_food.emit("awholelotoffood")


func _on_snake_move(pos: Vector2i):
	print("snake moved to " + str(pos))
