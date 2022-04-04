extends State

onready var move: = get_parent()

func unhandled_input(event: InputEvent) -> void:
	move.unhandled_input(event)


func process(delta: float) -> void:
	move.process(delta)

func physics_process(delta: float) -> void:
	if owner.is_on_floor():
		if move.get_move_direction().x != 0.0:
			_state_machine.transition_to("Move/Run")
	else:
		_state_machine.transition_to("Move/Air")

func enter(msg: Dictionary = {}) -> void:
	move.enter(msg)
	
	move.max_speed = move.max_speed_default
	move.velocity = Vector2.ZERO
	
	owner.animation_state.travel("idle")

func exit() -> void:
	move.exit()
