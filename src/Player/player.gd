extends KinematicBody2D

export (int) var speed = 1200
export (int) var jump_force = -1800
export (int) var gravity = 4000

export (float, 0, 1.0) var friction = 0.1
export (float, 0, 1.0) var acceleration = 0.25
export (float) var arm_length = 200
export (float) var throw_power = 200
export (float) var drop_power = 50

export var health_indicator_node_path : NodePath
export var tray_group := "tray"

var health_indicator

var attached := false
var attached_present

var velocity := Vector2.ZERO
var on_tray : int = 0

var blocked_controls := false

func _ready():
	health_indicator = get_node(health_indicator_node_path)


func _physics_process(delta): 
	var dir : int
	if not blocked_controls and not health_indicator.game_disabled:
		dir = 0
		if Input.is_action_pressed("ui_right"):
			dir += 1
		if Input.is_action_pressed("ui_left"):
			dir -= 1
	if dir != 0:
		velocity.x = lerp(velocity.x, dir * speed, acceleration)
		$AnimatedSprite.flip_h = dir < 0;
		$AnimatedSprite/AnimationPlayer.play("walk", -1, 10)
	else:
		velocity.x = lerp(velocity.x, 0, friction)
	
	if on_tray != 0:
		velocity.x += 10 * on_tray
	
	if is_on_floor() and not health_indicator.game_disabled:
		if Input.is_action_just_pressed("ui_up"):
			$JumpSound.play()
			velocity.y = -jump_force
	
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP)


func _input(event):
	if health_indicator.game_disabled:
		return
		
	if event is InputEventMouseButton and \
		event.button_index == BUTTON_LEFT and \
		event.is_action_pressed("ui_accept") and \
		self.attached and \
		not self.blocked_controls:
			self.dettach_present(event.position, throw_power)
			$TossSound.play()
	if event is InputEventMouseButton and \
		event.button_index == BUTTON_RIGHT and \
		event.is_action_pressed("ui_drop") and \
		self.attached and \
		not self.blocked_controls:
			self.dettach_present(event.position, drop_power)


func attach_present(present) -> void:
	self.attached = true
	self.attached_present = present
	$AnimatedSprite.animation = "holding"
	present.attach(self)


func is_flipped_h() -> bool:
	return $AnimatedSprite.flip_h


func dettach_present(position: Vector2, power : float) -> void:
	self.attached_present.dettach(self.position.direction_to(position) * power + self.velocity / 10)
	$AnimatedSprite.animation = "default"
	self.attached_present = null
	self.attached = false


func pipe_freeze() -> void:
	self.z_index = 0
	self.blocked_controls = true
	self.velocity = Vector2(0, 0)


func pipe_unfreeze() -> void:
	self.z_index = 1
	self.blocked_controls = false
