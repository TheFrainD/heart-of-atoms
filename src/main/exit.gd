extends Area2D

func _on_body_entered(body):
	Events.emit_signal("game_won")
