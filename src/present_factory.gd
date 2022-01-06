extends Node

enum PColor { RED = 0, GREEN = 1, BLUE = 2, PINK = 3 }
enum Ribbon { YELLOW = 4, GREEN = 5, PURPLE = 6, PINK = 7 }
enum Pattern { VERTICAL = 8, NONE = 9, HORIZONTAL = 10, CHECKED = 11 }
enum Size { SMALL = 12, MEDIUM = 13, BIG = 14, WIDE = 15 }

onready var small_present = preload("res://src/Presents/small_present.tscn")
onready var medium_present = preload("res://src/Presents/medium_present.tscn")
onready var big_present = preload("res://src/Presents/big_present.tscn")
onready var wide_present = preload("res://src/Presents/wide_present.tscn")

var sizes = [24, 32, 24, 24]

var small_pcolors = [[0, 1, 2, 12, 13, 14],
					 [3, 4, 5, 15, 16, 17],
					 [6, 7, 8, 18, 19, 20],
					 [9, 10, 11, 21, 22, 23]]

var small_ribons = [[0, 1, 2, 3, 4, 5],
					[15, 16, 17, 18, 19, 20],
					[6, 7, 8, 9, 10, 11],
					[12, 13, 14, 21, 22, 23]]

var small_patterns = [[1, 4, 7, 10, 13, 16, 19, 22],
					  [0, 3, 6, 9, 12, 15, 18, 21],
					  [],
					  [2, 5, 8, 11, 14, 17, 20, 23]]

var medium_pcolors = [[0 + sizes[0], 1 + sizes[0], 2 + sizes[0], 3 + sizes[0], 17 + sizes[0], 18 + sizes[0], 19 + sizes[0], 20 + sizes[0]], 
					  [4 + sizes[0], 5 + sizes[0], 6 + sizes[0], 7 + sizes[0], 21 + sizes[0], 22 + sizes[0], 23 + sizes[0], 24 + sizes[0]], 
					  [8 + sizes[0], 9 + sizes[0], 10 + sizes[0], 11 + sizes[0], 25 + sizes[0], 26 + sizes[0], 27 + sizes[0], 28 + sizes[0]],
					  [12 + sizes[0], 13 + sizes[0], 14 + sizes[0], 15 + sizes[0], 29 + sizes[0], 30 + sizes[0], 31 + sizes[0], 32 + sizes[0]]]

var medium_ribons = [[0 + sizes[0], 1 + sizes[0], 2 + sizes[0], 3 + sizes[0], 4 + sizes[0], 5 + sizes[0], 6 + sizes[0], 7 + sizes[0]],
					 [20 + sizes[0], 21 + sizes[0], 22 + sizes[0], 23 + sizes[0], 24 + sizes[0], 25 + sizes[0], 26 + sizes[0], 27 + sizes[0]],
					 [8 + sizes[0], 9 + sizes[0], 10 + sizes[0], 11 + sizes[0], 12 + sizes[0], 13 + sizes[0], 14 + sizes[0], 15 + sizes[0]],
					 [16 + sizes[0], 17 + sizes[0], 18 + sizes[0], 19 + sizes[0], 28 + sizes[0], 29 + sizes[0], 30 + sizes[0], 31 + sizes[0]]]

var medium_patterns = [[0 + sizes[0], 4 + sizes[0], 8 + sizes[0], 12 + sizes[0], 16 + sizes[0], 20 + sizes[0], 24 + sizes[0], 28 + sizes[0]],
					   [1 + sizes[0], 5 + sizes[0], 9 + sizes[0], 13 + sizes[0], 17 + sizes[0], 21 + sizes[0], 25 + sizes[0], 29 + sizes[0]],
					   [2 + sizes[0], 6 + sizes[0], 10 + sizes[0], 14 + sizes[0], 18 + sizes[0], 22 + sizes[0], 26 + sizes[0], 30 + sizes[0]],
					   [3 + sizes[0], 7 + sizes[0], 11 + sizes[0], 15 + sizes[0], 19 + sizes[0], 23 + sizes[0], 27 + sizes[0], 31 + sizes[0]]]

