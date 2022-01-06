extends Area2D


func _on_body_exited(body):
	body.pipe_unfreeze()
