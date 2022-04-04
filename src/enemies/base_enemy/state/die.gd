extends State

onready var move: = get_parent()

func process(delta: float) -> void:
	move.process(delta)

func physics_process(delta: float) -> void:
	move.physics_process(delta)

func enter(msg: Dictionary = {}) -> void:
	move.enter(msg)
	move.velocity.x = 0.0
	
	owner.animation_state.travel("die")

func exit() -> void:
	move.exit()
