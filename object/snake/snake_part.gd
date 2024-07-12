class_name SnakePart
extends Node2D

var cell : Cell


func _init(_position: Vector2, _cell: Cell) -> void:
	position = _position
	cell = _cell
	add_to_group("physical")
