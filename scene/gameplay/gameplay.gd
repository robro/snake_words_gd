class_name Gameplay
extends Node

@onready var food_spawner : FoodSpawner = $FoodSpawner
@onready var snake : Snake = $Snake
@onready var grid : Grid = $Grid
@onready var trail : Trail = $Trail
@onready var state_chart : StateChart = $StateChart

var game_over_timer := Timer.new()


func _ready() -> void:
	game_over_timer.wait_time = 0.5
	game_over_timer.one_shot = true
	add_child(game_over_timer)


func _on_seeking_state_entered() -> void:
	Global.target_word = "snake"
	Global.partial_word = ""
	Palette.next_palette()
	food_spawner.spawn_food(Global.target_word, grid)


func add_points() -> void:
	Global.combo += 1
	Global.max_combo = max(Global.combo, Global.max_combo)
	Global.score += Global.base_points * Global.multiplier


func _on_snake_moved_to(pos: Vector2i) -> void:
	for food in food_spawner.foods:
		if not food.is_edible() or food._pos != pos:
			continue

		snake.append(Cell.new(food._char, food._color))
		Global.partial_word += food._char

		if not Global.target_word.begins_with(Global.partial_word):
			state_chart.send_event("word_failed")

		elif Global.partial_word == Global.target_word:
			add_child(Splash.new(grid, food._pos, 2, 24, 0.05, Palette.HIGHLIGHT, 1.0))
			state_chart.send_event("word_finished")

		else:
			add_child(Splash.new(grid, food._pos, 1, 4, 0.05, Palette.PRIMARY, 0.5))
			add_points()

		food_spawner.remove(food)
		return


func _on_snake_collided() -> void:
	state_chart.send_event("game_over")


func _on_word_failed_state_entered() -> void:
	food_spawner.clear()
	Global.target_word = "".rpad(Global.target_word.length())
	Global.multiplier = 1
	Global.combo = 0


func _on_word_failed_state_exited() -> void:
	for i in Global.partial_word.length():
		snake.parts[-i - 1]._color = Palette.SHADOW


func _on_word_finished_state_entered() -> void:
	food_spawner.clear()
	Global.target_word = "".rpad(Global.target_word.length())
	Global.multiplier = min(Global.multiplier * 2, Global.max_multiplier)
	add_points()


func _on_word_finished_state_exited() -> void:
	for i in Global.partial_word.length():
		snake.parts[-i - 1]._color = Palette.HIGHLIGHT


func _on_game_over_state_entered() -> void:
	for node in get_tree().get_nodes_in_group("emitters"):
		node.queue_free()

	snake.alive = false
	Global.target_word = ""
	Global.partial_word = "udied"
	game_over_timer.start()


func _on_game_over_state_processing(_delta: float) -> void:
	for food in food_spawner.foods:
		food._char = Global.rand_char()

	for cell in snake.parts:
		cell._char = Global.rand_char()


func _on_game_over_state_input(event: InputEvent) -> void:
	if event is InputEventKey and game_over_timer.time_left == 0:
		Global.score = 0
		Global.combo = 0
		Global.max_combo = 0
		Global.multiplier = 1
		get_tree().reload_current_scene()
