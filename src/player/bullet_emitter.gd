extends Node2D

export var bullet: PackedScene
export(float, 0.0, 90.0) var fire_angle: = 48.0
export var fire_rays: = 6
export var fire_rate: = 0.15
export var damage: = 20.0
export var is_player: = true

onready var timer: = $Timer
onready var audio_player: = $AudioStreamPlayer

var _is_firing: = false

func _ready() -> void:
	timer.wait_time = fire_rate


func start_firing() -> void:
	if not _is_firing:
		_is_firing = true
		fire()
		timer.start()


func stop_firing() -> void:
	if _is_firing:
		_is_firing = false
		timer.stop()


func instantiate_bullet(direction: Vector2) -> void:
	var bullet_instance = bullet.instance()
	get_tree().current_scene.add_child(bullet_instance)
	bullet_instance.global_position = global_position
	bullet_instance.direction = direction
	bullet_instance.damage = damage


func fire() -> void:
	var direction = Vector2(owner.horizontal_direction, 0.0)
	
	audio_player.play()
	
	for i in range(fire_rays):
		instantiate_bullet(direction.rotated(deg2rad(-(fire_angle / 2) + (fire_angle / fire_rays) * i)))


func _on_timeout() -> void:
	fire()
