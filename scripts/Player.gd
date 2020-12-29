extends KinematicBody2D

const SPEED = 300
const GRAVITY = 18
const JUMPFORCE = -480
const BOUNCEFORCE = -420
const LERPSPEED = 0.2
const MAX_HITPOINTS = 10

const FIREBALL = preload("res://scenes/Fireball.tscn")

enum PlayerDirection {
	LEFT = -1,
	RIGHT = 1
}

var double_jump_count = 1
var player_facing = PlayerDirection.RIGHT

var velocity = Vector2(0, 0)
export var hit_points = MAX_HITPOINTS

signal mark_hurt


func _physics_process(delta) -> void:
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
		$AudioStreamPlayer2DFire.play()
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
		$AudioStreamPlayer2DJump.play()
	elif Input.is_action_just_pressed("jump") and not is_on_floor() and double_jump_count > 0:
		velocity.y = JUMPFORCE
		$AudioStreamPlayer2DJump.play()
		double_jump_count = double_jump_count - 1
	
	if is_on_floor():
		double_jump_count = 1
	else:
		$AnimatedSprite.play("jump")


func bounce():
	velocity.y = BOUNCEFORCE
	

func hurt(var enemy_pos_x, amount):
	$AudioStreamPlayer2DHurt.play()
	
	emit_signal('mark_hurt', amount)

	velocity.y = JUMPFORCE * 0.5
	
	if position.x < enemy_pos_x:
		velocity.x = -800
	elif position.x > enemy_pos_x:
		velocity.x = 800
		
	Input.action_release("left")
	Input.action_release("right")
	
	hit_points -= amount

	if hit_points <= 0:
		$Timer.start()
