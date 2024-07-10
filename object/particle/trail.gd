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
	var particle := Particle.new(snake._tail, color, 1.0)
	add_child(particle)
