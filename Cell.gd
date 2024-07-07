class_name Cell
extends Label


@export var default_text := '.'
var base_settings := preload("res://CellSettings.tres")


func _init():
	assert(len(default_text) == 1)
	label_settings = base_settings.duplicate()
	text = default_text


func _ready():
	pass

func _process(_delta):
	assert(len(text) == 1)


func set_char(_text: String):
	# assert(len(text) == 1)
	text = _text


func set_color(color: Color):
	label_settings.font_color = color


func randomize():
	text = get_rand_text()
	label_settings.font_color = get_rand_color()


func get_rand_text() -> String:
	return char(randi_range(0, 25) + 97)


func get_rand_color() -> Color:
	return Color(randf(), randf(), randf())
