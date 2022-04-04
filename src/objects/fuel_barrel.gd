extends Area2D

onready var explosion_effect: = preload("res://src/effects/explosion.tscn")
onready var hitbox: = $ExplosionHitbox/CollisionShape2D
onready var timer: = $Timer
onready var sprite: = $Sprite


func _on_area_entered(area):
	if timer.is_stopped():
		EffectEmmiter.create_effect(self, explosion_effect, false)
		hitbox.set_deferred("disabled", false)
		timer.start()
		sprite.visible = false


func _on_timeout():
	queue_free()
