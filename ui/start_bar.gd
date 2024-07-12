extends ColorRect

@export var color_type : Colors.Type


func _process(_delta: float) -> void:
	color = Colors.palette[color_type]
