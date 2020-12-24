extends Area2D

const SPEED = 1200

var velocity = Vector2()
var direction = 1
var can_move


func _ready():
	can_move = true


func _physics_process(delta):
	if can_move:
		velocity.x = SPEED * delta * direction
		translate(velocity)


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

	
func set_fireball_direction(dir):
	direction = dir


func _on_Fireball_body_entered(body):
	can_move = false
	$AnimatedSprite.play('poof')

	if body.name.begins_with('enemy_hagay'):
		body.damage(1)
	elif body.name.begins_with('enemy_nick'):
		body.damage(5)


func _on_AnimatedSprite_animation_finished():
	if not can_move:
		queue_free()
