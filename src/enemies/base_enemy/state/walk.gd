extends State

onready var move: = get_parent()

func process(delta: float) -> void:
	move.process(delta)


func physics_process(delta: float) -> void:
	if not owner.is_on_floor():
		_state_machine.transition_to("Move/Air")
		
	if move.velocity.x == 0:
		_state_machine.transition_to("Move/Idle")
	
	move.physics_process(delta)


func enter(msg: Dictionary = {}) -> void:
	move.enter(msg)
	owner.animation_state.travel("walk")


func exit() -> void:
	move.exit()
