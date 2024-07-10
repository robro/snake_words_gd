class_name Palette
extends Resource

@export var _primary : Color
@export var _secondary : Color
@export var _background : Color
@export var _highlight : Color
@export var _shadow : Color


func _init(
	primary: Color = Color.PURPLE,
	secondary: Color = Color.DARK_VIOLET,
	background: Color = Color.BLACK,
	highlight: Color = Color.WHITE_SMOKE,
	shadow: Color = Color.DIM_GRAY,
) -> void:
	_primary = primary
	_secondary = secondary
	_background = background
	_highlight = highlight
	_shadow = shadow
