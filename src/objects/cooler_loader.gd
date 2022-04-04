extends Area2D

onready var window: = $Window
onready var timer: = $Timer
onready var audio_player: = $AudioStreamPlayer

var _is_active: = false

func load_coolers() -> void:
	PlayerData.coolers_amount = 0


func activate_loader():
	if not _is_active:
		PlayerData.loaders_active += 1
		window.visible = true
		timer.wait_time = PlayerData.coolers_amount * 3
		timer.start()
		_is_active = true


func _on_body_entered(body) -> void:
	if PlayerData.coolers_amount != 0:
		activate_loader()
		load_coolers()
		audio_player.play()


func _on_timeout():
	PlayerData.loaders_active -= 1
	window.visible = false
	_is_active = false
