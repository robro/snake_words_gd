class_name Trail
extends Node2D

@export_enum(
	"primary",
	"secondary",
	"background",
	"highlight",
	"shadow"
) var color : int
@export var lifetime : float
@export var snake : Snake


func _ready() -> void:
	snake.connect("moved_to", _on_snake_moved_to)


func _on_snake_moved_to(_p: Vector2i) -> void:
	var particle := Particle.new(snake.positions()[-1], color, 1.0)
	particle.add_to_group("particles")
	add_child(particle)
