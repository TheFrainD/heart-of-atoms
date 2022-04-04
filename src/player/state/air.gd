extends State

export var acceleration_x: = 4000.0

onready var move: = get_parent()

func unhandled_input(event: InputEvent) -> void:
	move.unhandled_input(event)

func process(delta: float) -> void:
	move.process(delta)

func physics_process(delta: float) -> void:
	move.physics_process(delta)
	
	if owner.is_on_floor():
		var target_state: = "Move/Idle" if move.get_move_direction().x == 0.0 else "Move/Run"
		_state_machine.transition_to(target_state)

func enter(msg: Dictionary = {}) -> void:
	move.enter(msg)
	move.acceleration.x = acceleration_x
	
	if "velocity" in msg:
		move.velocity = msg.velocity
		move.max_speed.x = max(abs(msg.velocity.x), move.max_speed_default.x)
	
	if "force" in msg:
		move.velocity += calculate_jump_velocity(msg.force)
		
	owner.animation_state.travel("jump")

func exit() -> void:
	move.exit()
	move.acceleration = move.acceleration_default

func calculate_jump_velocity(force: = 0.0) -> Vector2:
	return move.calculate_velocity(
		move.velocity,
		move.max_speed,
		Vector2(0.0, force),
		1.0,
		Vector2.UP
	)
