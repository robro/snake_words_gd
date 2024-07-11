extends ColorRect

@export var _color : Colors.Type


func _ready() -> void:
	color = Colors.color[_color]


func _process(_delta: float) -> void:
	color = Colors.color[_color]
