extends KinematicBody2D

var velocity = Vector2(0, 0)
var hit_points = 10
var alive = true
export var direction = 1
export var detect_edges = true

const GRAVITY = 20
const SPEED = 100

onready var animated_sprite = $AnimatedSprite
onready var collision_shape2d = $CollisionShape2D
onready var raycast2d = $RayCast2D


func _ready():
	animated_sprite.flip_h = (false if direction == 1 else true)
	raycast2d.position.x = collision_shape2d.shape.get_extents().x * direction
	raycast2d.enabled = detect_edges
	
	
func _physics_process(delta):
	apply_gravity()
	wall_collide()
		
	if alive:
		velocity.x = SPEED * direction
		velocity = move_and_slide(velocity, Vector2.UP)


func _on_Area2D_Sides_body_entered(body):
	if body.name == 'Player':
		body.hurt(position.x)


func _on_AnimatedSprite_animation_finished():
	if not alive:
		queue_free()

	
func damage(amount):
	hit_points -= amount

	if hit_points <= 0:
		$AnimatedSprite.play('explode')
		alive = false


func apply_gravity():
	if not is_on_floor():
		velocity.y += GRAVITY
	

func wall_collide():
	if is_on_wall() or not raycast2d.is_colliding() and detect_edges and is_on_floor():
		direction = direction * -1
		animated_sprite.flip_h = not animated_sprite.flip_h
		raycast2d.position.x = collision_shape2d.shape.get_extents().x * direction
