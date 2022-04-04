extends StaticBody2D

onready var animation_player: = $AnimationPlayer

func _on_body_entered(body):
	animation_player.play("open")
