extends State

export var acceleration_x: = 4000.0

onready var move: = get_parent()

func process(delta: float) -> void:
	pass

func physics_process(delta: float) -> void:
	move.physics_process(delta)
	
	if owner.is_on_floor():
		_state_machine.transition_to("Move/Walk")

func enter(msg: Dictionary = {}) -> void:
	move.enter(msg)
	
	owner.animation_state.travel("fall")

func exit() -> void:
	move.exit()
