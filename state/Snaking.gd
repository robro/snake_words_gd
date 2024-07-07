class_name Snaking
extends Node2D

@onready var timer := Timer.new()
@onready var food_spawner : FoodSpawner = get_node("Grid/FoodSpawner")

signal spawn_food(text: String)


func _ready():
	add_child(timer)
	timer.wait_time = 1
	timer.timeout.connect(_on_timer_timeout)
	timer.start()


func _process(_delta):
	pass


func _on_timer_timeout():
	spawn_food.emit("awholelotoffood")
