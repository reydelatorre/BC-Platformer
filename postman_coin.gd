extends Area2D



func _on_postman_coin_body_entered(body):
	queue_free()
