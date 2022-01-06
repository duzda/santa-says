extends Node2D

onready var PresentFactory = get_node("/root/PresentFactory")

export var tray_bounds_node_path : NodePath

export (int) var tray_id

var labels = ["Pattern", "Size", "Color", "Ribbon"]

var tray_bounds

var example_present

func _ready():
	tray_bounds = get_node(tray_bounds_node_path)
	$Timer.wait_time = rand_range(10, 20)
	generate_new_rule()
	$Timer.start()


func generate_new_rule():
	var rule = randi() % 16
	
	$Label.text = labels[int(rule / 4)]
	$Label.align = Label.ALIGN_CENTER
	$Label.valign = Label.VALIGN_CENTER
	
	var rule_enum 
	
	match rule:
		0:
			rule_enum = PresentFactory.Pattern.VERTICAL
		1:
			rule_enum = PresentFactory.Pattern.NONE
		2:
			rule_enum = PresentFactory.Pattern.HORIZONTAL
		3:
			rule_enum = PresentFactory.Pattern.CHECKED
		4:
			rule_enum = PresentFactory.Size.SMALL
		5:
			rule_enum = PresentFactory.Size.MEDIUM
		6:
			rule_enum = PresentFactory.Size.BIG
		7:
			rule_enum = PresentFactory.Size.WIDE
		8:
			rule_enum = PresentFactory.PColor.RED
		9:
			rule_enum = PresentFactory.PColor.GREEN
		10:
			rule_enum = PresentFactory.PColor.BLUE
		11:
			rule_enum = PresentFactory.PColor.PINK
		12:
			rule_enum = PresentFactory.Ribbon.YELLOW
		13:
			rule_enum = PresentFactory.Ribbon.GREEN
		14:
			rule_enum = PresentFactory.Ribbon.PURPLE
		15:
			rule_enum = PresentFactory.Ribbon.PINK
	
	PresentFactory.set_rule(rule_enum, tray_id)
	tray_bounds.invoke_new_valid_presents()
	_show_example_present()
	$Timer.wait_time = rand_range(10, 20)


func _show_example_present():
	if example_present:
		self.remove_child(example_present)
		
	example_present = PresentFactory.generate_new_present_following_rule(tray_id)
	example_present.make_example()
	self.add_child(example_present)


func _on_Timer_timeout():
	generate_new_rule()
