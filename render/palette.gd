extends Node

enum Type {
	PRIMARY,
	SECONDARY,
	BACKGROUND,
	HIGHLIGHT,
	SHADOW,
}

var color := {
	Type.PRIMARY: Color.RED,
	Type.SECONDARY: Color.DARK_RED,
	Type.BACKGROUND: Color.BLACK,
	Type.HIGHLIGHT: Color.WHITE_SMOKE,
	Type.SHADOW: Color.DIM_GRAY,
}

var palette_indices := range(PALETTES.size())
var palette_index : int = -1
var shuffled_idx : int = -1

const PALETTES := [
	{
		Type.PRIMARY: Color.RED,
		Type.SECONDARY: Color.DARK_RED,
		Type.BACKGROUND: Color.BLACK,
		Type.HIGHLIGHT: Color.WHITE_SMOKE,
		Type.SHADOW: Color.DIM_GRAY,
	},
	{
		Type.PRIMARY: Color.PURPLE,
		Type.SECONDARY: Color.DARK_VIOLET,
		Type.BACKGROUND: Color.BLACK,
		Type.HIGHLIGHT: Color.WHITE_SMOKE,
		Type.SHADOW: Color.DIM_GRAY,
	},
	{
		Type.PRIMARY: Color.GREEN,
		Type.SECONDARY: Color.DARK_GREEN,
		Type.BACKGROUND: Color.BLACK,
		Type.HIGHLIGHT: Color.WHITE_SMOKE,
		Type.SHADOW: Color.DIM_GRAY,
	},
	{
		Type.PRIMARY: Color.BLUE,
		Type.SECONDARY: Color.DARK_BLUE,
		Type.BACKGROUND: Color.BLACK,
		Type.HIGHLIGHT: Color.WHITE_SMOKE,
		Type.SHADOW: Color.DIM_GRAY,
	},
	{
		Type.PRIMARY: Color.ORANGE,
		Type.SECONDARY: Color.SADDLE_BROWN,
		Type.BACKGROUND: Color.BLACK,
		Type.HIGHLIGHT: Color.WHITE_SMOKE,
		Type.SHADOW: Color.DIM_GRAY,
	},
]

signal palette_change

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

	color[Type.PRIMARY] = PALETTES[shuffled_idx][Type.PRIMARY]
	color[Type.SECONDARY] = PALETTES[shuffled_idx][Type.SECONDARY]
	color[Type.BACKGROUND] = PALETTES[shuffled_idx][Type.BACKGROUND]
	color[Type.HIGHLIGHT] = PALETTES[shuffled_idx][Type.HIGHLIGHT]
	color[Type.SHADOW] = PALETTES[shuffled_idx][Type.SHADOW]

	emit_signal("palette_change")
