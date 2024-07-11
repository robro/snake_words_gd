extends Node

enum Type {
	PRIMARY,
	SECONDARY,
	BACKGROUND,
	HIGHLIGHT,
	SHADOW,
}

const palettes_path = "res://render/palettes"
const resource_type = "Palette"
const transition_time = 0.5

var color : Array[Color] = [
	Color.HOT_PINK,
	Color.HOT_PINK,
	Color.HOT_PINK,
	Color.HOT_PINK,
	Color.HOT_PINK,
]
var palettes : Array[Palette] = []
var curr_palette : Palette = null
var prev_palette : Palette = null
var palette_indices := []
var palette_index : int = -1
var shuffled_idx : int = -1
var timer := Timer.new()


func _init() -> void:
	var dir := DirAccess.open(palettes_path)
	assert(dir)

	dir.list_dir_begin()
	var file_name := dir.get_next()

	while file_name != "":
		if not dir.current_is_dir():
			var file_path := palettes_path + "/" + file_name
			if ResourceLoader.exists(file_path, resource_type):
				var pal := ResourceLoader.load(file_path, resource_type)
				if pal:
					palettes.append(pal)

		file_name = dir.get_next()

	dir.list_dir_end()
	palette_indices = range(palettes.size())
	timer.wait_time = transition_time
	timer.one_shot = true
	add_child(timer)


func _process(_delta: float) -> void:
	if timer.is_stopped():
		return

	color[0] = curr_palette._primary.lerp(prev_palette._primary, timer.time_left / transition_time)
	color[1] = curr_palette._secondary.lerp(prev_palette._secondary, timer.time_left / transition_time)
	color[2] = curr_palette._background.lerp(prev_palette._background, timer.time_left / transition_time)
	color[3] = curr_palette._highlight.lerp(prev_palette._highlight, timer.time_left / transition_time)
	color[4] = curr_palette._shadow.lerp(prev_palette._shadow, timer.time_left / transition_time)


func next_palette() -> void:
	if not palette_index in palette_indices:
		palette_index = 0
		palette_indices.shuffle()
		if palette_indices[0] == shuffled_idx:
			var i : int = palette_indices[-1]
			palette_indices[-1] = palette_indices[0]
			palette_indices[0] = i

	shuffled_idx = palette_indices[palette_index]
	palette_index += 1

	prev_palette = curr_palette if curr_palette != null else palettes[shuffled_idx]
	curr_palette = palettes[shuffled_idx]
	timer.start()
