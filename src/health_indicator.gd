extends AnimatedSprite

var game_disabled := false
var current_animation : int = 0

var anim = ["health_1", "health_2", "health_3", "health_4", "health_5"]
onready var healths = [$Health1, $Health2, $Health3, $Health4, $Health5]
onready var anim_player = [$AnimationPlayer1, $AnimationPlayer2, $AnimationPlayer3, $AnimationPlayer4, $AnimationPlayer5]


func remove_health():
	anim_player[current_animation].play(anim[current_animation], -1, 1)
	healths[current_animation].show()
	current_animation += 1
	self.frame = current_animation
	if current_animation > 4:
		game_disabled = true
		$GameOver.show()
		$GameOverSound.play()


func _input(event):
	if game_disabled and event.is_action_pressed("restart"):
		get_tree().reload_current_scene()
