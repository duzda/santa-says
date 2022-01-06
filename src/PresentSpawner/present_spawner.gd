extends Node2D

onready var PresentFactory = get_node("/root/PresentFactory")

export var container_node_path : NodePath
export var score_label_node_path : NodePath

var container
var score_label

var score : int = 0

func _ready():
	container = get_node(container_node_path)
	score_label = get_node(score_label_node_path)
	$Timer.start()


func add_score():
	self.score += 1
	self.score_label.text = str(self.score)
	self.score_label.align = HALIGN_CENTER


func _on_Timer_timeout():
	self.generate_present()
	
	match self.score:
		0, 1, 2, 3, 4:
			$Timer.wait_time = rand_range(2.5, 5)
		5, 6, 7, 8, 9:
			$Timer.wait_time = rand_range(2, 4)
		10, 11, 12, 13, 14, 15, 16, 17, 18, 19:
			$Timer.wait_time = rand_range(1.5, 3)
		20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34:
			$Timer.wait_time = rand_range(1, 2)
		_:
			$Timer.wait_time = rand_range(1, 1.5)


func generate_present() -> void:
	var present = PresentFactory.generate_new_present_random()
	present.position = self.position
	container.add_child(present)
