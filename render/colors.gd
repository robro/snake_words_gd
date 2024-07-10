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

var color : Array[Color] = [
	Color.HOT_PINK,
	Color.HOT_PINK,
	Color.HOT_PINK,
	Color.HOT_PINK,
	Color.HOT_PINK,
]
var palettes : Array[Palette] = []
var palette_indices := []
var palette_index : int = -1
var shuffled_idx : int = -1

signal palette_change


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

	color[0] = palettes[shuffled_idx]._primary
	color[1] = palettes[shuffled_idx]._secondary
	color[2] = palettes[shuffled_idx]._background
	color[3] = palettes[shuffled_idx]._highlight
	color[4] = palettes[shuffled_idx]._shadow

	emit_signal("palette_change")
