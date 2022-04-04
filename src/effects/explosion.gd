extends Particles2D

func _on_timeout():
	queue_free()
