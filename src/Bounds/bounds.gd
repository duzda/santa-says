extends Area2D

export var present_spawner_node_path : NodePath
export var health_indicator_node_path : NodePath

onready var Present = preload("res://src/Presents/present.gd")
onready var PresentFactory = get_node("/root/PresentFactory")

export (int) var tray_id

var present_spawner
var health_indicator

var valid_presents = []
var valid_old_presents = []
var accept_old_presents := false

func _ready():
	present_spawner = get_node(present_spawner_node_path)
	health_indicator = get_node(health_indicator_node_path)


func _on_body_entered(body):
	if health_indicator.game_disabled:
		return
		
	if body is KinematicBody2D:
		body.pipe_freeze()
		body.position = present_spawner.position
	elif body is RigidBody2D:
		var present_id = get_present_id(body)
		if present_id in valid_presents or (accept_old_presents and present_id in valid_old_presents):
			present_spawner.add_score()
		else:
			health_indicator.remove_health()
		body.queue_free()


func get_present_id(body) -> int:
	match body.present_size:
		Present.PresentSize.SMALL:
			return body.get_frame()
		Present.PresentSize.MEDIUM:
			return body.get_frame() + PresentFactory.sizes[0]
		Present.PresentSize.BIG:
			return body.get_frame() + PresentFactory.sizes[0] + PresentFactory.sizes[1]
		Present.PresentSize.WIDE:
			return body.get_frame() + PresentFactory.sizes[0] + PresentFactory.sizes[1] + PresentFactory.sizes[2]
		_:
			return -1


func invoke_new_valid_presents() -> void:
	valid_old_presents = [] + valid_presents
	valid_presents = [] + PresentFactory.generate_new_present_ids(tray_id)
	accept_old_presents = true
	$Timer.wait_time = 3
	$Timer.start()


func _on_Timer_timeout():
	accept_old_presents = false
