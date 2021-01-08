extends Area2D

signal postman_coin_collected

func _on_postman_coin_body_entered(body):
	$AnimationPlayer.play("bounce")
	$AudioStreamPlayer2DCollected.play()
	emit_signal("postman_coin_collected")
	set_collision_mask_bit(0, false)
	

func _on_AudioStreamPlayer2DCollected_finished():
	queue_free()
