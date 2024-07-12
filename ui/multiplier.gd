extends Label

@export var normal_color := Colors.Type.SECONDARY
@export var focus_color := Colors.Type.PRIMARY
@onready var color_type := normal_color


func _ready() -> void:
	add_theme_color_override("font_color", Colors.palette[color_type])


func _process(_delta: float) -> void:
	add_theme_color_override("font_color", Colors.palette[color_type])
	text = "x" + str(Global.multiplier)


func _on_word_finished_state_entered() -> void:
	color_type = focus_color


func _on_seeking_state_entered() -> void:
	color_type = normal_color


func _on_game_over_state_entered() -> void:
	color_type = normal_color
