extends Area2D

const SPEED = 600

var velocity = Vector2()
var direction = -1


func _physics_process(delta):
	velocity.x = SPEED * delta * direction
	translate(velocity)


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_Cake_body_entered(body):
	if body.name == 'Player':
		body.hurt(position.x, 2)
