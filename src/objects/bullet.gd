extends Area2D

export var speed: = 500.0
export var damage: = 20.0

var direction: = Vector2.RIGHT

var distance_passed: = 0.0

func _physics_process(delta: float) -> void:
	var move: = direction * speed * delta
	
	position += move
	distance_passed += move.length()
	
	if distance_passed >= 200.0:
		queue_free()

func _on_body_entered(body):
	queue_free()
