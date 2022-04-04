extends Node2D

export var speed: = 50

onready var saw: = $Saw
onready var first_point: = $FirstPoint
onready var second_point: = $SecondPoint

onready var direction: Vector2 = (first_point.global_position - saw.global_position).normalized()
var current_point: = 1

func _physics_process(delta):
	saw.global_position += direction * speed * delta

func switch_direction():
	current_point *= -1
	match current_point:
		1:
			direction = (first_point.global_position - saw.global_position).normalized()
		-1:
			direction = (second_point.global_position - saw.global_position).normalized()


func _on_area_entered(area):
	if area.owner.name != "Player":
		switch_direction()
