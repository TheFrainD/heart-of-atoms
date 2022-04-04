extends State

export var speed: = 70
export var detection_range: = 180.0

const GRAVITY: = 1500.0

onready var velocity: = Vector2(speed * owner.initial_horizontal_velocity, 1.0)
var is_player_in_range: = false

func process(delta: float) -> void:
	var distance_to_player: = abs(owner.global_position.x - owner.player.global_position.x)
	var is_player_on_line: = abs(owner.global_position.y - owner.player.global_position.y) <= 5
	is_player_in_range = distance_to_player <= detection_range and is_player_on_line

	if is_player_in_range and _state_machine._state_name != "Die":
		if distance_to_player < 30:
			velocity.x = 0.0
		else:
			velocity.x = get_follow_velocity_x()

		owner.bullet_emitter.start_firing()
	else:
		owner.bullet_emitter.stop_firing()

	if velocity.x != 0.0:
		owner.animation_tree.set("parameters/idle/blend_position", velocity.x)
		owner.animation_tree.set("parameters/walk/blend_position", velocity.x)
		owner.animation_tree.set("parameters/fall/blend_position", velocity.x)


func physics_process(delta: float) -> void:
	velocity.y += GRAVITY * delta
	if owner.is_on_wall():
		velocity.x *= -1
	velocity.y = owner.move_and_slide(velocity, owner.FLOOR_NORMAL).y


func get_follow_velocity_x() -> float:
	owner.horizontal_direction = 1.0 if owner.global_position.x < owner.player.global_position.x else -1.0
	return owner.horizontal_direction * speed
