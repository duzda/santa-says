extends RigidBody2D

enum PresentSize {SMALL, MEDIUM, BIG, WIDE}

export(PresentSize) var present_size setget set_size
export var player_node_path : NodePath = "../../Player"
export var container_node_path : NodePath = ".."
export var health_indicator_node_path : NodePath = "../../HealthIndicator"

export var tray_group := "tray"

onready var outline_material = preload("res://src/Presents/outline_material.tres")

var player
var container
var health_indicator

func _ready():
	player = get_node(player_node_path)
	container = get_node(container_node_path)
	health_indicator = get_node(health_indicator_node_path)


func _on_mouse_entered():
	if !player.attached and not health_indicator.game_disabled:
		$Sprite.material = outline_material


func _on_mouse_exited():
	$Sprite.material = null


func _on_input_event(_viewport, event, _shape_idx):
	if health_indicator.game_disabled:
		return
	
	if event is InputEventMouseButton and \
		event.button_index == BUTTON_LEFT and \
		event.is_action_pressed("ui_accept") and \
		not player.attached and \
		self.position.distance_to(player.position) < player.arm_length:
			player.attach_present(self)


func make_example() -> void:
	self.disable_collision()
	match self.present_size:
		PresentSize.BIG:
			self.position = Vector2(66, 64)
		PresentSize.MEDIUM:
			self.position = Vector2(66, 64)
		PresentSize.SMALL:
			self.position = Vector2(66, 64)
		PresentSize.WIDE:
			self.position = Vector2(66, 64)
		
	var signals = self.get_signal_list()
	for s in signals:
		var conns = self.get_signal_connection_list(s.name)
		for cur_conn in conns:
			self.disconnect(cur_conn.signal, cur_conn.target, cur_conn.method)
	self.set_mode(RigidBody2D.MODE_STATIC)
	self.set_script(null)


func set_size(size) -> void:
	present_size = size


func disable_collision() -> void:
	self.set_collision_layer_bit(0, false)
	self.set_collision_layer_bit(1, false)
	self.set_collision_mask_bit(0, false)


func enable_collision() -> void:
	self.set_collision_layer_bit(0, true)
	self.set_collision_layer_bit(1, true)
	self.set_collision_mask_bit(0, true)


func attach(object) -> void:
	self.disable_collision()
	self.set_mode(RigidBody2D.MODE_STATIC)
	self.position = get_attachement_position()
	self.rotation = 0
	self.get_parent().remove_child(self)
	object.add_child(self)


func dettach(throw_direction) -> void:
	self.enable_collision()
	self.set_mode(RigidBody2D.MODE_RIGID)
	var global_position = self.global_position
	self.get_parent().remove_child(self)
	self.container.add_child(self)
	self.position = global_position
	self.set_linear_velocity(throw_direction)


func get_attachement_position() -> Vector2:
	match self.present_size:
		PresentSize.BIG:
			return Vector2(-22, -24) * _flip_offset()
		PresentSize.MEDIUM:
			return Vector2(-22, -18) * _flip_offset()
		PresentSize.SMALL:
			return Vector2(-22, -14) * _flip_offset()
		PresentSize.WIDE:
			return Vector2(-22, -14) * _flip_offset()
		_:
			return Vector2(0, 0)


func _flip_offset() -> Vector2:
	return Vector2(-1, 1) if player.is_flipped_h() else Vector2(1, 1)


func set_frame(frame : int) -> void:
	$Sprite.frame = frame


func get_frame() -> int:
	return $Sprite.frame


func pipe_unfreeze() -> void:
	self.z_index = 1
	self.enable_collision()
