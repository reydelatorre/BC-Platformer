extends KinematicBody2D

var alive = true


func _on_Area2D_Top_Hit_body_entered(body):
	body.bounce()
	alive = false
	$AnimatedSprite.play('explode')
	set_collision_layer_bit(4, false)
	set_collision_mask_bit(0, false)
	$Area2D_Top_Hit.set_collision_layer_bit(4, false)
	$Area2D_Top_Hit.set_collision_mask_bit(0, false)


func _on_AnimatedSprite_animation_finished():
	if !alive:
		queue_free()