var big_pcolors = [[0 + sizes[0] + sizes[1], 1 + sizes[0] + sizes[1], 2 + sizes[0] + sizes[1], 12 + sizes[0] + sizes[1], 13 + sizes[0] + sizes[1], 14 + sizes[0] + sizes[1]],
				   [3 + sizes[0] + sizes[1], 4 + sizes[0] + sizes[1], 5 + sizes[0] + sizes[1], 15 + sizes[0] + sizes[1], 16 + sizes[0] + sizes[1], 17 + sizes[0] + sizes[1]],
				   [6 + sizes[0] + sizes[1], 7 + sizes[0] + sizes[1], 8 + sizes[0] + sizes[1], 18 + sizes[0] + sizes[1], 19 + sizes[0] + sizes[1], 20 + sizes[0] + sizes[1]],
				   [9 + sizes[0] + sizes[1], 10 + sizes[0] + sizes[1], 11 + sizes[0] + sizes[1], 21 + sizes[0] + sizes[1], 22 + sizes[0] + sizes[1], 23 + sizes[0] + sizes[1]]]

var big_ribons = [[0 + sizes[0] + sizes[1], 1 + sizes[0] + sizes[1], 2 + sizes[0] + sizes[1], 3 + sizes[0] + sizes[1], 4 + sizes[0] + sizes[1], 5 + sizes[0] + sizes[1]],
				  [15 + sizes[0] + sizes[1], 16 + sizes[0] + sizes[1], 17 + sizes[0] + sizes[1], 18 + sizes[0] + sizes[1], 19 + sizes[0] + sizes[1], 20 + sizes[0] + sizes[1]],
				  [6 + sizes[0] + sizes[1], 7 + sizes[0] + sizes[1], 8 + sizes[0] + sizes[1], 9 + sizes[0] + sizes[1], 10 + sizes[0] + sizes[1], 11 + sizes[0] + sizes[1]],
				  [12 + sizes[0] + sizes[1], 13 + sizes[0] + sizes[1], 14 + sizes[0] + sizes[1], 21 + sizes[0] + sizes[1], 22 + sizes[0] + sizes[1], 23 + sizes[0] + sizes[1]]]

var big_patterns = [[0 + sizes[0] + sizes[1], 3 + sizes[0] + sizes[1], 6 + sizes[0] + sizes[1], 9 + sizes[0] + sizes[1], 12 + sizes[0] + sizes[1], 15 + sizes[0] + sizes[1], 18 + sizes[0] + sizes[1], 21 + sizes[0] + sizes[1]],
					[1 + sizes[0] + sizes[1], 4 + sizes[0] + sizes[1], 7 + sizes[0] + sizes[1], 10 + sizes[0] + sizes[1], 13 + sizes[0] + sizes[1], 16 + sizes[0] + sizes[1], 19 + sizes[0] + sizes[1], 22 + sizes[0] + sizes[1]],
					[2 + sizes[0] + sizes[1], 5 + sizes[0] + sizes[1], 8 + sizes[0] + sizes[1], 11 + sizes[0] + sizes[1], 14 + sizes[0] + sizes[1], 17 + sizes[0] + sizes[1], 20 + sizes[0] + sizes[1], 23 + sizes[0] + sizes[1]],
					[]]

var wide_pcolors = [[0 + sizes[0] + sizes[1] + sizes[2], 1 + sizes[0] + sizes[1] + sizes[2], 2 + sizes[0] + sizes[1] + sizes[2], 12 + sizes[0] + sizes[1] + sizes[2], 13 + sizes[0] + sizes[1] + sizes[2], 14 + sizes[0] + sizes[1] + sizes[2]],
					[3 + sizes[0] + sizes[1] + sizes[2], 4 + sizes[0] + sizes[1] + sizes[2], 5 + sizes[0] + sizes[1] + sizes[2], 15 + sizes[0] + sizes[1] + sizes[2], 16 + sizes[0] + sizes[1] + sizes[2], 17 + sizes[0] + sizes[1] + sizes[2]],
					[6 + sizes[0] + sizes[1] + sizes[2], 7 + sizes[0] + sizes[1] + sizes[2], 8 + sizes[0] + sizes[1] + sizes[2], 18 + sizes[0] + sizes[1] + sizes[2], 19 + sizes[0] + sizes[1] + sizes[2], 20 + sizes[0] + sizes[1] + sizes[2]],
					[9 + sizes[0] + sizes[1] + sizes[2], 10 + sizes[0] + sizes[1] + sizes[2], 11 + sizes[0] + sizes[1] + sizes[2], 21 + sizes[0] + sizes[1] + sizes[2], 22 + sizes[0] + sizes[1] + sizes[2], 23 + sizes[0] + sizes[1] + sizes[2]]]

