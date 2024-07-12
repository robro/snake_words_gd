class_name Gameplay
extends Node

@export var snake : Snake
@export var food_spawner : FoodSpawner
@export var state_chart : StateChart
@export var small_splash : SplashProperties
@export var big_splash : SplashProperties
@export var grid : Grid
@export var transition_time : float = 0.5

var gameover_timer := Timer.new()
var word_idx : int = 0


func _init() -> void:
	gameover_timer.wait_time = 0.5
	gameover_timer.one_shot = true
	add_child(gameover_timer)
	Words.words.shuffle()


func _on_seeking_state_entered() -> void:
	Colors.transition_time = transition_time
	Colors.next_palette()
	Global.target_word = Words.words[word_idx]
	Global.partial_word = ""
	food_spawner.spawn_food(Global.target_word)
	word_idx += 1
	word_idx %= Words.words.size()


func _on_snake_moved_to(pos: Vector2) -> void:
	for food : Food in get_tree().get_nodes_in_group("food"):
		if not food.is_edible() or food.position != pos:
			continue

		snake.append(food.cell)
		Global.partial_word += food.cell.ascii

		if not Global.target_word.begins_with(Global.partial_word):
			state_chart.send_event("word_failed")

		elif Global.partial_word == Global.target_word:
			add_child(Splash.new(grid, food.position, big_splash))
			state_chart.send_event("word_finished")

		else:
			add_child(Splash.new(grid, food.position, small_splash))
			add_points()

		food.queue_free()
		return


func add_points() -> void:
	Global.combo += 1
	Global.max_combo = max(Global.combo, Global.max_combo)
	Global.score += Global.base_points * Global.multiplier


func _on_snake_collided() -> void:
	state_chart.send_event("game_over")


func _on_word_failed_state_entered() -> void:
	food_spawner.clear()
	Global.target_word = "".rpad(Global.target_word.length())
	Global.multiplier = 1
	Global.combo = 0


func _on_word_failed_state_exited() -> void:
	for i in Global.partial_word.length():
		snake.get_children().filter(
			func(c: Node) -> bool: return c is SnakePart
		)[-i - 1].cell.color_type = Colors.Type.SHADOW


func _on_word_finished_state_entered() -> void:
	food_spawner.clear()
	Global.target_word = "".rpad(Global.target_word.length())
	Global.multiplier = min(Global.multiplier * 2, Global.max_multiplier)
	add_points()


func _on_word_finished_state_exited() -> void:
	for i in Global.partial_word.length():
		snake.get_children().filter(
			func(c: Node) -> bool: return c is SnakePart
		)[-i - 1].cell.color_type = Colors.Type.HIGHLIGHT


func _on_game_over_state_entered() -> void:
	for node in get_tree().get_nodes_in_group("emitters"):
		node.queue_free()

	snake.is_alive = false
	Global.target_word = ""
	Global.partial_word = "udied"
	gameover_timer.start()


func _on_game_over_state_processing(_delta: float) -> void:
	for node in get_tree().get_nodes_in_group("physical"):
		node.cell.ascii = Global.rand_char()


func _on_game_over_state_input(event: InputEvent) -> void:
	if event is InputEventKey and gameover_timer.time_left == 0:
		Global.score = 0
		Global.combo = 0
		Global.max_combo = 0
		Global.multiplier = 1
		get_tree().reload_current_scene()
