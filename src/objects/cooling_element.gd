extends Area2D

func _on_body_entered(body):
	PlayerData.coolers_amount += 1
	body.audio_player.stream = body.pick_up_sound
	body.audio_player.play()
	queue_free()
