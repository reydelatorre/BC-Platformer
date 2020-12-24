extends KinematicBody2D

const SPEED = 280
const GRAVITY = 18
const JUMPFORCE = -480
const BOUNCEFORCE = -420
const LERPSPEED = 0.2

const FIREBALL = preload("res://scenes/Fireball.tscn")

enum PlayerDirection {
	LEFT = -1,
	RIGHT = 1
}

var double_jump_count = 1
var player_facing = PlayerDirection.RIGHT

var velocity = Vector2(0, 0)


func _physics_process(delta):
	if not is_on_floor():
		velocity.y += GRAVITY
	
	if Input.is_action_pressed("right"):
		player_facing = PlayerDirection.RIGHT
		velocity.x = SPEED
		$AnimatedSprite.play("run")
		$AnimatedSprite.flip_h = false
	elif Input.is_action_pressed("left"):
		player_facing = PlayerDirection.LEFT
		velocity.x = -SPEED
		$AnimatedSprite.play("run")
		$AnimatedSprite.flip_h = true
	else:
		$AnimatedSprite.play("idle")
		
	if Input.is_action_just_pressed("fire"):
		var fireball = FIREBALL.instance()
		
		fireball.set_fireball_direction(player_facing)
			
		get_parent().add_child(fireball)
		fireball.position = $Position2D.global_position
	
	process_jump()
		
	move_and_slide(velocity, Vector2.UP)

	velocity.x = lerp(velocity.x, 0, LERPSPEED)
	

func _on_area2d__fallzone_body_entered(body):
	if (body.get_name() == "Player"):
		get_tree().change_scene("res://scenes/GameOver.tscn")


func _on_Timer_timeout():
	get_tree().change_scene("res://scenes/GameOver.tscn")


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


func bounce():
	velocity.y = BOUNCEFORCE
	

func hurt(var enemy_pos_x):
	set_modulate(Color(1, 0.3, 0.3, 0.3))
	velocity.y = JUMPFORCE * 0.5
	
	if position.x < enemy_pos_x:
		velocity.x = -800
	elif position.x > enemy_pos_x:
		velocity.x = 800
		
	Input.action_release("left")
	Input.action_release("right")
	
	$Timer.start()