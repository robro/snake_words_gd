class_name Gameplay
extends Node

@export var _grid : Grid
@export var _snake : Snake
@export var _food_spawner : FoodSpawner
@export var _state_chart : StateChart
@export var _small_splash : SplashProperties
@export var _big_splash : SplashProperties

var _go_timer := Timer.new()
var _word_idx : int = 0


func _ready() -> void:
	_go_timer.wait_time = 0.5
	_go_timer.one_shot = true
	add_child(_go_timer)
	Words.words.shuffle()


func _on_seeking_state_entered() -> void:
	Colors.next_palette()
	Global.target_word = Words.words[_word_idx]
	Global.partial_word = ""
	_food_spawner.spawn_food(Global.target_word, _grid)
	_word_idx += 1
	_word_idx %= Words.words.size()


func add_points() -> void:
	Global.combo += 1
	Global.max_combo = max(Global.combo, Global.max_combo)
	Global.score += Global.base_points * Global.multiplier


func _on_snake_moved_to(pos: Vector2i) -> void:
	for food in get_tree().get_nodes_in_group("food"):
		if not food.is_edible() or food._pos != pos:
			continue

		_snake.append(food._char, food._color)
		Global.partial_word += food._char

		if not Global.target_word.begins_with(Global.partial_word):
			_state_chart.send_event("word_failed")

		elif Global.partial_word == Global.target_word:
			add_child(Splash.new(_grid,	food._pos, _big_splash))
			_state_chart.send_event("word_finished")

		else:
			add_child(Splash.new(_grid, food._pos, _small_splash))
			add_points()

		food.queue_free()
		return


func _on_snake_collided() -> void:
	_state_chart.send_event("game_over")


func _on_word_failed_state_entered() -> void:
	_food_spawner.clear()
	Global.target_word = "".rpad(Global.target_word.length())
	Global.multiplier = 1
	Global.combo = 0


func _on_word_failed_state_exited() -> void:
	for i in Global.partial_word.length():
		_snake.get_children().filter(
			func(c: Node) -> bool: return c is SnakePart
		)[-i - 1]._color = Colors.Type.SHADOW


func _on_word_finished_state_entered() -> void:
	_food_spawner.clear()
	Global.target_word = "".rpad(Global.target_word.length())
	Global.multiplier = min(Global.multiplier * 2, Global.max_multiplier)
	add_points()


func _on_word_finished_state_exited() -> void:
	for i in Global.partial_word.length():
		_snake.get_children().filter(
			func(c: Node) -> bool: return c is SnakePart
		)[-i - 1]._color = Colors.Type.HIGHLIGHT


func _on_game_over_state_entered() -> void:
	for node in get_tree().get_nodes_in_group("emitters"):
		node.queue_free()

	_snake._alive = false
	Global.target_word = ""
	Global.partial_word = "udied"
	_go_timer.start()


func _on_game_over_state_processing(_delta: float) -> void:
	for part in get_tree().get_nodes_in_group("drawable"):
		part._char = Global.rand_char()


func _on_game_over_state_input(event: InputEvent) -> void:
	if event is InputEventKey and _go_timer.time_left == 0:
		Global.score = 0
		Global.combo = 0
		Global.max_combo = 0
		Global.multiplier = 1
		get_tree().reload_current_scene()
