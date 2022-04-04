extends KinematicBody2D
class_name Player

export var pick_up_sound: AudioStream
export var die_sound: AudioStream

onready var state_machine: StateMachine = $StateMachine

onready var sprite: = $Sprite
onready var collider: CollisionShape2D = $CollisionShape2D
onready var hurtbox: = $Hurtbox/CollisionShape2D
onready var animation_tree: AnimationTree = $AnimationTree
onready var animation_state = animation_tree.get("parameters/playback")
onready var bullet_emmiter = $GunPivot/BulletEmitter
onready var death_timer: = $DeathTimer
onready var audio_player: = $AudioStreamPlayer
onready var blink: = $BlinkAnimationPlayer

const FLOOR_NORMAL: = Vector2.UP

var is_active: = true setget set_is_active
var horizontal_direction: = 1.0

func _ready():
	PlayerData.reload()
	PlayerData.connect("player_no_health", self, "die")

func _process(delta):
	print(state_machine._state_name)

func die():
	state_machine.transition_to("Dead")
	self.is_active = false
	death_timer.start()
	audio_player.stream = die_sound
	audio_player.play()

func set_is_active(value: bool) -> void:
	is_active = value
	if not collider:
		return
	collider.set_deferred("disabled", not value)
	hurtbox.set_deferred("disabled", not value)


func _on_hurtbox_area_entered(area):
	PlayerData.player_health -= area.damage
	blink.play("blink")


func _on_death_timer_timeout():
	Events.emit_signal("player_died")
