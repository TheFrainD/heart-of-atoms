extends State

export var max_speed_default: = Vector2(180.0, 1000.0)
export var acceleration_default: = Vector2(10000.0, 2000.0)
export var jump_force: = 550.0

var acceleration: = acceleration_default
var max_speed: = max_speed_default
var velocity: = Vector2.ZERO

func unhandled_input(event: InputEvent) -> void:
	if owner.is_on_floor() and event.is_action_pressed("jump"):
		_state_machine.transition_to("Move/Air", { force = jump_force })
	
	if event.is_action_pressed("fire"):
		owner.bullet_emmiter.start_firing()
		
	if event.is_action_released("fire"):
		owner.bullet_emmiter.stop_firing()

func process(delta: float) -> void:
	pass

func physics_process(delta: float) -> void:
	if owner.is_active:
		var move_direction_x = get_move_direction().x
		if move_direction_x != 0.0:
			owner.horizontal_direction = 1.0 if move_direction_x > 0 else -1.0
			
			owner.animation_tree.set("parameters/idle/blend_position", move_direction_x)
			owner.animation_tree.set("parameters/run/blend_position", move_direction_x)
			owner.animation_tree.set("parameters/jump/blend_position", move_direction_x)
		
		velocity = calculate_velocity(velocity, max_speed, acceleration, delta,
		get_move_direction())
	else:
		velocity = calculate_velocity(velocity, max_speed, acceleration, delta,
		Vector2.DOWN)
		
	velocity = owner.move_and_slide(velocity, owner.FLOOR_NORMAL)


static func calculate_velocity(
		old_velocity: Vector2,
		max_speed: Vector2,
		acceleration: Vector2,
		delta: float,
		move_direction: Vector2
	) -> Vector2:
	var new_velocity = old_velocity
	
	new_velocity += move_direction * acceleration * delta
	new_velocity.x = clamp(new_velocity.x, -max_speed.x, max_speed.x)
	new_velocity.y = clamp(new_velocity.y, -max_speed.y, max_speed.y)
	
	return new_velocity


static func get_move_direction() -> Vector2:
	return Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		1.0
	)
