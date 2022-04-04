class_name EffectEmmiter

static func create_effect(node: Node2D, effect: PackedScene, local = true) -> Node2D:
	var effect_inst = effect.instance()
	if local:
		node.get_parent().add_child(effect_inst)
	else:
		node.get_tree().current_scene.add_child(effect_inst)
	effect_inst.global_position = node.global_position
	return effect_inst
