extends Node

const PRIMARY = 0
const SECONDARY = 1
const BACKGROUND = 2
const HIGHLIGHT = 3
const SHADOW = 4

var color := {
	PRIMARY: Color.RED,
	SECONDARY: Color.DARK_RED,
	BACKGROUND: Color.BLACK,
	HIGHLIGHT: Color.WHITE_SMOKE,
	SHADOW: Color.DIM_GRAY,
}

var palette_indices := [0, 1, 2, 3, 4]
var palette_index : int = -1
var shuffled_idx : int = -1

const PALETTES := [
	{
		PRIMARY: Color.RED,
		SECONDARY: Color.DARK_RED,
		BACKGROUND: Color.BLACK,
		HIGHLIGHT: Color.WHITE_SMOKE,
		SHADOW: Color.DIM_GRAY,
	},
	{
		PRIMARY: Color.PURPLE,
		SECONDARY: Color.DARK_VIOLET,
		BACKGROUND: Color.BLACK,
		HIGHLIGHT: Color.WHITE_SMOKE,
		SHADOW: Color.DIM_GRAY,
	},
	{
		PRIMARY: Color.GREEN,
		SECONDARY: Color.DARK_GREEN,
		BACKGROUND: Color.BLACK,
		HIGHLIGHT: Color.WHITE_SMOKE,
		SHADOW: Color.DIM_GRAY,
	},
	{
		PRIMARY: Color.BLUE,
		SECONDARY: Color.DARK_BLUE,
		BACKGROUND: Color.BLACK,
		HIGHLIGHT: Color.WHITE_SMOKE,
		SHADOW: Color.DIM_GRAY,
	},
	{
		PRIMARY: Color.ORANGE,
		SECONDARY: Color.SADDLE_BROWN,
		BACKGROUND: Color.BLACK,
		HIGHLIGHT: Color.WHITE_SMOKE,
		SHADOW: Color.DIM_GRAY,
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

	color[PRIMARY] = PALETTES[shuffled_idx][PRIMARY]
	color[SECONDARY] = PALETTES[shuffled_idx][SECONDARY]
	color[BACKGROUND] = PALETTES[shuffled_idx][BACKGROUND]
	color[HIGHLIGHT] = PALETTES[shuffled_idx][HIGHLIGHT]
	color[SHADOW] = PALETTES[shuffled_idx][SHADOW]

	emit_signal("palette_change")
