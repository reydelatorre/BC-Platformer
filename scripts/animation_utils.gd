extends Node

class_name animation_utils

func process_animation(animated_sprite, animation_state):
	if animated_sprite.animation != animation_state:
		animated_sprite.play(animation_state)
