extends State

onready var move: = get_parent()

func process(delta: float) -> void:
	move.process(delta)

func physics_process(delta: float) -> void:
	if owner.is_on_floor():
		if move.velocity.x != 0.0:
			_state_machine.transition_to("Move/Walk")
	else:
		_state_machine.transition_to("Move/Air")

func enter(msg: Dictionary = {}) -> void:
	move.enter(msg)
	
	owner.animation_state.travel("idle")

func exit() -> void:
	move.exit()
