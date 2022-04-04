extends TextureProgress

export var max_temp_color = Color(1, 0, 0)
export var high_temp_color = Color(1, 0.7, 0)
export var medium_temp_color = Color(1, 1, 0)
export var low_temp_color = Color(0.49, 1, 0)

func _ready() -> void:
	max_value = PlayerData.MAX_TEMP

func update_color() -> void:
	var normalized_value = value / max_value
	if normalized_value <= 0.25:
		set_tint_progress(low_temp_color)
	elif normalized_value <= 0.5:
		set_tint_progress(medium_temp_color)
	elif normalized_value <= 0.75:
		set_tint_progress(high_temp_color)
	else:
		set_tint_progress(max_temp_color)
