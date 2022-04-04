extends Node

signal player_health_updated
signal player_no_health
signal core_temperature_updated
signal coolers_amount_updated

const player_health_default: = 100.0

var player_health: = player_health_default setget set_player_health
var core_temperature: = 100.0 setget set_core_temperature
var coolers_amount: = 0 setget set_coolers_amount
var loaders_active: = 0 setget set_loaders_active

const MAX_TEMP: = 1000

var temp_growth_default: = 39

onready var temp_growth: = temp_growth_default

func set_player_health(value: float) -> void:
	player_health = value
	emit_signal("player_health_updated")
	if player_health <= 0.0:
		emit_signal("player_no_health")
	elif player_health > 100:
		player_health = 100


func set_core_temperature(value: float) -> void:
	core_temperature = max(0, value)
	emit_signal("core_temperature_updated")
	if core_temperature >= MAX_TEMP:
		Events.emit_signal("core_exploded")


func set_coolers_amount(value: int) -> void:
	coolers_amount = value
	emit_signal("coolers_amount_updated")


func set_loaders_active(value: int) -> void:
	loaders_active = value
	if loaders_active < 0:
		loaders_active = 0


func _process(delta: float) -> void:
	if loaders_active == 0:
		self.core_temperature += delta * (temp_growth * (core_temperature / MAX_TEMP))


func reload():
	self.player_health = player_health_default
	self.core_temperature = 100.0
	self.coolers_amount = 0
	self.loaders_active = 0 
