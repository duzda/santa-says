extends AnimatedSprite

var colliding_bodies : int = 0

func _ready():
	if not self.flip_h:
		$Area2D.gravity_vec *= -1


func start():
	self.playing = true
	$Area2D.space_override = Area2D.SPACE_OVERRIDE_COMBINE


func pause():
	self.playing = false
	$Area2D.space_override = Area2D.SPACE_OVERRIDE_DISABLED


func _on_body_entered(body):
	colliding_bodies += 1
	if body is RigidBody2D:
		body.friction = 0.3
	elif body is KinematicBody2D:
		body.on_tray = 1 if self.flip_h else -1
	if not self.playing:
		self.start()


func _on_body_exited(body):
	colliding_bodies -= 1
	if body is RigidBody2D:
		body.friction = 1.0
	elif body is KinematicBody2D:
		body.on_tray = 0
	if colliding_bodies == 0:
		self.pause()
