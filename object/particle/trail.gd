class_name Trail
extends Node2D

@export var color_types : Array[Colors.Type]
@export var lifetime : float
@export var snake : Snake
@export var grid : Grid


func _init() -> void:
	process_priority = -1


func _ready() -> void:
	assert(snake is Snake)
	snake.connect("moved_to", _on_snake_moved_to)


func _process(_delta: float) -> void:
	for node in get_children():
		if node is Particle:
			grid.set_blend_color(node.position, node.get_color())


func _on_snake_moved_to(_p: Vector2i) -> void:
	var particle := Particle.new(snake.tail_position, color_types, lifetime)
	add_child(particle)
