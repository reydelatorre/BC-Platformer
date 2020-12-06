extends Area2D

signal troll_coin_collected

# TODO: DRY logic in parent class wtf 

# if you can help it, try to avoid collecting troll coins. 

func _on_troll_coin_body_entered(body):
	emit_signal("troll_coin_collected") 
	set_collision_mask_bit(0, false)
	queue_free()