var wide_ribons = [[0 + sizes[0] + sizes[1] + sizes[2], 1 + sizes[0] + sizes[1] + sizes[2], 2 + sizes[0] + sizes[1] + sizes[2], 3 + sizes[0] + sizes[1] + sizes[2], 4 + sizes[0] + sizes[1] + sizes[2], 5 + sizes[0] + sizes[1] + sizes[2]],
				   [15 + sizes[0] + sizes[1] + sizes[2], 16 + sizes[0] + sizes[1] + sizes[2], 17 + sizes[0] + sizes[1] + sizes[2], 18 + sizes[0] + sizes[1] + sizes[2], 19 + sizes[0] + sizes[1] + sizes[2], 20 + sizes[0] + sizes[1] + sizes[2]],
				   [6 + sizes[0] + sizes[1] + sizes[2], 7 + sizes[0] + sizes[1] + sizes[2], 8 + sizes[0] + sizes[1] + sizes[2], 9 + sizes[0] + sizes[1] + sizes[2], 10 + sizes[0] + sizes[1] + sizes[2], 11 + sizes[0] + sizes[1] + sizes[2]],
				   [12 + sizes[0] + sizes[1] + sizes[2], 13 + sizes[0] + sizes[1] + sizes[2], 14 + sizes[0] + sizes[1] + sizes[2], 21 + sizes[0] + sizes[1] + sizes[2], 22 + sizes[0] + sizes[1] + sizes[2], 23 + sizes[0] + sizes[1] + sizes[2]]]

var wide_patterns = [[0 + sizes[0] + sizes[1] + sizes[2], 3 + sizes[0] + sizes[1] + sizes[2], 6 + sizes[0] + sizes[1] + sizes[2], 9 + sizes[0] + sizes[1] + sizes[2], 12 + sizes[0] + sizes[1] + sizes[2], 15 + sizes[0] + sizes[1] + sizes[2], 18 + sizes[0] + sizes[1] + sizes[2], 21 + sizes[0] + sizes[1] + sizes[2]],
					 [1 + sizes[0] + sizes[1] + sizes[2], 4 + sizes[0] + sizes[1] + sizes[2], 7 + sizes[0] + sizes[1] + sizes[2], 10 + sizes[0] + sizes[1] + sizes[2], 13 + sizes[0] + sizes[1] + sizes[2], 16 + sizes[0] + sizes[1] + sizes[2], 19 + sizes[0] + sizes[1] + sizes[2], 22 + sizes[0] + sizes[1] + sizes[2]],
					 [],
					 [2 + sizes[0] + sizes[1] + sizes[2], 5 + sizes[0] + sizes[1] + sizes[2], 8 + sizes[0] + sizes[1] + sizes[2], 11 + sizes[0] + sizes[1] + sizes[2], 14 + sizes[0] + sizes[1] + sizes[2], 17 + sizes[0] + sizes[1] + sizes[2], 20 + sizes[0] + sizes[1] + sizes[2], 23 + sizes[0] + sizes[1] + sizes[2]]]

var Present = preload("res://src/Presents/present.gd")

var rules = [null, null, null, null]

func _ready():
	randomize()


func set_rule(new_rule, id) -> void:
	rules[id] = new_rule


