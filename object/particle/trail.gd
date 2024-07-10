class_name Trail
extends Node2D

@export_enum(
	"primary",
	"secondary",
	"background",
	"highlight",
	"shadow"
) var _color : int
@export var _lifetime : float
@export var _snake : Snake


func _ready() -> void:
	_snake.connect("moved_to", _on_snake_moved_to)


func _on_snake_moved_to(_p: Vector2i) -> void:
	var particle := Particle.new(_snake._tail, _color, _lifetime)
	add_child(particle)
