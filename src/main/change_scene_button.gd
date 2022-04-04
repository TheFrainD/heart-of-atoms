tool
extends Button

export(String, FILE) var next_scene_path: = ""

func _get_configuration_warning():
	return "The next scene path property must not be empty" if next_scene_path == "" else ""

func _on_button_up():
	get_tree().paused = false
	get_tree().change_scene(next_scene_path)
