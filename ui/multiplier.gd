extends Label

@export var _normal_color := Colors.Type.SECONDARY
@export var _focus_color := Colors.Type.PRIMARY
@onready var _color := _normal_color


func _ready() -> void:
	add_theme_color_override("font_color", Colors.palette[_color])


func _process(_delta: float) -> void:
	add_theme_color_override("font_color", Colors.palette[_color])
	text = "x" + str(Global.multiplier)


func _on_word_finished_state_entered() -> void:
	_color = _focus_color


func _on_seeking_state_entered() -> void:
	_color = _normal_color


func _on_game_over_state_entered() -> void:
	_color = _normal_color
