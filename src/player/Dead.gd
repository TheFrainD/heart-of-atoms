extends State

const GRAVITY: = 150.0

func physics_process(delta: float) -> void:
	owner.sprite.offset.y += GRAVITY * delta

func enter(msg: Dictionary = {}) -> void:
	owner.animation_state.travel("die")
