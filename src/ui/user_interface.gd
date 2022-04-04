extends Control

onready var scene_tree: = get_tree()
onready var pause_menu: = $PauseMenu
onready var pause_label: = $PauseMenu/Label
onready var health_bar: TextureProgress = $Health/HealthBar
onready var temp_bar: TextureProgress = $Core/TempBar
onready var cooler_counter: Label = $Coolers/CoolerCounter
onready var animation_player: = $AnimationPlayer

var paused: = false setget set_paused

func _ready() -> void:
	PlayerData.connect("player_health_updated", self, "update_health_bar")
	PlayerData.connect("core_temperature_updated", self, "update_temp_bar")
	PlayerData.connect("coolers_amount_updated", self, "cooler_counter_update")
	Events.connect("player_died", self, "on_player_died")
	Events.connect("core_exploded", self, "on_core_exploded")
	Events.connect("game_won", self, "on_game_won")
	update_ui()

func on_player_died():
	self.paused = true
	pause_label.text = "You died"
	
func on_core_exploded():
	animation_player.play("explode")
	self.paused = true
	pause_label.text = "You lose"
	
func on_game_won():
	self.paused = true
	pause_label.text = "You won"

func update_ui() -> void:
	update_health_bar()
	update_temp_bar()
	cooler_counter_update()
	

func update_health_bar() -> void:
	health_bar.value = PlayerData.player_health


func update_temp_bar() -> void:
	temp_bar.value = PlayerData.core_temperature
	temp_bar.update_color()


func cooler_counter_update() -> void:
	cooler_counter.text = "%s" % PlayerData.coolers_amount

func _unhandled_input(event):
	if event.is_action_pressed("pause"):
		self.paused = not paused
		scene_tree.set_input_as_handled() 

func set_paused(value: bool):
	paused = value
	scene_tree.paused = value
	pause_menu.visible = value
