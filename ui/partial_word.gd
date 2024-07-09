extends Label

@export var flash_speed := 0.075
@export var blink_speed := 0.5

var finished_timer := Timer.new()
var failed_timer := Timer.new()
var game_over_timer := Timer.new()
var flashing : bool = false


func _ready():
	Palette.connect("palette_change", _on_palette_change)

	finished_timer.wait_time = flash_speed
	failed_timer.wait_time = flash_speed
	game_over_timer.wait_time = blink_speed

	finished_timer.timeout.connect(_on_finished_timer_timeout)
	failed_timer.timeout.connect(_on_failed_timer_timeout)
	game_over_timer.timeout.connect(_on_game_over_timer_timeout)

	add_child(finished_timer)
	add_child(failed_timer)
	add_child(game_over_timer)


func _process(_delta):
	text = Global.partial_word.rpad(Global.target_word.length())


func _on_palette_change():
	add_theme_color_override("font_color", Palette.colors[Palette.Type.PRIMARY])


func _on_finished_timer_timeout():
	flashing = false if flashing else true
	var color = Palette.Type.HIGHLIGHT if flashing else Palette.Type.BACKGROUND
	add_theme_color_override("font_color", Palette.colors[color])


func _on_failed_timer_timeout():
	flashing = false if flashing else true
	var color = Palette.Type.BACKGROUND if flashing else Palette.Type.SECONDARY
	add_theme_color_override("font_color", Palette.colors[color])


func _on_game_over_timer_timeout():
	flashing = false if flashing else true
	var color = Palette.Type.BACKGROUND if flashing else Palette.Type.SECONDARY
	add_theme_color_override("font_color", Palette.colors[color])


func _on_word_finished_state_entered():
	flashing = true
	add_theme_color_override("font_color", Palette.colors[Palette.Type.HIGHLIGHT])
	finished_timer.start()


func _on_word_failed_state_entered():
	flashing = true
	add_theme_color_override("font_color", Palette.colors[Palette.Type.BACKGROUND])
	failed_timer.start()


func _on_game_over_state_entered():
	flashing = true
	add_theme_color_override("font_color", Palette.colors[Palette.Type.BACKGROUND])
	game_over_timer.start()


func _on_word_finished_state_exited():
	finished_timer.stop()


func _on_word_failed_state_exited():
	failed_timer.stop()
