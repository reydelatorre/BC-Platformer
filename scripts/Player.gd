extends KinematicBody2D

const SPEED = 280
const GRAVITY = 18
const JUMPFORCE = -480
const LERPSPEED = 0.2

var double_jump_count = 1

var velocity = Vector2(0, 0)

# if player chooses Postman: 
# you will now suffer the gravity of the situation
# increase gravity by 80
# andrew thumbsdown pic


func process_jump():
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMPFORCE
	elif Input.is_action_just_pressed("jump") and not is_on_floor() and double_jump_count > 0:
		velocity.y = JUMPFORCE
		double_jump_count = double_jump_count - 1
	
	if is_on_floor():
		double_jump_count = 1
	else:
		$AnimatedSprite.play("jump")
	

func _physics_process(delta):
	if not is_on_floor():		
		velocity.y += GRAVITY
	
	if Input.is_action_pressed("right"):		
		velocity.x = SPEED
		$AnimatedSprite.play("run")
		$AnimatedSprite.flip_h = false
	elif Input.is_action_pressed("left"):
		velocity.x = -SPEED
		$AnimatedSprite.play("run")
		$AnimatedSprite.flip_h = true
	else:
		$AnimatedSprite.play("idle")
	
	process_jump()
		
	move_and_slide(velocity, Vector2.UP)

	velocity.x = lerp(velocity.x, 0, LERPSPEED)


func _on_area2d__fallzone_body_entered(body):
	if (body.get_name() == "Player"):
		get_tree().change_scene("res://Level01.tscn")
