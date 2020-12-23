extends KinematicBody2D

var alive = true
var animation_state

onready var animated_sprite = $AnimatedSprite
onready var area2d_top_hit = $Area2D_Top_Hit
onready var raycast2d_player_in_view = $RayCast2D

var animation_utils_instance = animation_utils.new()

func _on_Area2D_Top_Hit_body_entered(body):
	body.bounce()
	
	alive = false
	
	set_collision_layer_bit(4, false)
	set_collision_mask_bit(0, false)
	area2d_top_hit.set_collision_layer_bit(4, false)
	area2d_top_hit.set_collision_mask_bit(0, false)

func _on_AnimatedSprite_animation_finished():
	if !alive:
		queue_free()

func _process(delta):
	animation_state = 'idle'
	
	if raycast2d_player_in_view.is_colliding():
		animation_state = 'fire'
		
	if alive == false:
		animation_state = 'explode'
		
	animation_utils_instance.process_animation(animated_sprite, animation_state)
		
