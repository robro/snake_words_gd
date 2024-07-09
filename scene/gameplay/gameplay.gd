class_name Gameplay
extends Node2D

@onready var food_spawner : FoodSpawner = $FoodSpawner
@onready var snake : Snake = $Snake
@onready var grid : Grid = $Grid
@onready var state_chart : StateChart = $StateChart


func _on_seeking_state_entered():
	Global.target_word = "snake"
	Global.partial_word = ""
	Palette.next_palette()
	food_spawner.spawn_food(Global.target_word, grid)


func add_points():
	Global.combo += 1
	Global.max_combo = max(Global.combo, Global.max_combo)
	Global.score += Global.base_points * Global.multiplier


func _on_snake_moved_to(pos: Vector2i):
	for food : Food in food_spawner.get_children():
		if not food.is_edible():
			continue
		if food._pos != pos:
			continue

		snake.append(Cell.new(food._char, food._color))
		Global.partial_word += food._char
		food_spawner.remove(food)

		if not Global.target_word.begins_with(Global.partial_word):
			state_chart.send_event("word_failed")

		elif Global.partial_word == Global.target_word:
			state_chart.send_event("word_finished")

		else:
			add_points()


func _on_snake_collided():
	state_chart.send_event("game_over")


func _on_word_failed_state_entered():
	food_spawner.clear()
	Global.target_word = "".rpad(Global.target_word.length())
	Global.multiplier = 1
	Global.combo = 0


func _on_word_failed_state_exited():
	for i in Global.partial_word.length():
		snake.parts[-i - 1]._color = Palette.Type.SHADOW


func _on_word_finished_state_entered():
	food_spawner.clear()
	Global.target_word = "".rpad(Global.target_word.length())
	Global.multiplier = min(Global.multiplier * 2, Global.max_multiplier)
	add_points()


func _on_word_finished_state_exited():
	for i in Global.partial_word.length():
		snake.parts[-i - 1]._color = Palette.Type.HIGHLIGHT


func _on_game_over_state_entered():
	# display max combo
	pass


func _on_game_over_state_processing(_delta):
	for food : Food in food_spawner.get_children():
		food._char = char(randi_range(0, 25) + 97)

	for cell : Cell in snake.parts:
		cell._char = char(randi_range(0, 25) + 97)