func generate_new_present_ids(current_rule : int) -> int:
	var available_presents = []
	
	# Remove all presents that fit more than one rule
	match rules[current_rule]:
		Size.SMALL:
			for o in range(sizes[0]):
				available_presents.append(o)
		Size.MEDIUM:
			for o in range(sizes[1]):
				available_presents.append(o + sizes[0])
		Size.BIG:
			for o in range(sizes[2]):
				available_presents.append(o + sizes[0] + sizes[1])
		Size.WIDE:
			for o in range(sizes[3]):
				available_presents.append(o + sizes[0] + sizes[1] + sizes[2])
		Pattern.VERTICAL:
			available_presents.append_array(small_patterns[0])
			available_presents.append_array(medium_patterns[0])
			available_presents.append_array(big_patterns[0])
			available_presents.append_array(wide_patterns[0])
		Pattern.NONE:
			available_presents.append_array(small_patterns[1])
			available_presents.append_array(medium_patterns[1])
			available_presents.append_array(big_patterns[1])
			available_presents.append_array(wide_patterns[1])
		Pattern.HORIZONTAL:
			available_presents.append_array(small_patterns[2])
			available_presents.append_array(medium_patterns[2])
			available_presents.append_array(big_patterns[2])
			available_presents.append_array(wide_patterns[2])
		Pattern.CHECKED:
			available_presents.append_array(small_patterns[3])
			available_presents.append_array(medium_patterns[3])
			available_presents.append_array(big_patterns[3])
			available_presents.append_array(wide_patterns[3])
		Ribbon.YELLOW:
			available_presents.append_array(small_ribons[0])
			available_presents.append_array(medium_ribons[0])
			available_presents.append_array(big_ribons[0])
			available_presents.append_array(wide_ribons[0])
		Ribbon.GREEN:
			available_presents.append_array(small_ribons[1])
			available_presents.append_array(medium_ribons[1])
			available_presents.append_array(big_ribons[1])
			available_presents.append_array(wide_ribons[1])
		Ribbon.PURPLE:
			available_presents.append_array(small_ribons[2])
			available_presents.append_array(medium_ribons[2])
			available_presents.append_array(big_ribons[2])
			available_presents.append_array(wide_ribons[2])
		Ribbon.PINK:
			available_presents.append_array(small_ribons[3])
			available_presents.append_array(medium_ribons[3])
			available_presents.append_array(big_ribons[3])
			available_presents.append_array(wide_ribons[3])
		PColor.RED:
			available_presents.append_array(small_pcolors[0])
			available_presents.append_array(medium_pcolors[0])
			available_presents.append_array(big_pcolors[0])
			available_presents.append_array(wide_pcolors[0])
		PColor.GREEN:
			available_presents.append_array(small_pcolors[1])
			available_presents.append_array(medium_pcolors[1])
			available_presents.append_array(big_pcolors[1])
			available_presents.append_array(wide_pcolors[1])
		PColor.BLUE:
			available_presents.append_array(small_pcolors[2])
			available_presents.append_array(medium_pcolors[2])
			available_presents.append_array(big_pcolors[2])
			available_presents.append_array(wide_pcolors[2])
		PColor.PINK:
			available_presents.append_array(small_pcolors[3])
			available_presents.append_array(medium_pcolors[3])
			available_presents.append_array(big_pcolors[3])
			available_presents.append_array(wide_pcolors[3])
	
	return available_presents


func generate_new_present(current_rule : int):
	var available_presents = generate_new_present_ids(current_rule)
	var id : int = available_presents[randi() % available_presents.size()]
	var present
	
	if id < sizes[0]:
		present = small_present.instance()
	elif id < sizes[0] + sizes[1]:
		present = medium_present.instance()
		id -= sizes[0]
	elif id < sizes[0] + sizes[1] + sizes[2]:
		present = big_present.instance()
		id -= sizes[0] + sizes[1]
	else:
		present = wide_present.instance()
		id -= sizes[0] + sizes[1] + sizes[2]
	
	present.set_frame(id)
	return present


func generate_new_present_random():
	return generate_new_present(randi() % 4)


func generate_new_present_following_rule(rule):
	return generate_new_present(rule)
