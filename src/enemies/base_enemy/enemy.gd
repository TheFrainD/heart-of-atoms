extends KinematicBody2D
class_name Enemy

export var initial_horizontal_velocity: = 1.0

const FLOOR_NORMAL: = Vector2.UP

onready var state_machine: StateMachine = $StateMachine

onready var collider: CollisionShape2D = $CollisionShape2D
onready var animation_tree: AnimationTree = $AnimationTree
onready var animation_state = animation_tree.get("parameters/playback")
onready var sprite: = $Sprite
onready var player: = get_tree().current_scene.get_node("Player")
onready var bullet_emitter: = $GunPivot/BulletEmitter

var is_active: = true setget set_is_active
var health: = 100.0 setget set_health
var horizontal_direction: = 1.0

func _ready():
	state_machine.set_physics_process(false)
	
func _on_screen_entered():
	state_machine.set_physics_process(true)

func set_health(value: float) -> void:
	health = value
	if health <= 0:
		die()


func die() -> void:
	state_machine.transition_to("Move/Die")

func destroy():
	queue_free()


func set_is_active(value: bool) -> void:
	is_active = value
	if not collider:
		return
	collider.set_deferred("disabled", not value)


func _on_hurtbox_area_entered(area):
	self.health -= area.damage
