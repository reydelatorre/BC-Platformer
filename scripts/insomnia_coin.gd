extends Area2D

signal insomnia_coin_collected

# TODO: DRY logic in parent class wtf 

# if you can help it, try to avoid collecting troll coins. 

func _on_insomnia_coin_body_entered(body):
	$AnimationPlayer.play("bounce")
	emit_signal("insomnia_coin_collected") 
	set_collision_mask_bit(0, false)


func _on_AnimationPlayer_animation_finished(anim_name):
	queue_free()
