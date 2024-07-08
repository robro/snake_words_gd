extends Node

var primary : Color
var secondary : Color
var background : Color
var highlight : Color
var shadow : Color

var palette_indices := [0, 1, 2, 3, 4]
var palette_index : int = -1
var shuffled_idx : int = -1

const PALETTES = [
	{
		"primary": Color.RED,
		"secondary": Color.DARK_RED,
		"background": Color.BLACK,
		"highlight": Color.WHITE_SMOKE,
		"shadow": Color.DIM_GRAY,
	},
	{
		"primary": Color.PURPLE,
		"secondary": Color.DARK_VIOLET,
		"background": Color.BLACK,
		"highlight": Color.WHITE_SMOKE,
		"shadow": Color.DIM_GRAY,
	},
	{
		"primary": Color.GREEN,
		"secondary": Color.DARK_GREEN,
		"background": Color.BLACK,
		"highlight": Color.WHITE_SMOKE,
		"shadow": Color.DIM_GRAY,
	},
	{
		"primary": Color.BLUE,
		"secondary": Color.DARK_BLUE,
		"background": Color.BLACK,
		"highlight": Color.WHITE_SMOKE,
		"shadow": Color.DIM_GRAY,
	},
	{
		"primary": Color.ORANGE,
		"secondary": Color.SADDLE_BROWN,
		"background": Color.BLACK,
		"highlight": Color.WHITE_SMOKE,
		"shadow": Color.DIM_GRAY,
	},
]

func next_palette():
	if not palette_index in palette_indices:
		palette_index = 0
		palette_indices.shuffle()
		if palette_indices[0] == shuffled_idx:
			var i = palette_indices[-1]
			palette_indices[-1] = palette_indices[0]
			palette_indices[0] = i

	shuffled_idx = palette_indices[palette_index]
	palette_index += 1

	primary = PALETTES[shuffled_idx]["primary"]
	secondary = PALETTES[shuffled_idx]["secondary"]
	background = PALETTES[shuffled_idx]["background"]
	highlight = PALETTES[shuffled_idx]["highlight"]
	shadow = PALETTES[shuffled_idx]["shadow"]
